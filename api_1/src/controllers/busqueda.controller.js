const { validationResult } = require("express-validator");
const clienteSchema = require("../models/cliente.model.js");
const busqueda = async (req, res) => {
  try {
    // Revisar si hay errores en el cuerpo de la petición
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }

    const busqueda = req.params.busqueda;
    const solicitante = req.params.solicitante;
    const palabra = removeSpecialCharactersAndAccents(busqueda);
    const regex = new RegExp(palabra, "i");

    const resultados = await clienteSchema
      .find({
        $and: [
          {
            $or: [
              { palabras_claves: regex },
              { profesion: regex },
              { descripcion: regex },
            ],
          },
          {
            usuario: { $ne: solicitante },
          },
        ],
      })
      .populate(
        "usuario",
        "nombre correo apellido_p apellido_m imagen auth favoritos"
      )
      .populate({
        path: "opiniones",
        select: "calificacion",
        model: "opiniones",
      });

    if (resultados.length === 0) {
      return res.status(404).json({ message: "No hay resultados" });
    }

    resultados.forEach((resultado) => {
      const opiniones = resultado.opiniones;
      if (opiniones.length > 0) {
        const sumaCalificaciones = opiniones.reduce(
          (suma, opinion) => suma + opinion.calificacion,
          0
        );
        resultado.calificacion = sumaCalificaciones / opiniones.length;
      } else {
        resultado.calificacion = 0;
      }
    });

    // console.log(resultados);
    return res.status(200).json(resultados);
  } catch (error) {
    console.log(error);
    return res.status(500).json(error);
  }
};

function removeSpecialCharactersAndAccents(str) {
  // Elimina acentos
  const sinAcentos = str.normalize("NFD").replace(/[\u0300-\u036f]/g, "");
  // Elimina caracteres que no son letras, números o espacios
  return sinAcentos.replace(/[^\w\s]/gi, "");
}

module.exports = { busqueda };
