const { Router } = require("express");
const router = Router();

const User = require("../models/userModel");
const verifyToken = require("./verifyToken");

const jwt = require("jsonwebtoken");
const config = require("../config");

router.post("/signup", async (req, res) => {
  try {
    const { username, email, password } = req.body;

    const user = new User({
      username,
      email,
      password,
    });

    user.password = await user.encryptPassword(password);
    await user.save();
    const token = jwt.sign({ id: user.id }, config.secret, {
      expiresIn: "24h",
    });

    res.status(200).json({ auth: true, token });
  } catch (error) {
    console.log(error);
    res.status(500, send("There was a problem"));
  }
});