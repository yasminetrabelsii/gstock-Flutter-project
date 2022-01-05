import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/members/db_members_opertation.dart';
import 'package:gstock/Models/members.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/routes/route.dart' as route;
import 'package:gstock/components/appbar_widget.dart';

class MemberEditScreen extends StatefulWidget {
  late Members? member;
  MemberEditScreen({Key? key, this.member}) : super(key: key);
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
  late Members members;
  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.member != null) {
        cinController.text = widget.member!.cin;
        firstNameController.text = widget.member!.firstName;
        lastNameController.text = widget.member!.lastName;
        emailController.text = widget.member!.email;
        phoneController.text = widget.member!.phone;
        adresseController.text = widget.member!.adresse;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    updateMember() async {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        members.cin = cinController.text;
        members.firstName = firstNameController.text;
        members.lastName = lastNameController.text;
        members.email = emailController.text;
        members.phone = phoneController.text;
        members.adresse = adresseController.text;
        await DbMembers.instance.updateMember(members).then((memberData) {
          Navigator.pushNamedAndRemoveUntil(
              context, route.homeScreen, (Route<dynamic> route) => false);
        }).catchError((error) {
          alertDialog(context, 'Error: Data Save Fail', 1);
        });
      }
    }

    return Scaffold(
      appBar: buildAppBar(
        context,
        "Edit Member",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                      icon: Icons.location_on,
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
