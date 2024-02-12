const connection = require("../config/db.js");
const { validationResult } = require("express-validator");

const trabajadoresFavoritos = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { usuario } = req.body;

    const sql = `SELECT 
    f.id_favorito, 
    o.*, 
    u.nombre, 
    u.apellido_p, 
    u.apellido_m, 
    u.correo, 
    u.imagen as usuario_imagen,
    u.tipo,
    ROUND(AVG(c.calificacion), 2) AS calificacion
    FROM 
        sei_favoritos f
    LEFT JOIN 
        sei_oficio o ON f.oficio = o.id_oficio
    LEFT JOIN 
        sei_usuarios u ON o.usuario = u.id_usuario
    LEFT JOIN 
        sei_calificacion c ON c.oficio = o.id_oficio
    WHERE 
        f.usuario = ?
    GROUP BY 
        f.id_favorito, o.id_oficio, u.id_usuario;`;

    const [resultado] = await connection.query(sql, [usuario]);

    if (resultado.length === 0) {
      return res.status(404).json({ message: "Sin trabajadores favoritos" });
    }

    // console.log(resultado);
    return res.status(200).json(resultado);
  } catch (error) {
    return res.status(500).json(error);
  }
};

const agregarFavoritos = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { usuario, oficio } = req.body;

    const sql_comprobar = `SELECT * FROM sei_favoritos WHERE usuario = ? AND oficio = ?;`;
    const [comprobar] = await connection.query(sql_comprobar, [
      usuario,
      oficio,
    ]);

    if (comprobar.length >> 0) {
      return res
        .status(200)
        .json({ message: "Ya esta registrado como favorito" });
    }

    const sql = `INSERT INTO sei_favoritos (usuario, oficio) VALUES (?,?);`;

    const [resultado] = await connection.query(sql, [usuario, oficio]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ message: "Error al agregar a favoritos" });
    }

    return res
      .status(200)
      .json({ message: "Agregado a favoritos exitosamente" });
  } catch (error) {
    return res.status(500).json(error);
  }
};

const eliminarFavorito = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { favorito } = req.body;

    const sql = `DELETE FROM sei_favoritos WHERE id_favorito = ?;`;

    const [resultado] = await connection.query(sql, [favorito]);

    if (resultado.affectedRows === 0) {
      return res
        .status(404)
        .json({ message: "Error al eliminar de favoritos" });
    }

    return res
      .status(200)
      .json({ message: "Eliminado de favoritos exitosamente" });
  } catch (error) {
    return res.status(500).json(error);
  }
};

module.exports = { trabajadoresFavoritos, agregarFavoritos, eliminarFavorito };
