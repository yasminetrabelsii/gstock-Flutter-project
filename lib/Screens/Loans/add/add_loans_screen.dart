import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gstock/DatabaseHandler/loans/db_loans_operation.dart';
import 'package:gstock/DatabaseHandler/members/db_members_opertation.dart';
import 'package:gstock/DatabaseHandler/product/db_product_opertation.dart';
import 'package:gstock/Models/admin.dart';
import 'package:gstock/Models/loans.dart';
import 'package:gstock/Models/members.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/components/members_dropdown.dart';
import 'package:gstock/components/products_dropdown.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_date_filed.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/routes/route.dart' as route;
import 'package:gstock/constants.dart';

class LoanAddScreen extends StatefulWidget {
  const LoanAddScreen({Key? key}) : super(key: key);

  @override
  State<LoanAddScreen> createState() => _LoanAddScreenState();
}

class _LoanAddScreenState extends State<LoanAddScreen> {
  GetStorage loginStorage = GetStorage(storeAdmin);
  late Product _selectedProduct;
  late Members _selectedMember;
  late Admin admin;
  final _loanQuantityController = TextEditingController();
  final _dateOutController = TextEditingController();
  final _dateBackController = TextEditingController();
  DateTime _dateOut = DateTime.now();
  DateTime _dateBack = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    admin = Admin.fromMap(loginStorage.read(adminData));
  }

  getSelectedProduct(selectedProduct) {
    setState(() {
      _selectedProduct = selectedProduct;
    });
  }

  getSelectedMember(selectedMember) {
    setState(() {
      _selectedMember = selectedMember;
    });
  }

  addLoan() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Loans loan = Loans(
          _selectedProduct.productId,
          _selectedMember.memberId,
          admin.adminId,
          int.parse(_loanQuantityController.text),
          _dateOut,
          _dateBack);
      if(_selectedProduct.quantity<loan.loanQuantity){
        alertDialog(context, 'Product quantity is less than laon quantity', 1);
      }else if(_dateBack.isBefore(_dateOut)){
        alertDialog(context, 'Date back is before Date out', 1);
      }else{
        await DbLoan.instance.saveLoan(loan).then((laonData) {
          _selectedProduct.quantity -= loan.loanQuantity;
          DbProduct.instance.updateProduct(_selectedProduct).whenComplete(() =>
              Navigator.pushNamedAndRemoveUntil(
                  context, route.homeScreen, (Route<dynamic> route) => false));
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
      appBar: buildAppBar(context, "Add New Loan"),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                FutureBuilder<List<Product>>(
                  future: DbProduct.instance.getProducts(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? ProductsDropDown(
                            callback: getSelectedProduct,
                            products: snapshot.data,
                          )
                        : const Text('No Product');
                  },
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: _loanQuantityController,
                  hintText: "quantity loans",
                  icon: Icons.add_shopping_cart,
                  // onChanged: (value) {},
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
                RoundedDateField(
                  controller: _dateOutController,
                  hintText: 'Date out',
                  callback: (DateTime dateTime) {
                    _dateOut = dateTime;
                  },
                ),
                SizedBox(height: size.height * 0.03),
                RoundedDateField(
                  controller: _dateBackController,
                  hintText: 'Date Back',
                  callback: (DateTime dateTime) {
                    _dateBack = dateTime;
                  },
                ),
                RoundedButton(
                  text: "Save",
                  press: addLoan,
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
