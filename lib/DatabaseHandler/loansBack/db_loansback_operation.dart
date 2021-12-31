import 'package:gstock/DatabaseHandler/db_helper.dart';
import 'package:gstock/Models/loan_back.dart';
import 'package:sqflite/sqflite.dart';

class DbLoanBack {
  DbLoanBack._privateConstructor();
  static final DbLoanBack instance = DbLoanBack._privateConstructor();

  Future<int> saveLoanBack(LoanBack loanBack) async {
    var db = await DbHelper.instance.db;
    var res = await db!.insert(DbHelper.tableLoanBack, loanBack.toMap());
    return res;
  }

  Future<LoanBack?> getLoanBackById(int? loanBackId) async {
    Database? db = await DbHelper.instance.db;
    var res =
    await db!.rawQuery("SELECT * FROM ${DbHelper.tableLoanBack} WHERE "
        "${DbHelper.loanBackId} = '$loanBackId' ");
    if (res.isNotEmpty) {
      return LoanBack.fromMap(res.first);
    }
    return null;
  }

  Future<List<LoanBack>> getLoansBack() async {
    Database? db = await DbHelper.instance.db;
    var loanBacks = await db!
        .query(DbHelper.tableLoanBack, orderBy: '${DbHelper.loanBackId} DESC');
    List<LoanBack> loanBacksList = loanBacks.isNotEmpty ? loanBacks.map((c) => LoanBack.fromMap(c)).toList() : [];
    return loanBacksList;
  }
  Future<List<Map<String, Object?>>> getLoanBackWithAllInfo() async {
    Database? db = await DbHelper.instance.db;
    var res = await db!
        .rawQuery('SELECT * FROM ${DbHelper.tableLoanBack} '
        'INNER JOIN ${DbHelper.tableLoans} ON ${DbHelper.tableLoanBack}.${DbHelper.loanId} = ${DbHelper.tableLoans}.${DbHelper.loanId} '
        'INNER JOIN ${DbHelper.tableMembers} ON ${DbHelper.tableLoanBack}.${DbHelper.memberId} = ${DbHelper.tableMembers}.${DbHelper.memberId} '
        'INNER JOIN ${DbHelper.tableAdmin} ON ${DbHelper.tableLoanBack}.${DbHelper.adminId} = ${DbHelper.tableAdmin}.${DbHelper.adminId} ');
    return res;
  }
  Future<int> updateLoanBack(LoanBack loanBack) async {
    var db = await DbHelper.instance.db;
    var res = await db!.update(DbHelper.tableLoanBack, loanBack.toMap(),
        where: '${DbHelper.loanBackId} = ?', whereArgs: [loanBack.loanBackId]);
    return res;
  }

  Future<int> deleteLoanBack(int? loanBackId) async {
    var db = await DbHelper.instance.db;
    var res = await db!.delete(DbHelper.tableLoanBack,
        where: '${DbHelper.loanBackId} = ?', whereArgs: [loanBackId]);
    return res;
  }
}
