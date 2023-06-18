class CartModel {
  String? name;
  int? qty;
  double? price;

  CartModel({
    this.name,
    this.qty,
    this.price,
  });

  factory CartModel.fromJson(json) {
    return CartModel(
      name: json['name'],
      price: json['price'],
      qty: json['qty'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "qty": qty,
      "price": price,
    };
  }
}
