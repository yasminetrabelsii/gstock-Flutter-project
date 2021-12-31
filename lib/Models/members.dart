class Members {
  late int? memberId;
  late String cin;
  late String firstName;
  late String lastName;
  late String email;
  late String phone;
  late String adresse;

  Members(this.cin, this.firstName, this.lastName, this.email, this.phone,
      this.adresse,
      {this.memberId});


  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'memberId': memberId,
      'cin': cin,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'adresse': adresse
    };
    return map;
  }

  Members.fromMap(Map<String, dynamic> map) {
    memberId = map['memberId'];
    cin = map['cin'];
    firstName = map['firstName'];
    lastName = map['lastName'];
    email = map['email'];
    phone = map['phone'];
    adresse = map['adresse'];
  }
}
