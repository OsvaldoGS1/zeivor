const Router = require("express");
const cliente = require("../config/db.js");
const {
  //   pruebaConection,
  registro,
  iniciar_sesion,
} = require("../controllers/usuario.controller");

const router = Router();

// router.get("/", pruebaConection);
// router.post("/registro", registro);

router.post("/login", iniciar_sesion);
router.post("/registro", registro);
// router.post("/imagen", agregarImagen);
// router.post("/registro_redes", agregarUsuarioRS);
// router.put("/token", agregarToken);
// router.post("/actualizar", actualizarUsuario);

module.exports = router;
