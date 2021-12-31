import 'package:gstock/DatabaseHandler/db_helper.dart';
import 'package:gstock/Models/admin.dart';

class DbAdmin{

  DbAdmin._privateConstructor();
  static final DbAdmin instance = DbAdmin._privateConstructor();

  Future<int> saveAdminData(Admin admin) async {
    var dbClient = await DbHelper.instance.db;
    var res = await dbClient!.insert(DbHelper.tableAdmin, admin.toMap());
    print(res);
    return res;
  }

  Future<Admin?> getLoginData(String username, String password) async {
    var dbClient =  await DbHelper.instance.db;
    var res = await dbClient!.rawQuery("SELECT * FROM ${DbHelper.tableAdmin} WHERE "
        "${DbHelper.email} = '$username' OR "
        "${DbHelper.userName} = '$username'");

    if (res.isNotEmpty) {
      Admin admin = Admin.fromMap(res.first);
      if(admin.password == password) {
        return admin;
      }
    }

    return null;
  }

  Future<int> updateAdmin(Admin admin) async {
    var dbClient = await DbHelper.instance.db;
    var res = await dbClient!.update(DbHelper.tableAdmin, admin.toMap(),
        where: '${DbHelper.adminId} = ?', whereArgs: [admin.adminId]);
    return res;
  }

  Future<int> deleteAdmin(String adminId) async {
    var dbClient = await DbHelper.instance.db;
    var res = await dbClient!.delete(DbHelper.tableAdmin, where: '$adminId = ?', whereArgs: [adminId]);
    return res;
  }
}