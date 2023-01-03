const express = require("express");
const auth = require("../middlewares/auth");
const { Product } = require("../models/product_model");
const User = require("../models/user_model");

const productRouter = express.Router();

productRouter.get("/products/get", async (req, res) => {
  try {
    const products = await Product.find({});
    res.json(products);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

productRouter.get("/products/search/:name", async (req, res) => {
  try {
    const products = await Product.find({
      name: { $regex: req.params.name, $options: "i" },
    });

    res.json(products);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

productRouter.post("/product/rate", auth, async (req, res) => {
  try {
    const { user_id, product_id, rating } = req.body;

    let product = await Product.findById(product_id);
    console.log(product.ratings);

    for (let index = 0; index < product.ratings.length; index++) {
      const rated_user_id = product.ratings[index].user_id;

      if (rated_user_id === user_id) {
        product.ratings.splice(index, 1);
        break;
      }
    }

    product.ratings.push({ user_id, rating });
    product = await product.save();

    res.json(product);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

productRouter.post("/product/cart/add", auth, async (req, res) => {
  try {
    const { id, quantity } = req.body;
    const product = await Product.findById(id);
    let user = await User.findById(req.userid);

    if (user.cart.length == 0) {
      user.cart.push({ product, quantity: 1 });
    } else {
      for (let i = 0; i < user.cart.length; i++) {
        if (user.cart[i].product._id.equals(product._id)) {
          user.cart[i].quantity += 1;
          break;
        }
      }
    }

    user = await user.save();
    res.json(user);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

productRouter.get("/product/cart/get", auth, async (req, res) => {
  try {
    const user = await User.findById(req.userid);
    res.json([...user._doc.cart]);
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
});

module.exports = productRouter;
