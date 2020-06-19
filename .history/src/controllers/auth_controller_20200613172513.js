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

    user.password = await user.encr
  } catch (error) {
    print(error);
  }
});
