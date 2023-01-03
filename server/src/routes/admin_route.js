const express = require("express");
const auth = require("../middlewares/auth");
const { Product } = require("../models/product_model");
const User = require("../models/user_model");
const adminRouter = express.Router();

adminRouter.post("/admin/product/add", auth, async (req, res) => {
  try {
    const { user_id, name, category, description, quantity, price, images } =
      req.body;

    const user = await User.findById(user_id);

    if (user.type !== "admin")
      return res
        .status(400)
        .json({ message: "You are not admin. Authentication denied" });

    let product = new Product({
      user_id,
      name,
      category,
      description,
      quantity,
      price,
      images,
    });

    product = await product.save();
    return res.json(product);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

adminRouter.post("/admin/product/delete", auth, async (req, res) => {
  try {
    // product id
    const { id } = req.body;
    const product = await Product.findByIdAndDelete(id);
    res.json(product);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

adminRouter.post("/admin/product/update", auth, async (req, res) => {
  try {
    const { _id, name, category, description, quantity, price, images } =
      req.body;

    const product = await Product.findByIdAndUpdate(_id, {
      name,
      category,
      description,
      quantity,
      price,
      images,
    });

    res.json(product);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = adminRouter;
