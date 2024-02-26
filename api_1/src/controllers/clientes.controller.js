const { validationResult } = require("express-validator");
const clienteSchema = require("../models/cliente.model.js");
const { join } = require("path");
const fs = require("fs");

const obtenerDatosCliente = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { usuario } = req.body;

    const cliente = await clienteSchema.findOne({ usuario: usuario });

    if (!cliente) {
      return res.status(404).json({ message: "Sin datos de cliente" });
    }

    if (cliente) {
      cliente.usuario = null;
    }

    return res.status(200).json(cliente);
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const registroCliente = async (req, res) => {
  try {
    //Ejecutamos la validación de los campos del formulario.
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    if (!req.files || Object.keys(req.files).length === 0) {
      return res
        .status(400)
        .json({ message: "No se ha seleccionado ninguna imagen" });
    }

    const {
      usuario,
      profesion,
      descripcion,
      tarjeta,
      transferencia,
      efectivo,
      celular,
      ubicacion,
      visita_cobro,
      calle,
      cp,
      colonia,
      municipio,
      estado,
      pais,
      visible,
      referencia_uno,
      referencia_dos,
      referencia_tres,
      emite_factura,
    } = req.body;

    const { imagen, identificacion, selfie, carta } = req.files;

    const new_cliente = new clienteSchema({
      usuario: usuario,
      profesion: profesion,
      descripcion: descripcion,
      metodos_pago: {
        tarjeta: tarjeta,
        transferencia: transferencia,
        efectivo: efectivo,
      },
      celular: celular,
      ubicacion: ubicacion,
      imagen: "",
      visita_cobro: visita_cobro,
      emite_factura: emite_factura,
      direccion: {
        calle: calle,
        cp: cp,
        colonia: colonia,
        municipio: municipio,
        estado: estado,
        pais: pais,
        visible: visible,
      },
      imagenes_trabajo: [],
      identificacion: "",
      selfie: "",
      carta_penal: "",
      referencia: [referencia_uno, referencia_dos, referencia_tres],
      palabras_claves: [],
      verificado: false,
      fecha_vencimiento: "",
    });
    const resultado = await new_cliente.save();

    if (!resultado) {
      return res.status(404).json({ message: "Error al guardar el registro" });
    }

    const id = resultado._id.toString();

    //Imagen principal del usuario
    const nombre_imagen = `${id}_oficio_imagen.${imagen.name.split(".")[1]}`;
    const path_upload = join(__dirname, "../../public/oficios/", nombre_imagen);
    imagen.mv(path_upload, async (err) => {
      if (err) {
        console.log(err);
        return res.status(404).json({
          message:
            "Error al subir la imagen, pero tus datos fueron registrados podras agregar tu imagen en la seccion de editar tu perfil",
        });
      }
    });
    const imagen_url = "/oficios/" + nombre_imagen;

    //Crear carpeta para sus datos de verificacion (identificacion, selfie , carta, etc...)

    const nombreCarpeta = `${id}_documentos`;
    const rutaCompleta = join(
      __dirname,
      "../../public/validaciones/",
      nombreCarpeta
    );
    if (!fs.existsSync(rutaCompleta)) {
      fs.mkdirSync(rutaCompleta);
    }

    //identificacion del cliente
    let path_identificacion = "";
    if (identificacion) {
      const nombre_ID = `${id}_identificacion.${
        identificacion.name.split(".")[1]
      }`;
      const path = join(
        __dirname,
        "../../public/validaciones/",
        nombreCarpeta,
        "/",
        nombre_ID
      );
      identificacion.mv(path, async (err) => {
        if (err) {
          console.log(err);
        }
      });
      path_identificacion = "/validaciones/" + nombreCarpeta + "/" + nombre_ID;
    }

    //Selfie del cliente
    let path_selfie = "";
    if (selfie) {
      const name = `${id}_selfie.${selfie.name.split(".")[1]}`;
      const path = join(
        __dirname,
        "../../public/validaciones/",
        nombreCarpeta,
        "/",
        name
      );
      selfie.mv(path, async (err) => {
        if (err) {
          console.log(err);
        }
      });
      path_selfie = "/validaciones/" + nombreCarpeta + "/" + name;
    }

    //Carta de antecedentes no penales (opcional)
    let path_carta = "";
    if (carta) {
      const name = `${id}_carta.${carta.name.split(".")[1]}`;
      const path = join(
        __dirname,
        "../../public/validaciones/",
        nombreCarpeta,
        "/",
        name
      );
      carta.mv(path, async (err) => {
        if (err) {
          console.log(err);
        }
      });
      path_carta = "/validaciones/" + nombreCarpeta + "/" + name;
    }

    const update_cliente = await clienteSchema.updateOne(
      { _id: id },
      {
        $set: {
          imagen: imagen_url,
          identificacion: path_identificacion,
          selfie: path_selfie,
          carta_penal: path_carta,
        },
      }
    );

    const update_usuario = await clienteSchema.updateOne(
      {
        _id: usuario,
      },
      { $set: { tipo_usuario: "Cliente" } }
    );

    return res.status(200).json({
      message:
        "Se ha registrado todos tus datos en nuestra base, ahora solo falta la validación por parte del administrador.",
    });
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

const cambiarEstatus = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { cliente, estatus } = req.body;

    const resultado = await clienteSchema.updateOne(
      { _id: cliente },
      { $set: { estatus: estatus } }
    );

    if (resultado.modifiedCount === 0) {
      return res.status(404).json({ message: "Error al actualizar su estado" });
    }

    return res.status(200).json({ message: "Completado" });
  } catch (error) {
    return res.status(500).json(error);
  }
};

module.exports = { registroCliente, obtenerDatosCliente, cambiarEstatus };
