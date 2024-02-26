const { validationResult } = require("express-validator");
const usuarioSchema = require("../models/usuario.model.js");

const agregarToken = async (req, res) => {
  try {
    const { usuario, token } = req.body;
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const user = await usuarioSchema.findOne({ _id: usuario });

    if (!user) {
      return res.status(404).json({ message: "No existe el usuario" });
    }

    const update = await usuarioSchema.updateOne(
      { _id: usuario },
      { $set: { token: token } }
    );

    if (update.modifiedCount === 0) {
      return res.status(406).json({ message: "No se actualizo el token" });
    }

    return res
      .status(200)
      .json({ message: "Se agrego correctamente el token" });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const eliminarToken = async (req, res) => {
  try {
    const { usuario } = req.body;
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const update = await usuarioSchema.updateOne(
      { _id: usuario },
      { $set: { token: "" } }
    );

    if (update.modifiedCount === 0) {
      return res.status(406).json({ message: "No se elimino el token" });
    }
    return res.status(200).json({ message: "Se elimino el token" });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

module.exports = { agregarToken, eliminarToken };
