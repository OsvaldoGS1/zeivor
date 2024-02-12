const connection = require("../config/db.js");
const { validationResult } = require("express-validator");

const agregarTrabajo = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { oficio, usuario, fecha, mensaje, localizacion, estatus } = req.body;

    const sql = `INSERT INTO sei_contacto (oficio, usuario, fecha, mensaje, localizacion, estatus) VALUES (?,?,?,?,?,?);`;

    const [resultado] = await connection.query(sql, [
      oficio,
      usuario,
      fecha,
      mensaje,
      localizacion,
      estatus,
    ]);

    if (resultado.affectedRows === 0) {
      return res
        .status(404)
        .json({ message: "Error al registar la oferta de trabajo" });
    }

    return res.status(200).json({ message: "Tu oferta ha sido enviada" });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const consultaOfertas = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { profesionista } = req.body;

    const sql = `SELECT c.id_contacto, c.fecha, c.mensaje, c.localizacion, c.estatus,c.estatus_trabajador, 
    c.estatus_cliente, u.id_usuario, u.nombre, u.apellido_p, u.apellido_m,u.correo, u.telefono, u.imagen, u.tipo 
    FROM sei_contacto c LEFT JOIN sei_usuarios u ON c.usuario = u.id_usuario 
    WHERE c.oficio = 2 ORDER BY c.fecha DESC;`;

    const [resultados] = await connection.query(sql, [profesionista]);

    if (resultados.length === 0) {
      return res.status(404).json({ message: "No hay ofertas de trabajo" });
    }

    return res.status(200).json(resultados);
  } catch (error) {
    return res.status(500).json({ message: "Error interno" });
  }
};

const aceptarOferta = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { oferta } = req.body;

    const [verificar] = (
      await connection.query(
        "SELECT * FROM sei_contacto WHERE id_contacto = ? AND estatus= 'Aceptada';",
        [oferta]
      )
    )[0];

    if (verificar) {
      return res.status(404).json({ message: "Oferta ya aceptada" });
    }

    const sql = `UPDATE sei_contacto SET estatus = ?  WHERE id_contacto =?`;

    const [resultado] = await connection.query(sql, ["Aceptada", oferta]);
    if (resultado.affectedRows === 0) {
      return res.status(404).json({ message: "Error al actualizar la oferta" });
    }

    return res.status(200).json({ message: "Oferta aceptada" });
  } catch (error) {
    return res.status(500).json({ message: "Error interno" });
  }
};

const cancelarOferta = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { contacto, motivo, fecha } = req.body;
    const sql_cancelacion = `INSERT INTO sei_cancelaciones(contacto, motivo, fecha) VALUES (
      ?,?,?);`;

    const sql_contacto = `UPDATE sei_contacto SET estatus = 'Cancelada' WHERE id_contacto = ?;`;

    const [resultado] = await connection.query(sql_cancelacion, [
      contacto,
      motivo,
      fecha,
    ]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ message: "Error al cancelar la oferta" });
    }

    await connection.query(sql_contacto, [contacto]);

    return res.status(200).json({ message: "Oferta cancelar con exito" });
  } catch (error) {
    return res.status(500).json({ message: "Error interno" });
  }
};

module.exports = { consultaOfertas, agregarTrabajo, aceptarOferta };
