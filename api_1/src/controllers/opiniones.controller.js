const { validationResult } = require("express-validator");
const opinionSchema = require("../models/opiniones.model.js");

const clienteSchema = require("../models/cliente.model.js");

const agregarOpinion = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { cliente, solicitante, mensaje, calificacion, fecha, tipo } =
      req.body;

    const nueva_opinion = new opinionSchema({
      cliente: cliente,
      solicitante: solicitante,
      mensaje: mensaje,
      calificacion: calificacion,
      fecha: fecha,
      tipo: tipo,
      estatus: "Aprobado",
    });

    const resultado = await nueva_opinion.save();

    if (!resultado) {
      return res.status(404).json({ message: "Error al registrar la opinion" });
    }

    if (tipo === "Solicitante") {
      await clienteSchema.updateOne(
        { _id: cliente },
        { $push: { opiniones: resultado._id } }
      );
    }

    return res.status(200).json({
      message: "Opinion registrada con exito",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const obtenerOpinionesCliente = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { cliente } = req.body;

    const opiniones = await opinionSchema.find({
      cliente: cliente,
      tipo: "Solicitante",
      "reporte.estado": "Sin reporte",
      estatus: "Aprobado",
    });

    const ruta =
      "/api_1/public/clientes_imagenes/65d391c4c413a2fb6a68d998/65d391c4c413a2fb6a68d998_1.jpg";
    if (opiniones.length === 0) {
      return res.status(404).json({ message: "Sin opiniones" });
    }

    return res.status(200).json(opiniones);
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

module.exports = { agregarOpinion, obtenerOpinionesCliente };
