const { validationResult } = require("express-validator");
const estadoSchema = require("../models/estado.model.js");

const obtenerEstados = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const estados = await estadoSchema.find();
    return res.status(200).json(estados);
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

module.exports = { obtenerEstados };
