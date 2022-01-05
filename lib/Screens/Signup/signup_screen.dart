import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/admin/db_admin_operation.dart';
import 'package:gstock/Models/admin.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/components/already_have_an_account_acheck.dart';
import 'package:gstock/components/image_picker.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/components/rounded_password_field.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/routes/route.dart' as route;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _imageFileBase64;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    signUp() async {
      String username = usernameController.text;
      String email = emailController.text;
      String password = passwordController.text;
      if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
        Admin admin = Admin(username, email, password,_imageFileBase64!);
        await DbAdmin.instance.saveAdminData(admin).then((adminData) {
          Navigator.pushNamedAndRemoveUntil(
              context, route.loginScreen, (Route<dynamic> route) => false);
        }).catchError((error) {
          alertDialog(context, 'Utilisateur existe déjà.', 1);
        });
      }else{
        alertDialog(context, 'Check your data', 1);
      }
    }
    return Scaffold(
      appBar: buildAppBar(context, "SignUP"),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ImagePickerWidget(callback: (String imageFileBase64) {setState(() {
                  _imageFileBase64 = imageFileBase64;
                });},),
                SizedBox(height: size.height * 0.02),
                RoundedInputField(
                  controller: usernameController,
                  hintText: "Your Username",
                  inputType: TextInputType.name,
                  // onChanged: (value) {},
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: emailController,
                  hintText: "Your Email",
                  inputType: TextInputType.emailAddress,
                  icon: Icons.email,
                  // onChanged: (value) {},
                ),
                SizedBox(height: size.height * 0.03),
                RoundedPasswordField(
                  controller: passwordController,
                ),
                RoundedButton(
                  text: "SIGNUP",
                  press: signUp,
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    // Get.back();
                    Navigator.pop(context);
                  },
                ),
                SizedBox(height: size.height * 0.03),
                // OrDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
