const mongoose = require("mongoose");

const usuarioScheme = mongoose.Schema({
  nombre: {
    type: String,
    required: true,
  },
  apellido_p: { type: String, required: false },
  apellido_m: { type: String, required: false },
  sexo: { type: String, required: false },
  correo: { type: String, required: true },
  telefono: { type: String, required: false },
  password: { type: String, required: false },
  tipo_usuario: { type: String, required: true },
  imagen: { type: String, required: false },
  fecha_registro: { type: Date, required: true },
  fecha_nacimiento: { type: Date, required: true },
  tipo_red_social: { type: String, required: true },
  estatus: { type: String, required: true },
  verificado: { type: Boolean, required: true },
  token: { type: String, required: false },
});
module.exports = mongoose.model("usuarios", usuarioScheme);
