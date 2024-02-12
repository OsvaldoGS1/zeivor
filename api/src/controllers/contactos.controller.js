const connection = require("../config/db.js");
const { validationResult } = require("express-validator");

const obtenerNotificaciones = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { oficio } = req.body;
    const sql = `SELECT c.id_contacto, c.fecha, c.mensaje, c.localizacion, c.estatus, u.id_usuario, u.nombre, u.apellido_p, u.apellido_m,u.correo, u.telefono, u.imagen, u.tipo FROM sei_contacto c
        LEFT JOIN sei_usuarios u ON c.usuario = u.id_usuario
        WHERE c.oficio = ?;`;

    const [resultado] = await connection.query(sql, [oficio]);
    if (resultado.length === 0) {
      return res.status(404).json({ message: "Sin notificaciones" });
    }

    return res.status(200).json(resultado);
  } catch (error) {
    console.log(error);
    return res.status(500).json({ message: "Error en el servidor" });
  }
};
