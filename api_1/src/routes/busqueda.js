const Router = require("express");
const { busqueda } = require("../controllers/busqueda.controller");
// const { obtenerEstados } = require("../controllers/estados.controller");

const router = Router();

router.get("/:solicitante/:busqueda", busqueda);

module.exports = router;
