// const cliente = require("../config/db.js");
const { validationResult } = require("express-validator");
const usuarioScheme = require("../models/usuario.model.js");
const { Security } = require("../../../api/src/config/passwords.js");

const { HtmlCorreo } = require("../config/html_mail.js");
const { transporter } = require("../config/mail.js");
const { Eliminar } = require("../helpers/eliminar.js");
const { join } = require("path");
// const { use } = require("../routes/usuario.js");

const iniciar_sesion = async (req, res) => {
  try {
    // const {corre,}
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    const { correo, password } = req.body;

    const user = await usuarioScheme.findOne({ correo: correo });

    if (!user) {
      return res
        .status(404)
        .json({ message: "correo no registrado o correo incorrecto" });
    }

    const contrasena = Security.encriptar(password);

    if (contrasena !== user.password) {
      return res.status(404).json({ message: "Contraseña incorrecta" });
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
    // const new_usuario = new usuarioScheme(req.body);
    const {
      correo,
      nombre,
      apellido,
      apellidoM,
      telefono,
      fecha,
      sexo,
      nacimiento,
    } = req.body;

    const verificar = await usuarioScheme.findOne({
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
      tipo_usuario: "cliente",
      fecha_registro: fecha,
      tipo_red_social: "ninguno",
      estatus: "Activo",
      verificado: false,
    });
    const resultado = await new_usuario.save();
    if (!resultado) {
    }
    await transporter.sendMail({
      from: '<_mainaccount@seivor.com> "SEIVOR" ',
      to: correo,
      subject: "Acceos a la app",
      html: HtmlCorreo.plantilla(nombre, correo, pass, 2024),
    });

    res.status(200).json({ message: "Registro Exitoso", usuario: resultado });
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

    const user = await usuarioScheme.findOne({ _id: usuario });

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

    const update_usuario = await usuarioScheme.updateOne(
      { _id: usuario },
      { $set: { imagen: imagen_url } }
    );

    if (update_usuario.nModified === 0) {
      return res.status(404).json({ message: "Error al registrar la imagen" });
    }

    const new_usuario = await usuarioScheme.findById(usuario);
    return res
      .status(200)
      .json({ message: "Imagen actualizada", usuario: new_usuario });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};
module.exports = { iniciar_sesion, registro, actualizarImagen };
