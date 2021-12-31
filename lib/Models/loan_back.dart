class LoanBack {
  late int? loanBackId;
  late int? loanId;
  late int? memberId;
  late int? adminId;
  late String state;
  late DateTime dateVerification;
  LoanBack(this.loanId, this.memberId, this.adminId, this.state,
      this.dateVerification,
      {this.loanBackId});
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'loanBackId': loanBackId,
      'loanId': loanId,
      'memberId': memberId,
      'adminId': adminId,
      'state': state,
      'dateVerification': dateVerification.toIso8601String(),
    };
    return map;
  }
  LoanBack.fromMap(Map<String, dynamic> map) {
    loanBackId = map['loanBackId'];
    loanId = map['loanId'];
    memberId = map['memberId'];
    adminId = map['adminId'];
    state = map['state'];
    dateVerification = DateTime.parse(map['dateVerification']);
  }
}