const { validationResult } = require("express-validator");
const usuarioSchema = require("../models/usuario.model.js");
const clienteSchema = require("../models/cliente.model.js");
// const opinionSchema = require("../models/opiniones.model.js");

const agregarFavorito = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { usuario, cliente } = req.body;

    const usuarioExistente = await usuarioSchema.findOne({
      _id: usuario,
      favoritos: cliente,
    });

    if (usuarioExistente) {
      // El cliente ya está en la lista de favoritos, puedes manejar esto según tus necesidades
      return res
        .status(404)
        .json({ message: "El trabajador ya está en la lista de favoritos" });
    }
    const resultado = await usuarioSchema.updateOne(
      { _id: usuario },
      { $push: { favoritos: cliente } }
    );

    if (!resultado) {
      return res.status(404).json({ message: "Error al agregar a favoritos" });
    }
    return res
      .status(200)
      .json({ message: "Agregado a favoritos exitosamente" });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const eliminarDeFavoritos = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { usuario, cliente } = req.body;

    // Verificar si el cliente está en la lista de favoritos
    const usuarioExistente = await usuarioSchema.findOne({
      _id: usuario,
      favoritos: cliente,
    });

    if (!usuarioExistente) {
      // El cliente no está en la lista de favoritos, puedes manejar esto según tus necesidades
      return res
        .status(400)
        .json({ error: "El trabajador no está en la lista de favoritos" });
    }

    // Si el cliente está en la lista de favoritos, procede a eliminarlo
    const resultado = await usuarioSchema.updateOne(
      { _id: usuario },
      { $pull: { favoritos: cliente } }
    );

    if (!resultado) {
      return res
        .status(404)
        .json({ message: "Error al eliminar de favoritos" });
    }

    return res
      .status(200)
      .json({ mensaje: "Trabajador eliminado de favoritos exitosamente" });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const obtenerFavoritos = async (req, res) => {
  try {
    const { usuario } = req.body;
    const usuarioDocument = await usuarioSchema.findOne({ _id: usuario });

    if (!usuarioDocument) {
      return res.status(404).json({ error: "Usuario no encontrado" });
    }

    if (usuarioDocument.favoritos.length == 0) {
      return res
        .status(406)
        .json({ message: "No hay trabajadores agregados como favorito" });
    }
    const idsFavoritos = usuarioDocument.favoritos;

    const favoritosDetalles = await clienteSchema
      .find({
        _id: { $in: idsFavoritos },
      })
      .populate(
        "usuario",
        "nombre correo apellido_p apellido_m imagen auth favoritos"
      )
      .populate({
        path: "opiniones",
        select: "calificacion",
        model: "opiniones",
      });
    favoritosDetalles.forEach((favorito) => {
      const opiniones = favorito.opiniones;
      if (opiniones.length > 0) {
        const sumaCalificaciones = opiniones.reduce(
          (suma, opinion) => suma + opinion.calificacion,
          0
        );
        favorito.calificacion = sumaCalificaciones / opiniones.length;
      } else {
        favorito.calificacion = 0;
      }
    });
    return res.status(200).json(favoritosDetalles);
  } catch (error) {
    console.error(error);
    return res.status(500).json(error);
  }
};
module.exports = { agregarFavorito, eliminarDeFavoritos, obtenerFavoritos };
