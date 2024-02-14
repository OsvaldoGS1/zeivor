require("dotenv").config();
require("./config/db.js");

const app = require("./app.js");
const { PORT } = require("./config/config.js");

require("colors");
app.set("port", PORT);

app.listen(app.get("port"), () => {
  console.log(
    `\nServer running on port  http://localhost:${app.get("port")}/\n`.underline
      .bold.blue
  );
});
