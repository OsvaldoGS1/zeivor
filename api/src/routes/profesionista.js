const Router = require("express");
const {
  convertirseProfesionista,
  actualizarUbicacion,
  obtenerDatos,
  cambiarEstatus,
} = require("../controllers/profesionista.controller");

const router = Router();

router.post("/crear", convertirseProfesionista);
router.put("/actualizar", actualizarUbicacion);
router.post("/obtener", obtenerDatos);
router.post("/estatus", cambiarEstatus);

module.exports = router;
