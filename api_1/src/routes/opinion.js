const Router = require("express");
const {
  agregarOpinion,
  obtenerOpinionesCliente,
} = require("../controllers/opiniones.controller.js");

const router = Router();

router.post("/agregar", agregarOpinion);
router.post("/cliente", obtenerOpinionesCliente);

module.exports = router;
