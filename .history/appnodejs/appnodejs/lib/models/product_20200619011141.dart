class Product {
  String name;
  int price;
  int stock;
  String id;

  Product(this.name, this.price, this.stock,this.id);

  Map toJson() => {'name': name, 'price': price, 'stock': stock};

  Product.fromMap(Map<String, dynamic> json)
      : name = json['name'],
        price = json['price'],
        id = json['_id'],
        stock = json['stock'];
}
