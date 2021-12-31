import 'package:gstock/DatabaseHandler/db_helper.dart';
import 'package:gstock/Models/loans.dart';
import 'package:gstock/Models/members.dart';
import 'package:sqflite/sqflite.dart';

class DbLoan {
  DbLoan._privateConstructor();
  static final DbLoan instance = DbLoan._privateConstructor();

  Future<int> saveLoan(Loans loan) async {
    var db = await DbHelper.instance.db;
    var res = await db!.insert(DbHelper.tableLoans, loan.toMap());
    return res;
  }

  Future<Loans?> getLoanById(int? loanId) async {
    Database? db = await DbHelper.instance.db;
    var res =
    await db!.rawQuery("SELECT * FROM ${DbHelper.tableLoans} WHERE "
        "${DbHelper.loanId} = '$loanId' ");
    if (res.isNotEmpty) {
      return Loans.fromMap(res.first);
    }
    return null;
  }

  Future<List<Loans>> getLoans() async {
    Database? db = await DbHelper.instance.db;
    var loans = await db!
        .query(DbHelper.tableLoans, orderBy: '${DbHelper.loanId} DESC');
    List<Loans> loansList = loans.isNotEmpty
        ? loans.map((c) => Loans.fromMap(c)).toList()
        : [];
    return loansList;
  }
  Future<List<Map<String, Object?>>> getLoansByMemberId(Members members) async {
    Database? db = await DbHelper.instance.db;
    List<Map<String, Object?>> res = await db!.rawQuery('SELECT * FROM ${DbHelper.tableLoans} '
        'INNER JOIN ${DbHelper.tableProduct} ON ${DbHelper.tableLoans}.${DbHelper.productId} = ${DbHelper.tableProduct}.${DbHelper.productId} '
        'INNER JOIN ${DbHelper.tableMembers} ON ${DbHelper.tableLoans}.${DbHelper.memberId} = ${DbHelper.tableMembers}.${DbHelper.memberId} '
        'INNER JOIN ${DbHelper.tableAdmin} ON ${DbHelper.tableLoans}.${DbHelper.adminId} = ${DbHelper.tableAdmin}.${DbHelper.adminId} '
        'WHERE ${DbHelper.tableLoans}.${DbHelper.memberId} = ${members.memberId} AND '
        '${DbHelper.tableLoans}.${DbHelper.isVerified} LIKE "%${false.toString()}%" '
    );
    return res;
  }
  Future<List<Map<String, Object?>>> getLoansWithAllInfo() async {
    Database? db = await DbHelper.instance.db;
    var res = await db!
        .rawQuery('SELECT * FROM ${DbHelper.tableLoans} '
        'INNER JOIN ${DbHelper.tableProduct} ON ${DbHelper.tableLoans}.${DbHelper.productId} = ${DbHelper.tableProduct}.${DbHelper.productId} '
        'INNER JOIN ${DbHelper.tableMembers} ON ${DbHelper.tableLoans}.${DbHelper.memberId} = ${DbHelper.tableMembers}.${DbHelper.memberId} '
        'INNER JOIN ${DbHelper.tableAdmin} ON ${DbHelper.tableLoans}.${DbHelper.adminId} = ${DbHelper.tableAdmin}.${DbHelper.adminId} '
    );
    return res;
  }
  Future<int> updateLoan(Loans loan) async {
    var db = await DbHelper.instance.db;
    var res = await db!.update(DbHelper.tableLoans, loan.toMap(),
        where: '${DbHelper.loanId} = ?', whereArgs: [loan.loanId]);
    return res;
  }

  Future<int> deleteLoan(int? loanId) async {
    var db = await DbHelper.instance.db;
    var res = await db!.delete(DbHelper.tableLoans,
        where: '${DbHelper.loanId} = ?', whereArgs: [loanId]);
    return res;
  }
}
