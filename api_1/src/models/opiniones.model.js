const mongoose = require("mongoose");

const opinionSchema = mongoose.Schema({
  //Cliente
  cliente: {
    type: mongoose.SchemaTypes.ObjectId,
    ref: "clientes",
    required: true,
  },
  //Solicitante
  solicitante: {
    type: mongoose.SchemaTypes.ObjectId,
    ref: "usuarios",
    required: true,
  },

  mensaje: { type: String, required: true },
  calificacion: { type: Number, required: true },
  fecha: { type: Date, required: true },
  tipo: {
    type: String,
    enum: ["Cliente", "Solicitante"],
    required: true,
  },
  estatus: {
    type: String,
    enum: ["Aprobado", "Inaprobado", "No aprobado"],
    default: "Aprobado",
    required: true,
  },
  reporte: {
    motivo: { type: String, default: "" },
    estado: {
      type: String,
      enum: ["Pendiente", "Resuelto", "Sin reporte"],
      default: "Sin reporte",
    },
  },
});

module.exports = mongoose.model("opiniones", opinionSchema);
