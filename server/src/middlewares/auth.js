const jwt = require("jsonwebtoken");
const { jwt_secret } = require("../constants/secrets");
const User = require("../models/user_model");

const auth = async (req, res, next) => {
  try {
    const bearertoken = req.headers.authorization;
    if (!bearertoken) return res.status(400).json({ message: "No auth token" });

    const userid = jwt.verify(bearertoken.split(" ")[1], jwt_secret);

    if (!userid) return res.status(400).json({ message: "Invalid token" });
    req.userid = userid;
    next();
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

module.exports = auth;
