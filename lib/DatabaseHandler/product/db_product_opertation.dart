import 'package:gstock/DatabaseHandler/db_helper.dart';
import 'package:gstock/Models/product.dart';
import 'package:sqflite/sqflite.dart';

class DbProduct {
  DbProduct._privateConstructor();
  static final DbProduct instance = DbProduct._privateConstructor();

  Future<int> saveProduct(Product product) async {
    var db = await DbHelper.instance.db;
    var res = await db!.insert(DbHelper.tableProduct, product.toMap());
    return res;
  }

  Future<Product?> getProductById(int productId) async {
    Database? db = await DbHelper.instance.db;
    var res =
    await db!.rawQuery("SELECT * FROM ${DbHelper.tableProduct} WHERE "
        "${DbHelper.productId} = '$productId' ");
    if (res.isNotEmpty) {
      return Product.fromMap(res.first);
    }
    return null;
  }

  Future<List<Product>> getProducts() async {
    Database? db = await DbHelper.instance.db;
    var products = await db!
        .query(DbHelper.tableProduct, orderBy: '${DbHelper.productId} DESC');
    List<Product> productList = products.isNotEmpty
        ? products.map((c) => Product.fromMap(c)).toList()
        : [];
    return productList;
  }
  Future<List<Map<String, Object?>>> getProductsCategories() async {
    Database? db = await DbHelper.instance.db;
    var res = await db!
        .rawQuery('SELECT * FROM product INNER JOIN category ON product.categoryId = category.categoryId');
    return res;
  }
  Future<int> updateProduct(Product product) async {
    var db = await DbHelper.instance.db;
    var res = await db!.update(DbHelper.tableProduct, product.toMap(),
        where: '${DbHelper.productId} = ?', whereArgs: [product.productId]);
    return res;
  }

  Future<int> deleteProduct(int? productId) async {
    var db = await DbHelper.instance.db;
    var res = await db!.delete(DbHelper.tableProduct,
        where: '${DbHelper.productId} = ?', whereArgs: [productId]);
    return res;
  }
}