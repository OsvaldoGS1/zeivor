const connection = require("../config/db.js");
const { validationResult } = require("express-validator");
const fs = require("fs");
const { join } = require("path");

const convertirseProfesionista = async (req, res) => {
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

    const {
      usuario,
      profesion,
      descripcion,
      metodos,
      celular,
      visita,
      calle,
      colonia,
      cp,
      municipio,
      estado,
      pais,
      visible,
    } = req.body;

    const { imagen, identificacion, selfie, carta } = req.files;

    const sql = `INSERT INTO sei_oficio (usuario, profesion, descripcion, metodos_pago, celular, imagen, visita_cobro) VALUES (?,?,?,?,?,?,?);`;

    const nombre_imagen = `${usuario}_oficio_imagen.${
      imagen.name.split(".")[1]
    }`;

    const path_upload = join(__dirname, "../../public/oficios/", nombre_imagen);

    imagen.mv(path_upload, async (err) => {
      if (err) {
        console.log(err);
        return res.status(404).json({ message: "Error al subir la imagen." });
      }
    });

    const imagen_url = "/oficios/" + nombre_imagen;

    const [resultado] = await connection.query(sql, [
      usuario,
      profesion,
      descripcion,
      metodos,
      celular,
      imagen_url,
      visita,
    ]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ message: "Error al registrar los datos" });
    }

    const sql_direccion = `INSERT INTO sei_direccion (calle, colonia, cp, municipio, estado, pais, visible) 
    VALUES (?,?,?,?,?,?,?);`;

    const [direccion] = await connection.query(sql_direccion, [
      calle,
      colonia,
      cp,
      municipio,
      estado,
      pais,
      visible,
    ]);

    const nombreCarpeta = `${resultado.insertId}_documentos`;
    const rutaCompleta = join(
      __dirname,
      "../../public/validaciones/",
      nombreCarpeta
    );
    if (!fs.existsSync(rutaCompleta)) {
      fs.mkdirSync(rutaCompleta);
    }

    let path_identificacion = "";
    if (identificacion) {
      const nombre_ID = `${resultado.insertId}_identificacion.${
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

    let path_selfie = "";
    if (selfie) {
      const name = `${resultado.insertId}_selfie.${selfie.name.split(".")[1]}`;
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

    let path_carta = "";
    if (carta) {
      const name = `${resultado.insertId}_identificacion.${
        carta.name.split(".")[1]
      }`;
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

    const sql_insertar = `UPDATE sei_oficio SET identificacion = ? , selfie = ?, carta = ?, direccion = ? WHERE id_oficio =?`;

    await connection.query(sql_insertar, [
      path_identificacion,
      path_selfie,
      path_carta,
      direccion.insertId,
      resultado.insertId,
    ]);

    return res.status(200).json({ message: "Datos registrados" });
  } catch (error) {
    console.log(error);
    return res.status(500).json({ error });
  }
};

const actualizarUbicacion = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { id, ubicacion } = req.body;

    const sql = `UPDATE sei_oficio SET ubicacion = ? WHERE id_oficio =?;`;

    await connection.query(sql, [ubicacion, id]);
    return res.status(200).json();
  } catch (error) {
    return res.status(500).json({ error });
  }
};

const obtenerDatos = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { usuario } = req.body;
    const sql = `SELECT * FROM sei_oficio o
    LEFT JOIN sei_direccion d ON o.direccion = d.id_direccion
    WHERE usuario = ?;`;

    const [oficio] = await connection.query(sql, [usuario]);

    if (oficio.length === 0) {
      return res.status(404).json({ message: "Error al recuperar los datos" });
    }

    return res.status(200).json(oficio);
  } catch (error) {
    return res.status(500).json(error);
  }
};

const cambiarEstatus = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const { oficio, estatus } = req.body;

    const sql = `UPDATE sei_oficio SET estatus = ? WHERE id_oficio = ?`;

    const [resultado] = await connection.query(sql, [estatus, oficio]);

    if (resultado.affectedRows === 0) {
      return res.status(404).json({ message: "No se encontró el registro" });
    }

    return res.status(200).json({ message: "Completado" });
  } catch (error) {
    return res.status(500).json(error);
  }
};

module.exports = {
  convertirseProfesionista,
  actualizarUbicacion,
  obtenerDatos,
  cambiarEstatus,
};
