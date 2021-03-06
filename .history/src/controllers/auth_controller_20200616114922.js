const { Router } = require("express");
const router = Router();

const User = require("../models/userModel");
const verifyToken = require("./verifyToken");

const jwt = require("jsonwebtoken");
const config = require("../config");

const productController = require("./ProductController");

router.post("/signup", async (req, res) => {
  try {
    const { username, email, password } = req.body;
    const UserFind = await User.findOne({email: email})
    if(UserFind){
      res.send("Email already exist");
    }
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

    res.status(200).json({ auth: true, token, user });
  } catch (error) {
    console.log(error);
    res.status(500, send("There was a problem registering"));
  }
});

router
  .route("/products")
  .get(productController.index)
  .post(productController.new);

router
  .route("/product/:id")
  .get(productController.view)
  .put(productController.update)
  .delete(productController.delete);

router.post("/signin", async (req, res) => {
  try {
    const user = await User.findOne({ email: req.body.email });
    if (!user) {
      return res.status(404).send("No email");
    }

    const validPassword = await user.validatePassword(
      req.body.password,
      user.password
    );
    if (!validPassword) {
      return res.status(404).send({ auth: false, token: null });
    }

    const token = jwt.sign({ id: user._id }, config.secret, {
      expiresIn: "24h",
    });

    res.status(200).json({ auth: true, token, user });
  } catch (error) {
    console.log(error);
    res.status(500).send("there was a problem signin");
  }
});

router.get("/dashboard", (req, res) => {
  res.json("dashboard");
});

router.get("/logout", async (req, res) => {
  res.status(200).send({ auth: false, token: null });
});

module.exports = router;
