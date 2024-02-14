const express = require("express");
const morgan = require("morgan");
const fileupload = require("express-fileupload");

const router = require("./routes/index.js");
const cors = require("cors");
const { CORS_ORIGIN } = require("./config/index.js");
const { join } = require("path");
// const { fileURLToPath } = require("url");

// inicialización de express
const app = express();

// Middlewares
app.use(cors({ origin: CORS_ORIGIN }));
app.use(fileupload());
app.use(express.static(join(__dirname, "../public/")));

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(morgan("dev"));

// Routes
app.use("/api", router);

// export default app;
module.exports = app;
