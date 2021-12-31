import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gstock/DatabaseHandler/loans/db_loans_operation.dart';
import 'package:gstock/DatabaseHandler/loansBack/db_loansback_operation.dart';
import 'package:gstock/DatabaseHandler/members/db_members_opertation.dart';
import 'package:gstock/DatabaseHandler/product/db_product_opertation.dart';
import 'package:gstock/Models/admin.dart';
import 'package:gstock/Models/loan_back.dart';
import 'package:gstock/Models/loans.dart';
import 'package:gstock/Models/members.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/components/loan_dropdown.dart';
import 'package:gstock/components/members_dropdown.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_date_filed.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/routes/route.dart' as route;
import 'package:gstock/constants.dart';

class LoanBackAddScreen extends StatefulWidget {
  const LoanBackAddScreen({Key? key}) : super(key: key);

  @override
  State<LoanBackAddScreen> createState() => _LoanBackAddScreen();
}

class _LoanBackAddScreen extends State<LoanBackAddScreen> {
  GetStorage loginStorage = GetStorage(storeAdmin);
  Members? _selectedMember;
  late Product _selectedProduct;
  late Loans _selectedLoan;
  late Admin admin;
  final _loanStateController = TextEditingController();
  final _dateVerificationController = TextEditingController();
  DateTime _dateVerification = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    admin = Admin.fromMap(loginStorage.read(adminData));
  }


  getSelectedMember(selectedMember) {
    setState(() {
      _selectedMember = selectedMember;
    });
  }

  getSelectedLoan (selectedLoan) {
    setState(() {
      _selectedLoan = Loans.fromMap(selectedLoan);
      print(_selectedLoan.isVerified);
      _selectedProduct =Product.fromMap(selectedLoan);
    });
  }

  addLoanBack() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      LoanBack loanBack = LoanBack(_selectedLoan.loanId,_selectedMember!.memberId,admin.adminId,_loanStateController.text,_dateVerification);
      if (_dateVerification.isBefore(_selectedLoan.dateBack)) {
        alertDialog(context, 'Date Verification is before Date out', 1);
      } else {
        await DbLoanBack.instance.saveLoanBack(loanBack).then((laonData) {
          _selectedProduct.quantity += _selectedLoan.loanQuantity;
          _selectedLoan.isVerified = true;
          DbLoan.instance.updateLoan(_selectedLoan).whenComplete(() =>{
          DbProduct.instance.updateProduct(_selectedProduct).whenComplete(() =>
          Navigator.pushNamedAndRemoveUntil(
          context, route.homeScreen, (Route<dynamic> route) => false))
          });
        }).catchError((error) {
          alertDialog(context, 'Error: Data Save Fail', 1);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Add New Loan Back"),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                _selectedMember == null
                    ? const Text('No Loans') : FutureBuilder<List<Map<String, Object?>>>(
                  future: DbLoan.instance.getLoansByMemberId(_selectedMember!),
                  builder: (context, snapshot) {
                    return snapshot.hasData && _selectedMember != null
                        ? LoansDropDown(
                            callback: getSelectedLoan,
                            loans: snapshot.data,
                          )
                        : const Text('No Loans');
                  },
                ),
                SizedBox(height: size.height * 0.03),
                FutureBuilder<List<Members>>(
                  future: DbMembers.instance.getMembers(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? MembersDropDown(
                            callback: getSelectedMember,
                            members: snapshot.data,
                          )
                        : const Text('No Members');
                  },
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: _loanStateController,
                  hintText: "State",
                  icon: Icons.rule ,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedDateField(
                  controller: _dateVerificationController,
                  hintText: 'Date Verification',
                  callback: (DateTime dateTime) {
                    _dateVerification = dateTime;
                  },
                ),
                RoundedButton(
                  text: "Save",
                  press: addLoanBack,
                ),
                SizedBox(height: size.height * 0.1),
                // OrDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
