const connection = require("../config/db.js");
const { validationResult } = require("express-validator");
const { transporter } = require("../config/mail.js");
const { Security } = require("../config/passwords.js");
const { HtmlCorreo } = require("../config/html_mail.js");
const { Eliminar } = require("../helper/eliminar.js");
const { join } = require("path");

const iniciar_sesion = async (req, res) => {
  try {
    //Se verifican errores en los campos del formulario
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { correo, password } = req.body;

    const sql = "SELECT * FROM sei_usuarios WHERE correo = ? ;";

    const [resultado] = (await connection.query(sql, [correo]))[0];

    if (!resultado) {
      return res
        .status(404)
        .json({ message: "correo no registrado o correo incorrecto" });
    }

    const contrasena = Security.encriptar(password);
    if (contrasena !== resultado.password) {
      return res.status(404).json({ message: "Contraseña incorrecta" });
    }

    return res.status(200).json({ message: "Bienvenido", resultado });
  } catch (error) {
    console.log(error);
  }
};

const registrarse = async (req, res) => {
  try {
    //Se verifican errores en los campos del formulario
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { correo, nombre, apellido, apellidoM, telefono, fecha } = req.body;

    const sql = `INSERT INTO sei_usuarios (nombre, apellido_p, apellido_m, correo, telefono, password, tipo_usuario, fecha_registro, estatus) 
    VALUES (?,?,?,?,?,?,1,?,'Activo');`;

    const [verificar] = await connection.query(
      "SELECT * FROM sei_usuarios WHERE correo = ?",
      [correo]
    );
    if (verificar.length > 0) {
      return res
        .status(400)
        .json({ message: "El correo electronico ya se encuentra registrado" });
    }
    const pass = Security.generarContrasena();
    const pass_encriptada = Security.encriptar(pass);

    var fechaActual = new Date();
    var year = fechaActual.getFullYear();

    const [resultado] = await connection.query(sql, [
      nombre,
      apellido,
      apellidoM,
      correo,
      telefono,
      pass_encriptada,
      fecha,
    ]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ message: "No se realizo el registro" });
    }

    const [usuario] = (
      await connection.query(
        "SELECT * FROM sei_usuarios WHERE id_usuario = ?;",
        [resultado.insertId]
      )
    )[0];
    const send = await transporter.sendMail({
      from: '<_mainaccount@seivor.com> "SEIVOR" ',
      to: correo,
      subject: "Acceos a la app",
      html: HtmlCorreo.plantilla(nombre, correo, pass, year),
    });

    if (!send) {
      return res.status(404).json({ message: "No se envio el correo" });
    }

    return res
      .status(200)
      .json({ message: "Usuario registrado", usuario: usuario });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const agregarImagen = async (req, res) => {
  try {
    //Se verifican errores en los campos del formulario
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

    const sql = `SELECT * FROM sei_usuarios WHERE id_usuario = ?`;
    const [user] = (await connection.query(sql, [usuario]))[0];

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

    const sql_update = `UPDATE sei_usuarios SET imagen = ? WHERE id_usuario = ?;`;
    const [resultado] = await connection.query(sql_update, [
      imagen_url,
      usuario,
    ]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ message: "Error al registrar la imagen" });
    }

    const [user_imagen] = (
      await connection.query(
        `SELECT * FROM sei_usuarios WHERE id_usuario = ?;`,
        [usuario]
      )
    )[0];

    return res
      .status(200)
      .json({ message: "Imagen actualizada", usuario: user_imagen });
  } catch (error) {
    return res.status(500).json(error);
  }
};

const agregarUsuarioRS = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { correo, nombre, imagen, fecha, tipo } = req.body;

    const sql = `INSERT INTO sei_usuarios (nombre, correo,imagen, tipo_usuario, fecha_registro, estatus, tipo) 
    VALUES (?,?,?,1,?,'Activo',?);`;

    const consultar_correo_sql = `SELECT * FROM sei_usuarios u WHERE u.correo = ?`;
    const [resultado_consulta_correo] = (
      await connection.query(consultar_correo_sql, [correo])
    )[0];

    if (resultado_consulta_correo.tipo === "ninguno") {
      return res
        .status(404)
        .json({ message: "El correo ya existe en nuestro sistema" });
    }

    if (resultado_consulta_correo.tipo !== "ninguno") {
      return res.status(200).json(resultado_consulta_correo);
    }

    const [insertar_usuario] = await connection.query(sql, [
      nombre,
      correo,
      imagen,
      fecha,
      tipo,
    ]);

    if (insertar_usuario.affectedRows === 0) {
      return res.status(404).json({ message: "Error al registrar tus datos" });
    }

    const [usuario] = (
      await connection.query(
        "SELECT * FROM sei_usuarios WHERE id_usuario = ?;",
        [insertar_usuario.insertId]
      )
    )[0];

    return res.status(200).json(usuario);
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const agregarToken = async (req, res) => {
  try {
    const { token, usuario } = req.body;
    const queryUpdate = "UPDATE sei_usuarios SET token=? WHERE id_usuario=?;";
    await connection.query(queryUpdate, [token, usuario]);
    return res.status(200).json();
  } catch (error) {
    console.log(error);
    return res.status(500).json();
  }
};

const actualizarUsuario = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { nombre, apellido, apellidoM, correo, telefono, password, usuario } =
      req.body;
    const queryUpdate = `UPDATE sei_usuarios SET nombre = ?, apellido_p = ?, apellido_m = ?, 
    correo = ?, telefono = ?, password = ? WHERE id_usuario = ?;`;
    const [resultado] = await connection.query(queryUpdate, [
      nombre,
      apellido,
      apellidoM,
      correo,
      telefono,
      password,
      usuario,
    ]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ message: "Error al actualizar los datos" });
    }

    const [user] = await connection.query(
      "SELECT * FROM sei_usuarios WHERE  id_usuario = ?;",
      usuario
    );

    return res
      .status(200)
      .json({ message: "Actualizacion con exito", usuario: user });
  } catch (error) {
    console.log(error);
    return res.status(500).json();
  }
};

module.exports = {
  iniciar_sesion,
  registrarse,
  agregarImagen,
  agregarUsuarioRS,
  agregarToken,
  actualizarUsuario,
};
