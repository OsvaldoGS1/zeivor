const Router = require("express");
const { obtenerEstados } = require("../controllers/estados.controller");

const router = Router();

router.get("/", obtenerEstados);

module.exports = router;
