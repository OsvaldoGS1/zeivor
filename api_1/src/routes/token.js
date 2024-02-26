const Router = require("express");
const {
  agregarToken,
  eliminarToken,
} = require("../controllers/token.controller");

const router = Router();

router.put("/agregar", agregarToken);
router.put("/eliminar", eliminarToken);

module.exports = router;
