const mongoose = require("mongoose");
// const { MongoClient, ServerApiVersion } = require("mongodb");
// const uri =
//   "mongodb+srv://psd_zeivor_api:Am93KnI9pNDYPpXo@cluster0.ln4ausm.mongodb.net/?retryWrites=true&w=majority";
// Create a MongoClient with a MongoClientOptions object to set the Stable API version
// const cliente = new MongoClient(uri, {
//   serverApi: {
//     version: ServerApiVersion.v1,
//     strict: true,
//     deprecationErrors: true,
//   },
// });
const mongoString = process.env.DATABASE_URL;
mongoose
  .connect(mongoString, {
    // useUnifiedTopology: true,
    // useNewUrlParser: true,
  })
  .then((db) => console.log("Database connect "))
  .catch((error) => console.log(error));

// module.exports = cliente;
