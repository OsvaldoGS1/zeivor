const Router = require("express");
const { busqueda_oficios } = require("../controllers/busqueda.controller");

const router = Router();

router.get(
  "/resultado/:usuario/:busqueda/:latitud/:longitud",
  busqueda_oficios
);

module.exports = router;
