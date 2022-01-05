class Admin {
  late int? adminId ;
  late String userName;
  late String email;
  late String password;
  late String adminImage;

  Admin(this.userName, this.email, this.password,this.adminImage,{this.adminId});

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'adminId': adminId,
      'userName': userName,
      'email': email,
      'password': password,
      'adminImage':adminImage
    };
    return map;
  }

  Admin.fromMap(Map<String, dynamic> map) {
    adminId = map['adminId'];
    userName = map['userName'];
    email = map['email'];
    password = map['password'];
    adminImage = map['adminImage'];
  }
}
