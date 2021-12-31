import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/members/db_members_opertation.dart';
import 'package:gstock/Models/members.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/routes/route.dart' as route;
import 'package:gstock/components/appbar_widget.dart';

class MemberEditScreen extends StatefulWidget {
  const MemberEditScreen({Key? key}) : super(key: key);

  @override
  _MemberEditScreenState createState() => _MemberEditScreenState();
}

class _MemberEditScreenState extends State<MemberEditScreen> {
  final cinFindController = TextEditingController();
  final cinController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final adresseController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  late Members members;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    updateMember() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
            members.cin=cinController.text;
            members.firstName=firstNameController.text;
            members.lastName=lastNameController.text;
            members.email=emailController.text;
            members.phone=phoneController.text;
            members.adresse= adresseController.text;
        await DbMembers.instance.updateMember(members).then((memberData) {
          Navigator.pushNamedAndRemoveUntil(
              context, route.homeScreen, (Route<dynamic> route) => false);
        }).catchError((error) {
          alertDialog(context, 'Error: Data Save Fail', 1);
        });
      }
    }
    getMember() async {
      if (_formKey2.currentState!.validate()) {
        _formKey2.currentState!.save();
        await DbMembers.instance.getMemberByCin(cinFindController.text).then((memberData) {
            setState(() {
              members = memberData!;
              cinController.text = memberData.cin;
              firstNameController.text =memberData.firstName;
              lastNameController.text = memberData.lastName;
              emailController.text = memberData.email;
              phoneController.text = memberData.phone;
              adresseController.text = memberData.adresse;
            });
        }).catchError((error) {
          alertDialog(context, 'Error: User not found', 1);
        });
      }
    }
    return Scaffold(
      appBar: buildAppBar(context, "Edit Member"),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Form(
                key: _formKey2,
                child: Column(
                  children: [
                    SizedBox(height: size.height * 0.03),
                    const Text(
                      'Find Member',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          letterSpacing: 3.0),
                    ),
                    RoundedInputField(
                      controller: cinFindController,
                      hintText: "Cin",
                      icon: Icons.credit_card,
                      inputType: TextInputType.phone,
                    ),
                    RoundedButton(
                      text: "Search",
                      press: getMember,
                    ),
                  ],
                )),
            Center(
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
                      text: "Update",
                      press: updateMember,
                    ),
                    SizedBox(height: size.height * 0.1),
                    // OrDivider(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
