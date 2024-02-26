const Router = require("express");
const {
  agregarFavorito,
  eliminarDeFavoritos,
  obtenerFavoritos,
} = require("../controllers/favoritos.controller.js");

const router = Router();

router.post("/agregar", agregarFavorito);
router.post("/eliminar", eliminarDeFavoritos);
router.post("/obtener", obtenerFavoritos);

module.exports = router;
