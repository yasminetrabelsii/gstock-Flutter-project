import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/members/db_members_opertation.dart';
import 'package:gstock/Models/members.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/routes/route.dart' as route;
import 'package:gstock/components/appbar_widget.dart';

class MemberAddScreen extends StatefulWidget {
  const MemberAddScreen({Key? key}) : super(key: key);

  @override
  _MemberAddScreenState createState() => _MemberAddScreenState();
}

class _MemberAddScreenState extends State<MemberAddScreen> {
  final cinController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final adresseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    addMember() async {

      if(_formKey.currentState!.validate()){
        _formKey.currentState!.save();
        Members members = Members(
            cinController.text,
            firstNameController.text,
            lastNameController.text,
            emailController.text,
            phoneController.text,
            adresseController.text);
        await DbMembers.instance.saveMember(members).then((memberData) {
          Navigator.pushNamedAndRemoveUntil(
              context, route.homeScreen, (Route<dynamic> route) => false);
        }).catchError((error) {
          alertDialog(context, 'Error: Data Save Fail', 1);
        });
      }
    }

    return Scaffold(
      appBar: buildAppBar(context, "Add New Member"),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: cinController,
                  hintText: "Cin",
                  icon: Icons.credit_card,
                  inputType: TextInputType.phone,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: firstNameController,
                  hintText: "FirstName",
                  inputType: TextInputType.name,
                  icon: Icons.person,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: lastNameController,
                  hintText: "LastName",
                  inputType: TextInputType.name,
                  icon: Icons.person,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: emailController,
                  hintText: "email",
                  inputType: TextInputType.emailAddress,
                  icon: Icons.email,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: phoneController,
                  hintText: "phone",
                  inputType: TextInputType.phone,
                  icon: Icons.phone,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: adresseController,
                  hintText: "adresse",
                  icon: Icons.location_on ,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedButton(
                  text: "Save",
                  press: addMember,
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
