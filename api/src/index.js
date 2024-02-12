const app = require("./app.js");

require("colors");
app.set("port", process.env.PORT || 3000);

app.listen(app.get("port"), () => {
  console.log(
    `\nServer running on port  http://localhost:${app.get("port")}/\n`.underline
      .bold.blue
  );
});
