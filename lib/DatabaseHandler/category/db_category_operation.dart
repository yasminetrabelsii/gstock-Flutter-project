import 'package:gstock/DatabaseHandler/db_helper.dart';
import 'package:gstock/Models/category.dart';
import 'package:sqflite/sqflite.dart';

class DbCategory {
  DbCategory._privateConstructor();
  static final DbCategory instance = DbCategory._privateConstructor();

  Future<int> saveCategory(Category category) async {
    var db = await DbHelper.instance.db;
    var res = await db!.insert(DbHelper.tableCategory, category.toMap());
    return res;
  }

  Future<Category?> getCategoryById(int? categoryId) async {
    Database? db = await DbHelper.instance.db;
    var res =
        await db!.rawQuery("SELECT * FROM ${DbHelper.tableCategory} WHERE "
            "${DbHelper.categoryId} = '$categoryId' ");
    if (res.isNotEmpty) {
      return Category.fromMap(res.first);
    }
    return null;
  }

  Future<List<Category>> getCategories() async {
    Database? db = await DbHelper.instance.db;
    var categories = await db!
        .query(DbHelper.tableCategory, orderBy: '${DbHelper.categoryId} DESC');
    List<Category> categoryList = categories.isNotEmpty
        ? categories.map((c) => Category.fromMap(c)).toList()
        : [];
    return categoryList;
  }

  Future<int> updateCategory(Category category) async {
    var db = await DbHelper.instance.db;
    var res = await db!.update(DbHelper.tableCategory, category.toMap(),
        where: '${DbHelper.categoryId} = ?', whereArgs: [category.categoryId]);
    return res;
  }

  Future<int> deleteCategory(int? categoryId) async {
    var db = await DbHelper.instance.db;
    var res = await db!.delete(DbHelper.tableCategory,
        where: '${DbHelper.categoryId} = ?', whereArgs: [categoryId]);
    return res;
  }
}
