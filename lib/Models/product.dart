class Product {
  late int? productId;
  late String productTitle;
  late int? categoryId;
  late int quantity;
  late DateTime purchaseDate;

  Product(this.productTitle, this.categoryId, this.quantity, this.purchaseDate,
      {this.productId});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'productId': productId,
      'productTitle': productTitle,
      'categoryId': categoryId,
      'quantity': quantity,
      'purchaseDate': purchaseDate.toIso8601String()
    };
    return map;
  }

  Product.fromMap(Map<String, dynamic> map) {
    productId = map['productId'];
    productTitle = map['productTitle'];
    categoryId = map['categoryId'];
    quantity = map['quantity'];
    purchaseDate = DateTime.parse(map['purchaseDate']);
  }
}
