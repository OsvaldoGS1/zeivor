const mongoose = require("mongoose");
//SolicitudDirecta
const solicitudDirectaSchema = mongoose.Schema({
  cliente: {
    type: mongoose.SchemaTypes.ObjectId,
    ref: "clientes",
    required: true,
  },
  solicitante: {
    type: mongoose.SchemaTypes.ObjectId,
    ref: "usuarios",
    required: true,
  },
  fecha: { type: Date, required: true },
  mensaje: { type: String, required: true },
  localizacion: { type: String, required: true },

  //EstatusCliente
  estatusCliente: {
    type: String,
    enum: ["Terminado", "En proceso"],
    default: "En proceso",
    required: true,
  },

  //estatusSolicitante
  estatusSolicitante: {
    type: String,
    enum: ["Terminado", "En proceso"],
    default: "En proceso",
    required: true,
  },

  estatus: {
    type: String,
    enum: ["Aceptada", "Cancelada", "Completa", "Activa"],
    default: "Activa",
    required: true,
  },
});

module.exports = mongoose.model("solicitudes_directas", solicitudDirectaSchema);
