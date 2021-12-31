class Category {
  late int? categoryId;
  late String categoryTitle;
  late String description;

  Category(this.categoryTitle,this.description,{this.categoryId});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{'categoryId': categoryId, 'categoryTitle': categoryTitle,'description':description};
    return map;
  }

  Category.fromMap(Map<String, dynamic> map) {
    categoryId = map['categoryId'];
    categoryTitle = map['categoryTitle'];
    description = map['description'];
  }
}
