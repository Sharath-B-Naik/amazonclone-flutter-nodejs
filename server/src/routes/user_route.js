const express = require('express');
const auth = require('../middlewares/auth');
const { Product } = require('../models/product_model');
const User = require('../models/user_model');
const userRouter = express.Router();

userRouter.get("/api/user/get-details", auth, async (req, res) => {
    try {
        let user = await User.findById(req.userid);
        return res.json(user);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});


userRouter.post("/api/cart/add", auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.userid);

        user.cart.push({ product, quantity: 1 });
        user = await user.save();
        res.json(user);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});


userRouter.post("/api/cart/increase-quantity", auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.userid);

        for (let i = 0; i < user.cart.length; i++) {
            if (user.cart[i].product._id.equals(product._id)) {
                user.cart[i].quantity += 1;
                break;
            }
        }

        user = await user.save();
        res.json([...user._doc['cart']]);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

userRouter.post("/api/cart/decrease-quantity", auth, async (req, res) => {
    try {
        const { id } = req.body;
        const product = await Product.findById(id);
        let user = await User.findById(req.userid);

        for (let i = 0; i < user.cart.length; i++) {
            if (user.cart[i].product._id.equals(product._id)) {
                user.cart[i].quantity -= 1

                if (user.cart[i].quantity == 0) user.cart.splice(i, 1);
                break;
            }
        }

        user = await user.save();
        res.json([...user._doc['cart']]);
    } catch (error) {
        res.status(500).json({ message: error.message });
    }
});

module.exports = userRouter;