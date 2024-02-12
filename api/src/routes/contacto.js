const Router = require("express");
const {
  agregarTrabajo,
  consultaOfertas,
  aceptarOferta,
} = require("../controllers/contacto.controller");

const router = Router();

router.post("/agregar", agregarTrabajo);
router.post("/consultar", consultaOfertas);
router.post("/aceptar", aceptarOferta);

module.exports = router;
