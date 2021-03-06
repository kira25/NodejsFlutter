const Product = require("../models/ProductsModels");

exports.index = (req, res) => {
  Product.get((err, product) => {
    if (err) {
      res.json({
        status: "err",
        code: 500,
        message: err,
      });
    }
    res.json(product);
  });
};
//Add a new product
exports.new = function (req, res) {
  let product = new Product();
  product.name = req.body.name;
  product.price = req.body.price;
  product.stock = req.body.stock;
  product.save(function (err) {
    if (err) {
      res.json({
        status: "err",
        code: 500,
        message: err,
      });
    }
    res.json({
      status: "success",
      code: 200,
      message: "Register save",
      data: product,
    });
  });
};

exports.view = function (req, res) {
  Product.findById(req.params.id, function (err, product) {
    if (err) {
      res.json({
        status: "err",
        code: 500,
        message: err,
      });
    }
    res.json({
      status: "success",
      code: 200,
      message: "Registro encontrado",
      data: product,
    });
  });
};
