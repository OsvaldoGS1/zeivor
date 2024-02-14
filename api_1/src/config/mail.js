const nodemailer = require("nodemailer");

const transporter = nodemailer.createTransport({
  host: "v256382.neubox.net",
  port: 465,
  secure: true,
  auth: {
    user: "_mainaccount@seivor.com",
    pass: "rTB2#OcBiF8Y",
  },
});

module.exports = { transporter };
