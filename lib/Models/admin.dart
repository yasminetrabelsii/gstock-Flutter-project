class Admin {
  late int? adminId ;
  late String userName;
  late String email;
  late String password;

  Admin(this.userName, this.email, this.password,{this.adminId});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'adminId': adminId,
      'userName': userName,
      'email': email,
      'password': password
    };
    return map;
  }

  Admin.fromMap(Map<String, dynamic> map) {
    adminId = map['adminId'];
    userName = map['userName'];
    email = map['email'];
    password = map['password'];
  }
}
