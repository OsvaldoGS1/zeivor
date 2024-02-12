const fs = require("fs");

const Eliminar = {
  imagen_usuario(ruta) {
    let archivo_eliminado = false;
    if (fs.existsSync(ruta)) {
      //   console.log("Archivo encontrado");
      try {
        fs.unlinkSync(ruta);
        archivo_eliminado = true;
        // console.log("Archivo eliminado");
      } catch {
        archivo_eliminado = false;
        // console.log("Archivo no eliminado");
      }
    } else {
      archivo_eliminado = false;
    }
    return archivo_eliminado;
  },
};

module.exports = { Eliminar };
