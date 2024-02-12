const connection = require("../config/db.js");
const { validationResult } = require("express-validator");

const obtenerOpinionesTrabajador = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { oficio } = req.body;
    const sql = `SELECT c.*,u.nombre FROM sei_calificacion c
    LEFT JOIN sei_usuarios u ON c.usuario = u.id_usuario
    WHERE oficio = ?;`;

    const [opiniones] = await connection.query(sql, [oficio]);

    if (opiniones.length === 0) {
      return res.status(404).json({ message: "Sin opiniones aun" });
    }

    return res.status(200).json(opiniones);
  } catch (error) {
    return res.status(500).json(error);
  }
};

module.exports = { obtenerOpinionesTrabajador };
