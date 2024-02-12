const connection = require("../config/db.js");
const { validationResult } = require("express-validator");

const crearAlerta = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { usuario, trabajo, descripcion, ubicacion, fecha, estatus } =
      req.body;
    // const { trabajo, ubicacion } = req.body;

    const sql = `INSERT INTO sei_alertas (usuario, trabajo, descripcion, ubicacion, fecha, estatus)
    VALUES (?,?,?,?,?,?);`;

    const [resultado] = await connection.query(sql, [
      usuario,
      trabajo,
      descripcion,
      ubicacion,
      fecha,
      estatus,
    ]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ message: "Error al crear tu alerta" });
    }

    const coordenadas = ubicacion.split(",");
    // console.log(coordenadas);

    const sql_busqueda = `SELECT o.*, u.token
    FROM sei_oficio o
    LEFT JOIN sei_usuarios u ON o.usuario = u.id_usuario
    WHERE profesion LIKE ? AND ST_Distance_Sphere(
        POINT(?,?),
        POINT(SUBSTRING_INDEX(ubicacion, ',', -1), SUBSTRING_INDEX(ubicacion, ',', 1))
    ) / 1000 <10;`;

    const [trabajadores] = await connection.query(sql_busqueda, [
      `%${trabajo}%`,
      coordenadas[1],
      coordenadas[0],
    ]);

    //Falta notificar.

    trabajadores.map(async (trabajador) => {
      const sql_insertar = `INSERT INTO sei_alerta_oficio (alerta, oficio) VALUES (?,?);`;
      const [con] = await connection.query(sql_insertar, [
        resultado.insertId,
        trabajador.id_oficio,
      ]);
    });

    // console.log(trabajadores);
    return res.status(200).json({
      message:
        "Se creo la alerta con exito, se te notificara cuando sea aceptada",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const obtenerAlertasParaOficio = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { oficio } = req.body;
    const sql_obtener = `SELECT a.*,u.nombre,u.apellido_p, u.apellido_m, u.telefono, u.correo FROM sei_alerta_oficio o
    LEFT JOIN sei_alertas a ON o.alerta = a.id_alerta
    LEFT JOIN sei_usuarios u ON a.usuario = u.id_usuario
    WHERE oficio =?;`;

    const [ofertas] = await connection.query(sql_obtener, [oficio]);

    if (ofertas.length === 0) {
      return res.status(404).json({ message: "No hay alertas disponibles" });
    }

    return res.status(200).json(ofertas);
  } catch (error) {
    return res.status(500).json(error);
  }
};

const obtenerAlertasUsuario = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { usuario } = req.body;
    const sql_obtener = `SELECT * FROM sei_alertas WHERE usuario = ?`;

    const [alertas] = await connection.query(sql_obtener, [usuario]);

    if (alertas.length === 0) {
      return res.status(404).json({ message: "Sin alertas " });
    }

    return res.status(200).json(alertas);
  } catch (error) {
    return res.status(500).json(error);
  }
};

const aceptarAlerta = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { alerta, oficio } = req.body;
    const sql = `SELECT * FROM sei_alertas WHERE id_alerta = ?`;

    const [resultado] = (await connection.query(sql, [alerta]))[0];

    if (resultado.estatus === "Aceptada") {
      return res
        .status(404)
        .json({ message: "Oferta ya aceptada por alguien mas" });
    }

    const sql_update = `UPDATE sei_alertas SET estatus = 'Aceptada' WHERE id_alerta = ?`;

    const [actualizar] = await connection.query(sql_update, [alerta]);
    if (actualizar.affectedRows === 0) {
      return res.status(404).json({ message: "Error al aceptar la oferta" });
    }

    const sql_crearContacto = `INSERT INTO sei_contacto (oficio, usuario, fecha, mensaje, localizacion, estatus) 
    VALUES(?,?,?,?,?,'Aceptada');`;

    const [crear] = await connection.query(sql_crearContacto, [
      oficio,
      resultado.usuario,
      resultado.fecha,
      resultado.descripcion,
      resultado.ubicacion,
    ]);

    if (crear.affectedRows === 0) {
      const sql_update = `UPDATE sei_alertas SET estatus = 'Activo' WHERE id_alerta = ?`;
      await connection.query(sql_update, [alerta]);
      return res.status(404).json({ message: "Error al aceptar la oferta" });
    }
    return res.status(200).json({ message: "Oferta aceptada" });
  } catch (error) {
    return res.status(500).json(error);
  }
};

module.exports = {
  crearAlerta,
  obtenerAlertasUsuario,
  obtenerAlertasParaOficio,
  aceptarAlerta,
};

// const mandarAlerta = async (req, res) => {};
