const connection = require("../config/db.js");
const { validationResult } = require("express-validator");

const consultarContratos = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { usuario } = req.body;
    const sql = `SELECT c.id_contacto, c.fecha, c.mensaje, c.estatus_trabajador, c.estatus_cliente, c.localizacion, c.estatus as estado,o.*, ROUND(AVG(COALESCE(ca.calificacion, 0)), 2) AS calificacion ,u.nombre, 
    u.nombre, u.apellido_p, u.apellido_m,u.correo, u.imagen as 'usuario_imagen', u.tipo 
    FROM sei_contacto c 
    LEFT JOIN sei_oficio o ON c.oficio =. o.id_oficio 
    LEFT JOIN sei_usuarios u ON o.usuario = u.id_usuario 
    LEFT JOIN sei_calificacion ca ON ca.oficio = o.id_oficio
    WHERE c.usuario = ?
    GROUP BY c.fecha,o.id_oficio
    ORDER BY c.fecha DESC;`;

    const [resultado] = await connection.query(sql, [usuario]);

    if (resultado.length === 0) {
      return res.status(404).json({ message: "Sin contrataciones" });
    }

    return res.status(200).json(resultado);
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const terminarTrabajoTrabajador = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { contrato } = req.body;
    const sql = `UPDATE sei_contacto SET estatus_trabajador = 'Terminado' WHERE id_contacto = ?;`;

    const [resultado] = await connection.query(sql, [contrato]);

    if (resultado.affectedRows === 0) {
      return res
        .status(404)
        .json({ message: "Error al actualizar el estatus" });
    }

    return res.status(200).json({ message: "Actualizado con exito" });
  } catch (error) {
    return res.status(500).json(error);
  }
};

const terminarTrabajoCliente = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { contrato } = req.body;
    const sql = `UPDATE sei_contacto SET estatus_cliente = 'Terminado' WHERE id_contacto = ?;`;

    const [resultado] = await connection.query(sql, [contrato]);

    if (resultado.affectedRows === 0) {
      return res
        .status(404)
        .json({ message: "Error al actualizar el estatus" });
    }

    return res.status(200).json({ message: "Actualizado con exito" });
  } catch (error) {
    return res.status(500).json(error);
  }
};
module.exports = {
  consultarContratos,
  terminarTrabajoTrabajador,
  terminarTrabajoCliente,
};
