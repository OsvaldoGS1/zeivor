const Router = require("express");
const {
  solicitudDirecta,
  obtenerDatosSolicitudDirectaSolicitante,
  obtenerSolicitudesDirectaCliente,
} = require("../controllers/solicitud.controller");

const router = Router();

router.post("/directa", solicitudDirecta);
router.post("/obtener/solicitante", obtenerDatosSolicitudDirectaSolicitante);
router.post("/obtener/cliente", obtenerSolicitudesDirectaCliente);

module.exports = router;
