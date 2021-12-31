class Loans {
  late int? loanId;
  late int? productId;
  late int? memberId;
  late int? adminId;
  late int loanQuantity;
  late bool isVerified;
  late DateTime dateOut;
  late DateTime dateBack;

  Loans(this.productId, this.memberId, this.adminId,this.loanQuantity,this.dateOut,
      this.dateBack,
      {this.loanId,this.isVerified = false});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'loanId': loanId,
      'productId': productId,
      'memberId': memberId,
      'adminId': adminId,
      'loanQuantity':loanQuantity,
      'isVerified':isVerified.toString(),
      'dateOut': dateOut.toIso8601String(),
      'dateBack': dateBack.toIso8601String()
    };
    return map;
  }
  Loans.fromMap(Map<String, dynamic> map) {
    loanId = map['loanId'];
    productId = map['productId'];
    memberId = map['memberId'];
    adminId = map['adminId'];
    loanQuantity =map['loanQuantity'];
    isVerified = map['isVerified'] == "true";
    dateOut = DateTime.parse(map['dateOut']);
    dateBack = DateTime.parse(map['dateBack']);
  }
}
