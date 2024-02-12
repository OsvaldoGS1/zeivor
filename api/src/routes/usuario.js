const Router = require("express");
const {
  iniciar_sesion,
  registrarse,
  agregarImagen,
  agregarUsuarioRS,
  agregarToken,
  actualizarUsuario,
} = require("../controllers/usuario.controller");

const router = Router();

router.post("/login", iniciar_sesion);
router.post("/registro", registrarse);
router.post("/imagen", agregarImagen);
router.post("/registro_redes", agregarUsuarioRS);
router.put("/token", agregarToken);
router.post("/actualizar", actualizarUsuario);

module.exports = router;
