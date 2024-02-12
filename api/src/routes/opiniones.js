const Router = require("express");
const {
  obtenerOpinionesTrabajador,
} = require("../controllers/opiniones.controller");

const router = Router();

router.post("/trabajador", obtenerOpinionesTrabajador);

module.exports = router;
