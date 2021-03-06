let mongoose = require("mongoose");

let productSchema = mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  price: Number,
  stock: Number,
  create: {
    type: Date,
    default: Date.now,
  },
});

let Product = module.exports = mongoose.model("product", productSchema);

