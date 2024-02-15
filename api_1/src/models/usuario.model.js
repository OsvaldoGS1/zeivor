const mongoose = require("mongoose");

const usuarioScheme = mongoose.Schema({
  nombre: {
    type: String,
    required: true,
  },
  apellido_p: { type: String, required: false },
  apellido_m: { type: String, required: false },
  sexo: { type: String, enum: ["Hombre", "Mujer", "Otro"], index: true },
  correo: { type: String, required: true, index: true },
  telefono: { type: String, required: false },
  password: { type: String, required: false },
  tipo_usuario: {
    type: String,
    enum: ["Cliente", "Oficio", "Admin"],
    index: true,
  },
  imagen: { type: String, required: false },
  fecha_registro: { type: Date, required: true },
  fecha_nacimiento: { type: Date, required: true },
  estado_lugar: {
    type: Schema.Types.ObjectId,
    ref: "estados",
    required: true,
  },
  auth: {
    apple: { type: String, required: false },
    google: { type: String, required: false },
    facebook: { type: String, required: false },
  },
  estatus: {
    type: String,
    enum: ["Activo", "Inactivo"],
    index: true,
  },
  verificado: {
    type: Boolean,
    default: false,
    index: true,
  },
  favoritos: {
    type: [{ type: Schema.Types.ObjectId, ref: "oficios" }],
    required: false,
    default: [],
  },
  token: { type: String, required: false },
});
module.exports = mongoose.model("usuarios", usuarioScheme);
