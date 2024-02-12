const connection = require("../config/db.js");
const { validationResult } = require("express-validator");

const agregarCalificacion = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { oficio, mensaje, califacion, usuario, fecha } = req.body;

    const sql = `INSERT INTO sei_calificacion(oficio, mensaje, calificacion, usuario, fecha) VALUES (?,?,?,?,?);`;

    const [resultado] = await connection.query(sql, [
      oficio,
      mensaje,
      califacion,
      usuario,
      fecha,
    ]);

    if (resultado.affectedRows === 0) {
      return res
        .status(404)
        .json({ message: "Error al agregar la calificacion" });
    }

    return res
      .status(200)
      .json({ message: "Calificacion agregada con exito." });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

module.exports = { agregarCalificacion };
