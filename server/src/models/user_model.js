const mongoose = require("mongoose");
const { productSchema } = require("../models/product_model");

const userSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  type: {
    type: String,
    default: "user", // user/admin
  },
  cart: [
    {
      product: productSchema,
      quantity: {
        type: Number,
        required: true,
        default: 0,
      },
    },
  ],
});

const User = mongoose.model("User", userSchema);
module.exports = User;
