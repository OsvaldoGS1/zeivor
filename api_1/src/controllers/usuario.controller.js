const { validationResult } = require("express-validator");
const usuarioSchema = require("../models/usuario.model.js");
const { Security } = require("../../../api/src/config/passwords.js");

const { HtmlCorreo } = require("../config/html_mail.js");
const { transporter } = require("../config/mail.js");
const { Eliminar } = require("../helpers/eliminar.js");
const { join } = require("path");

const iniciar_sesion = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const { correo, password } = req.body;

    // const user = await usuarioScheme.aggregate([
    //   {
    //     $lookup: {
    //       from: "estados",
    //       localField: "estado_lugar",
    //       foreignField: "_id",
    //       as: "estado_lugar",
    //     },
    //   },
    //   {
    //     $match: {
    //       correo: correo,
    //     },
    //   },
    // ]);

    const user = await usuarioSchema
      .findOne({ correo: correo })
      .populate("estado_lugar");

    if (!user) {
      return res
        .status(404)
        .json({ message: "correo no registrado o correo incorrecto" });
    }

    const contrasena = Security.encriptar(password);

    if (contrasena !== user.password) {
      return res.status(404).json({ message: "Credenciales invalidas" });
    }

    return res.status(200).json({ message: "Bienvenido", usuario: user });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const registro = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
      å;
    }

    const {
      correo,
      nombre,
      apellido,
      apellidoM,
      telefono,
      fecha,
      sexo,
      nacimiento,
      estado,
    } = req.body;

    const verificar = await usuarioSchema.findOne({
      correo: correo,
    });

    if (verificar) {
      return res
        .status(404)
        .json({ message: "El correo electronico ya se encuentra registrado" });
    }

    const pass = Security.generarContrasena();
    const pass_encriptada = Security.encriptar(pass);

    const new_usuario = new usuarioScheme({
      nombre: nombre,
      apellido_p: apellido,
      apellido_m: apellidoM,
      sexo: sexo,
      fecha_nacimiento: nacimiento,
      correo: correo,
      telefono: telefono,
      password: pass_encriptada,
      tipo_usuario: "Cliente",
      imagen: "",
      fecha_registro: fecha,
      estado_lugar: estado,
      // auth: "",
      estatus: "Activo",
      verificado: false,
      token: "",
    });
    const resultado = await new_usuario.save();
    if (!resultado) {
      return res.status(404).json({ message: "Error al guardar el Usuario" });
    }
    const usuario = await resultado.populate("estado_lugar");
    console.log(resultado);
    await transporter.sendMail({
      from: '<_mainaccount@seivor.com> "SEIVOR" ',
      to: correo,
      subject: "Acceos a la app",
      html: HtmlCorreo.plantilla(nombre, correo, pass, 2024),
    });

    res.status(200).json({ message: "Registro Exitoso", usuario: usuario });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const actualizarImagen = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    if (!req.files || Object.keys(req.files).length === 0) {
      return res
        .status(400)
        .json({ message: "No se ha seleccionado ninguna imagen" });
    }

    const { usuario } = req.body;
    const { imagen } = req.files;

    const user = await usuarioSchema.findOne({ _id: usuario });
    // console.log(user);

    if (!user) {
      return res.status(404).json({ message: "Error al encontrar el usuario" });
    }

    if (user.imagen !== null) {
      Eliminar.imagen_usuario(join(__dirname, "../../public/", user.imagen));
    }

    const nombre_imagen = `${usuario}_usuario_imagen.${
      imagen.name.split(".")[1]
    }`;

    const path_upload = join(
      __dirname,
      "../../public/usuarios/",
      nombre_imagen
    );

    imagen.mv(path_upload, async (err) => {
      if (err) {
        console.log(err);
        return res.status(404).json({ message: "Error al subir la imagen." });
      }
    });

    const imagen_url = "/usuarios/" + nombre_imagen;

    const update_usuario = await usuarioSchema.updateOne(
      { _id: usuario },
      { $set: { imagen: imagen_url } }
    );

    // if (update_usuario.modifiedCount === 0) {
    //   return res.status(404).json({ message: "Error al registrar la imagen" });
    // }

    console.log(update_usuario);
    const new_usuario = await usuarioSchema
      .findById(usuario)
      .populate("estado_lugar");
    return res
      .status(200)
      .json({ message: "Imagen actualizada", usuario: new_usuario });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const registroAuth = async (req, res) => {
  try {
  } catch (error) {}
};

module.exports = { iniciar_sesion, registro, actualizarImagen };
