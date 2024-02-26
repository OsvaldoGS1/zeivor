const mongoose = require("mongoose");

const clienteSchema = mongoose.Schema({
  usuario: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "usuarios",
    required: true,
    index: true,
  },
  profesion: { type: String, required: true, index: true },
  descripcion: { type: String, required: true },
  metodos_pago: {
    tarjeta: { type: Boolean, default: false },
    transferencia: { type: Boolean, default: false },
    efectivo: { type: Boolean, default: false },
  },
  celular: { type: String, required: true },
  ubicacion: { type: String, required: true },
  imagen: { type: String, required: false },
  visita_cobro: { type: String, required: true },
  emite_factura: { type: Boolean, required: false, default: false },
  direccion: {
    calle: { type: String },
    cp: { type: Number },
    colonia: { type: String },
    municipio: { type: String },
    estado: { type: String },
    pais: { type: String },
    visible: { type: Boolean },
  },
  imagenes_trabajo: { type: [{ type: String }], required: false },
  identificacion: { type: String, required: false },
  selfie: { type: String, required: false },
  carta_penal: { type: String, required: false },
  referencia: { type: [{ type: String }], required: true },
  calificacion: { type: Number, default: 0 },
  palabras_claves: { type: [{ type: String }], required: false },

  opiniones: {
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: "opiniones" }],
    required: false,
    default: [],
  },

  estatus: {
    type: String,
    enum: ["Activo", "Inactivo", "Rechazado"],
    default: "Inactivo",
    index: true,
  },
  verificado: {
    type: Boolean,
    default: false,
    index: true,
  },
  fecha_vencimiento: {
    type: Date,
    required: false,
    index: true,
  },
});

module.exports = mongoose.model("clientes", clienteSchema);
