const express = require("express");
const app = express();

app.use(express.json()); // recepcion solo de formatos JSON
app.use(express.urlencoded({ urlencoded: false }));

app.use(require("./controllers/auth_controller.js"));

module.exports = app;
