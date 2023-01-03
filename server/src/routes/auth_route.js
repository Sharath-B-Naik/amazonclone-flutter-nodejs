const express = require("express");
const User = require("../models/user_model");
const authRouter = express.Router();

const bcryptjs = require("bcryptjs");
const jwt = require("jsonwebtoken");
const { jwt_secret } = require("../constants/secrets");
const auth = require("../middlewares/auth");
const { Product } = require("../models/product_model");

authRouter.post("/api/signup", async (req, res) => {
  try {
    const { name, email, password, type } = req.body;

    const re =
      /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;

    const isValidEmail = email.match(re);
    if (!isValidEmail)
      return res.status(400).json({ message: "Email is invalid" });

    const isExist = await User.findOne({ email });

    if (isExist)
      return res.status(400).json({ message: "User already exists" });

    const hashedPassword = await bcryptjs.hash(password, 8);

    let user = new User({
      name,
      email,
      password: hashedPassword,
      type,
    });

    user = await user.save();

    return res.json(user);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

authRouter.post("/api/signin", async (req, res) => {
  try {
    const { email, password, type } = req.body;
    console.log(email);

    const re =
      /^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;

    const isValidEmail = email.match(re);
    if (!isValidEmail)
      return res.status(400).json({ message: "Email is invalid" });

    const user = await User.findOne({ email });
    if (!user) return res.status(400).json({ message: "User doesn't exists" });


    const isMatched = await bcryptjs.compare(password, user.password);
    if (!isMatched) return res.status(400).json({ message: "Wrong password" });

    const token = jwt.sign(user.id, jwt_secret);
    return res.json({ ...user._doc, token });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

authRouter.get("/api/make-admin", auth, async (req, res) => {
  try {
    let user = await User.findById(req.userid);

    if (user.type === "admin") user.type = "user";
    else user.type = "admin";

    user = await user.save();
    return res.json({ message: "You are now an admin", ...user._doc });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = authRouter;
