import 'package:gstock/DatabaseHandler/db_helper.dart';
import 'package:gstock/Models/members.dart';
import 'package:sqflite/sqflite.dart';

class DbMembers {
  DbMembers._privateConstructor();
  static final DbMembers instance = DbMembers._privateConstructor();

  Future<int> saveMember(Members members) async {
    var db = await DbHelper.instance.db;
    var res = await db!.insert(DbHelper.tableMembers, members.toMap());
    return res;
  }

  Future<Members?> getMemberById(int memberId) async {
    Database? db = await DbHelper.instance.db;
    var res =
    await db!.rawQuery("SELECT * FROM ${DbHelper.tableMembers} WHERE "
        "${DbHelper.memberId} = '$memberId' ");
    if (res.isNotEmpty) {
      return Members.fromMap(res.first);
    }
    return null;
  }
  Future<Members?> getMemberByCin(String cin) async {
    Database? db = await DbHelper.instance.db;
    var res =
    await db!.rawQuery("SELECT * FROM ${DbHelper.tableMembers} WHERE "
        "${DbHelper.cin} = '$cin' ");
    if (res.isNotEmpty) {
      return Members.fromMap(res.first);
    }
    return null;
  }
  Future<List<Members>> getMembers() async {
    Database? db = await DbHelper.instance.db;
    var categories = await db!
        .query(DbHelper.tableMembers, orderBy: '${DbHelper.memberId} DESC');
    List<Members> categoryList = categories.isNotEmpty
        ? categories.map((c) => Members.fromMap(c)).toList()
        : [];
    return categoryList;
  }

  Future<int> updateMember(Members members) async {
    var db = await DbHelper.instance.db;
    var res = await db!.update(DbHelper.tableMembers, members.toMap(),
        where: '${DbHelper.memberId} = ?', whereArgs: [members.memberId]);
    return res;
  }

  Future<int> deleteMember(int? memberId) async {
    var db = await DbHelper.instance.db;
    var res = await db!.delete(DbHelper.tableMembers,
        where: '${DbHelper.memberId} = ?', whereArgs: [memberId]);
    return res;
  }
}
