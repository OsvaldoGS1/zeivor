const connection = require("../config/db.js");
const { validationResult } = require("express-validator");

const busqueda_oficios = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const usuario = req.params.usuario;
    const busqueda = req.params.busqueda;
    const latitud = req.params.latitud;
    const longitud = req.params.longitud;

    const sql = `SELECT o.*, u.nombre, u.apellido_p, u.apellido_m, u.correo, 
    u.imagen as usuario_imagen, u.tipo,
    ROUND(AVG(COALESCE(c.calificacion, 0)), 2) AS calificacion FROM sei_oficio o 
    LEFT JOIN sei_usuarios u ON o.usuario = u.id_usuario 
    LEFT JOIN sei_calificacion c ON o.id_oficio = c.oficio
    WHERE profesion LIKE ? AND o.estatus = 'Activo' AND o.usuario != ?  AND ST_Distance_Sphere(
      POINT(?,?),
      POINT(SUBSTRING_INDEX(o.ubicacion, ',', -1), SUBSTRING_INDEX(o.ubicacion, ',', 1))) / 1000 <10
    GROUP BY o.id_oficio;`;

    const [resultado] = await connection.query(sql, [
      `%${busqueda}%`,
      usuario,
      longitud,
      latitud,
    ]);

    // pr

    // console.log(longitud, latitud);
    if (resultado.length === 0) {
      return res.status(404).json({ message: "No hay resultados" });
    }

    return res.status(200).json(resultado);
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

module.exports = { busqueda_oficios };
