const { validationResult } = require("express-validator");
const solicitudDirectaSchema = require("../models/solicitud_directa.model.js");

const solicitudDirecta = async (req, res) => {
  try {
    //Validación de los campos
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { solicitante, cliente, fecha, mensaje, localizacion } = req.body;

    const solicitud = new solicitudDirectaSchema({
      solicitante: solicitante,
      cliente: cliente,
      fecha: fecha,
      mensaje: mensaje,
      localizacion: localizacion,
    });

    const resultado = await solicitud.save();
    if (!resultado) {
      return res.status(404).json({ message: "Error al realizar el contacto" });
    }

    return res.status(200).json({ message: "Contacto realizado" });
  } catch (error) {
    return res.status(500).json(error);
  }
};

const obtenerDatosSolicitudDirectaSolicitante = async (req, res) => {
  try {
    //Validación de los campos
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { solicitante } = req.body;

    const solicitudes = await solicitudDirectaSchema
      .find({
        solicitante: solicitante,
      })
      .populate({
        path: "solicitante",
        select:
          "nombre apellido_p apellido_m sexo correo favoritos imagen auth telefono verificado",
      })
      .populate({
        path: "cliente",
        populate: {
          path: "usuario",
          select:
            "nombre apellido_p apellido_m sexo correo favoritos imagen auth telefono verificado",
        },
      })
      .populate({
        path: "cliente",
        populate: {
          path: "opiniones",
          select: "calificacion",
        },
      });

    solicitudes.forEach((solicitud) => {
      solicitud.cliente.identificacion = "";
      solicitud.cliente.selfie = "";
      solicitud.cliente.carta_penal = "";
      solicitud.cliente.favoritos = [];
      solicitud.solicitante.favoritos = [];
      const opiniones = solicitud.cliente.opiniones;
      if (opiniones.length > 0) {
        const sumaCalificaciones = opiniones.reduce(
          (suma, opinion) => suma + opinion.calificacion,
          0
        );

        solicitud.cliente.calificacion = sumaCalificaciones / opiniones.length;
      } else {
        solicitud.cliente.calificacion = 0;
      }
    });

    if (solicitudes.length === 0) {
      return res.status(404).json({ message: "Sin solicitudes" });
    }

    return res.status(200).json(solicitudes);
  } catch (error) {
    return res.status(500).json(error);
  }
};
const obtenerSolicitudesDirectaCliente = async (req, res) => {
  try {
    //Validación de los campos
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { cliente } = req.body;

    const solicitudes = await solicitudDirectaSchema
      .find({
        cliente: cliente,
      })
      .populate({
        path: "solicitante",
        select:
          "nombre apellido_p apellido_m sexo correo favoritos imagen auth telefono verificado",
      })
      .populate({
        path: "cliente",
        populate: {
          path: "usuario",
          select:
            "nombre apellido_p apellido_m sexo correo favoritos imagen auth telefono verificado",
        },
      })
      .populate({
        path: "cliente",
        populate: {
          path: "opiniones",
          select: "calificacion",
        },
      });

    solicitudes.forEach((solicitud) => {
      solicitud.cliente.identificacion = "";
      solicitud.cliente.selfie = "";
      solicitud.cliente.carta_penal = "";
      solicitud.cliente.favoritos = [];
      solicitud.solicitante.favoritos = [];
      const opiniones = solicitud.cliente.opiniones;
      if (opiniones.length > 0) {
        const sumaCalificaciones = opiniones.reduce(
          (suma, opinion) => suma + opinion.calificacion,
          0
        );

        solicitud.cliente.calificacion = sumaCalificaciones / opiniones.length;
      } else {
        solicitud.cliente.calificacion = 0;
      }
    });

    if (solicitudes.length === 0) {
      return res.status(404).json({ message: "Sin solicitudes" });
    }

    return res.status(200).json(solicitudes);
  } catch (error) {
    return res.status(500).json(error);
  }
};

module.exports = {
  solicitudDirecta,
  obtenerDatosSolicitudDirectaSolicitante,
  obtenerSolicitudesDirectaCliente,
};
