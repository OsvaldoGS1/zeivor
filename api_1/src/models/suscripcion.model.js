const mongoose = require("mongoose");

const suscripcionSchema = mongoose.Schema({
  usuario: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "usuarios",
    required: true,
  },
  cliente: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "cliente",
    required: true,
  },
  fecha_pago_inicio: { type: Date, required: true },
  fecha_final: { type: Date, required: true },
  identificador: { type: String, required: true },
  tipo_pago: { type: String, required: true },
  plan: {
    nombre: { type: String, required: true },
    precio: { type: Number, required: true },
    duracion: { type: Number, required: true },
  },
  subtotal: { type: Number, required: true },
  comision: { type: Number, required: true },
  impuestos: { type: Number, required: true },
  total: { type: Number, required: true },
  estado: {
    type: String,
    enum: ["Pagada", "Pendiente", "Cancelada"],
    required: true,
  },
});

module.exports = mongoose.model("suscripciones", suscripcionSchema);
