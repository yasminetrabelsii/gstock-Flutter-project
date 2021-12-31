import 'package:flutter/material.dart';
import 'package:gstock/Models/loans.dart';
import 'package:gstock/Models/members.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/components/text_field_container.dart';
import 'package:gstock/constants.dart';
import 'package:intl/intl.dart';

class LoansDropDown extends StatefulWidget {
  final List<Map<String, Object?>>? loans;
  final Function(Map<String, Object?>) callback;

  const LoansDropDown({
    Key? key,
    required this.loans,
    required this.callback,
  }) : super(key: key);

  @override
  State<LoansDropDown> createState() => _LoansDropDownState();
}

class _LoansDropDownState extends State<LoansDropDown> {
  String _selectLoans = 'Select loan';
  final _selectLoansController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: DropdownButton<Map<String, Object?>>(
          hint: TextFormField(
            cursorColor: kPrimaryColor,
            controller: _selectLoansController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please choose a loan';
              }
              return null;
            },
            style: const TextStyle(color: kPrimaryColor),
            decoration: InputDecoration(
              icon: const Icon(
                Icons.real_estate_agent,
                color: kPrimaryColor,
              ),
              hintText: _selectLoans,
              border: InputBorder.none,
            ),
          ),
          style: const TextStyle(color: kPrimaryColor),
          isExpanded: true,
          onChanged: (Map<String, Object?>? value) {
            setState(() {
              _selectLoans = Members.fromMap(value!).email;
              _selectLoansController.text =
                  "Loan ID " + Loans.fromMap(value).loanId.toString();
              widget.callback(value);
            });
          },
          items: widget.loans!.map((loanBack) {
            return DropdownMenuItem(
              value: loanBack,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Divider(),
                  Text("Product : " + Product.fromMap(loanBack).productTitle),
                  Text("Number of pieces  : " + Loans.fromMap(loanBack).loanQuantity.toString()),
                  Text("Date Out : " + DateFormat('yyyy-MM-dd')
                      .format(Loans.fromMap(loanBack).dateOut)),
                  Text("Date Back : "+ DateFormat('yyyy-MM-dd')
                      .format(Loans.fromMap(loanBack).dateBack)),
                  const Divider()
                ],
              ),
            );
          }).toList()),
    );
  }
}
