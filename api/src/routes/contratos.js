const Router = require("express");
const {
  consultarContratos,
  terminarTrabajoTrabajador,
  terminarTrabajoCliente,
} = require("../controllers/contratos.controller");

const router = Router();

router.post("/consulta", consultarContratos);
router.post("/aceptar/trabajador", terminarTrabajoTrabajador);
router.post("/aceptar/cliente", terminarTrabajoCliente);

module.exports = router;
