const express = require("express");
const { default: mongoose } = require("mongoose");
const { DB } = require("./src/constants/secrets");
const adminRouter = require("./src/routes/admin_route");
const authRouter = require("./src/routes/auth_route");
const productRouter = require("./src/routes/prodcut_route");
const userRouter = require("./src/routes/user_route");

const app = express();
const PORT = 3000;

app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);

mongoose
  .connect(DB)
  .then(() => console.log("Connected to database"))
  .catch((e) => console.log(e));

app.listen(PORT, "0.0.0.0", () => {
  console.log(`connected at port ${PORT}`);
});
