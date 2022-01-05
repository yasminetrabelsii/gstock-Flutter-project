import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static const int version = 1;
  static const String dbName = 'gstock.db';
//table Admin
  static const String tableAdmin = 'admin';
  static const String adminId = 'adminId';
  static const String userName = 'userName';
  static const String email = 'email';
  static const String password = 'password';
  static const String adminImage = 'adminImage';
//table Category
  static const String tableCategory = 'category';
  static const String categoryId = 'categoryId';
  static const String categoryTitle = 'categoryTitle';
  static const String description = 'description';
//table Product
  static const String tableProduct = 'product';
  static const String productId = 'productId';
  static const String productTitle = 'productTitle';
  static const String quantity = 'quantity';
  static const String purchaseDate = 'purchaseDate';
  static const String productImage = 'productImage';
//table Members
  static const String tableMembers = 'members';
  static const String memberId = 'memberId';
  static const String cin = 'cin';
  static const String firstName = 'firstName';
  static const String lastName = 'lastName';
  static const String phone = 'phone';
  static const String adresse = 'adresse';
//table Loans
  static const String tableLoans = 'loans';
  static const String loanId = 'loanId';
  static const String loanQuantity = 'loanQuantity';
  static const String isVerified = 'isVerified';
  static const String dateOut = 'dateOut';
  static const String dateBack = 'dateBack';
//table LoanBack
  static const String tableLoanBack = 'loanBack';
  static const String loanBackId = 'loanBackId';
  static const String state = 'state';
  static const String dateVerification = 'dateVerification';

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();

  static Database? _db;
  Future<Database> get database async => _db ??= await initDb();

  Future<Database?> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  initDb() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, dbName);
    var db = await openDatabase(path, version: version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int version) async {
    await db.execute("CREATE TABLE $tableAdmin ("
        " $adminId INTEGER PRIMARY KEY autoincrement,"
        " $userName TEXT UNIQUE,"
        " $email TEXT UNIQUE,"
        " $password TEXT,"
        " $adminImage TEXT"
        ")");
    await db.execute("CREATE TABLE $tableCategory ("
        " $categoryId INTEGER PRIMARY KEY autoincrement,"
        " $categoryTitle TEXT,"
        " $description TEXT"
        ")");
    await db.execute("CREATE TABLE $tableProduct ("
        " $productId INTEGER PRIMARY KEY autoincrement,"
        " $productTitle TEXT,"
        " $categoryId INTEGER NOT NULL,"
        " $quantity INTEGER,"
        " $purchaseDate TEXT,"
        " $productImage TEXT,"
        " FOREIGN KEY ($categoryId) REFERENCES $tableCategory ($categoryId) ON DELETE CASCADE "
        ")");
    await db.execute("CREATE TABLE $tableMembers ("
        " $memberId INTEGER PRIMARY KEY autoincrement,"
        " $cin TEXT UNIQUE,"
        " $firstName TEXT,"
        " $lastName TEXT,"
        " $email TEXT UNIQUE,"
        " $phone TEXT UNIQUE,"
        " $adresse TEXT"
        ")");
    await db.execute("CREATE TABLE $tableLoans ("
        " $loanId INTEGER PRIMARY KEY autoincrement,"
        " $productId INTEGER NOT NULL,"
        " $memberId INTEGER NOT NULL,"
        " $adminId INTEGER NOT NULL,"
        " $loanQuantity INTEGER ,"
        " $isVerified TEXT,"
        " $dateOut TEXT,"
        " $dateBack TEXT,"
        " FOREIGN KEY ($productId) REFERENCES $tableProduct ($productId) ON DELETE RESTRICT,"
        " FOREIGN KEY ($memberId) REFERENCES $tableMembers ($memberId) ON DELETE RESTRICT,"
        " FOREIGN KEY ($adminId) REFERENCES $tableAdmin ($adminId) ON DELETE RESTRICT "
        ")");
    await db.execute("CREATE TABLE $tableLoanBack ("
        " $loanBackId INTEGER PRIMARY KEY autoincrement,"
        " $loanId INTEGER NOT NULL,"
        " $memberId INTEGER NOT NULL,"
        " $adminId INTEGER NOT NULL,"
        " $state TEXT,"
        " $dateVerification TEXT,"
        " FOREIGN KEY ($loanId) REFERENCES $tableLoans ($loanId) ON DELETE RESTRICT,"
        " FOREIGN KEY ($memberId) REFERENCES $tableMembers ($memberId) ON DELETE RESTRICT,"
        " FOREIGN KEY ($adminId) REFERENCES $tableAdmin ($adminId) ON DELETE RESTRICT "
        ")");
  }
}
