const Router = require("express");
const {
  crearAlerta,
  obtenerAlertasUsuario,
  obtenerAlertasParaOficio,
  aceptarAlerta,
} = require("../controllers/alertas.controller");

const router = Router();

router.post("/crear", crearAlerta);
router.post("/aceptar", aceptarAlerta);

router.post("/usuario", obtenerAlertasUsuario);
router.post("/oficio", obtenerAlertasParaOficio);

module.exports = router;
