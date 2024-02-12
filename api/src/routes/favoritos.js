const Router = require("express");
const {
  trabajadoresFavoritos,
  agregarFavoritos,
  eliminarFavorito,
} = require("../controllers/favoritos.controller");

const router = Router();

router.post("/usuario", trabajadoresFavoritos);
router.post("/agregar", agregarFavoritos);
router.post("/eliminar", eliminarFavorito);

module.exports = router;
