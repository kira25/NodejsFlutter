class Product {
  String name;
  int price;
  int stock;

  Product(this.name, this.price, this.stock);

  Map toJson() => {'name': name, 'price': price, 'stock': stock};

  Product.fromMap(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        stock = json['stock'];
}
