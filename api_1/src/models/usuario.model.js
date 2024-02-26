const mongoose = require("mongoose");

const usuarioSchema = mongoose.Schema({
  nombre: {
    type: String,
    required: true,
  },
  apellido_p: { type: String, required: false },
  apellido_m: { type: String, required: false },
  sexo: { type: String, enum: ["Hombre", "Mujer", "Otro"], index: true },
  fecha_nacimiento: { type: Date, required: true },
  correo: { type: String, required: true, index: true },
  telefono: { type: String, required: false },
  password: { type: String, required: false },
  tipo_usuario: {
    type: String,
    enum: ["Normal", "Cliente", "Admin"],
    index: true,
  },
  imagen: { type: String, required: false },
  fecha_registro: { type: Date, required: true },

  estado_lugar: {
    type: mongoose.Schema.Types.ObjectId,
    ref: "estados",
    required: true,
  },
  auth: {
    type: String,
    enum: ["apple", "facebook, google", "ninguno"],
    default: "ninguno",
    required: true,
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
    type: [{ type: mongoose.Schema.Types.ObjectId, ref: "clientes" }],
    required: false,
    default: [],
  },
  token: { type: String, required: false },
});
module.exports = mongoose.model("usuarios", usuarioSchema);
