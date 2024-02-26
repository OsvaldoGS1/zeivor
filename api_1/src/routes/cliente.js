const Router = require("express");
const {
  registroCliente,
  obtenerDatosCliente,
  cambiarEstatus,
} = require("../controllers/clientes.controller");

const router = Router();

router.post("/registro", registroCliente);
router.post("/obtener", obtenerDatosCliente);
router.post("/estatus", cambiarEstatus);
module.exports = router;
