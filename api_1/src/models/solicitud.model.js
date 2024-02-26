const mongoose = require("mongoose");

//SolicitudAbierta
const solicitudSchema = mongoose.Schema({
  solicitante: {
    type: mongoose.Types.ObjectId,
    ref: "usuarios",
    required: true,
  },
  trabajo: { type: String, required: true },
  descripcion: { type: String, required: true },
  ubicacion: { type: String, required: true },
  fecha: { type: Date, required: true },
  estatus: {
    type: String,
    enum: ["Activo", "Inactivo", "Pospuesto", "Aceptada"],
    index: true,
  },
});

module.exports = mongoose.model("solicitudes", solicitudSchema);
