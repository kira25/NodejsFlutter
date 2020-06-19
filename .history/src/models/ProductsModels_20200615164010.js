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

module.exports = mongoose.model("product", productSchema);

