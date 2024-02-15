const mongoose = require("mongoose");

const estadoSchema = mongoose.Schema({
  nombre: { type: String, required: true },
  clave: { type: String, required: true },
  pais: { type: String, required: true },
});

module.exports = mongoose.model("estados", estadoSchema);
