const mongoose = require("mongoose");
// const usuarioScheme = require("../models/usuario.model.js");

const oficioScheme = mongoose.Schema({
  usuario: {
    type: Schema.Types.ObjectId,
    ref: "usuarios",
    required: true,
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
  imagen: { type: String, required: true },
  visita_cobro: { type: String, required: true },
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
  identificacion: { type: String, required: true },
  selfie: { type: String, required: true },
  carta_penal: { type: String, required: false },
  referencia: { type: [{ type: String }], required: true },
  palabras_claves: { type: [{ type: String }], required: true },
  estatus: {
    type: String,
    enum: ["Activo", "Inactivo", "Rechazado"],
    index: true,
  },
  verificado: {
    type: Boolean,
    default: false,
  },
  fecha_vencimiento: {
    type: Date,
    required: false,
    index: true,
  },
});

// const

module.exports = mongoose.model("oficios", oficioScheme);
