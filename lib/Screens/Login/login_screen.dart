import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gstock/DatabaseHandler/admin/db_admin_operation.dart';
import 'package:gstock/Models/admin.dart';
import 'package:gstock/components/already_have_an_account_acheck.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/components/rounded_password_field.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/constants.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/routes/route.dart' as route;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GetStorage loginStorage = GetStorage(storeAdmin);
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future setSP(Admin admin) async {
    loginStorage.write(adminData, admin.toMap());
  }

  login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      await DbAdmin.instance
          .getLoginData(usernameController.text, passwordController.text)
          .then((adminData) {
        if (adminData != null) {
          setSP(adminData).whenComplete(() {
            Navigator.pushNamedAndRemoveUntil(
                context, route.homeScreen, (Route<dynamic> route) => false);
          });
        } else {
          alertDialog(context, 'User Not Found', 1);
        }
      }).catchError((error) {
        alertDialog(context, 'Login Fail', 1);
      });
    } else {
      alertDialog(context, 'Check your data', 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "login"),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/images/login.png",
                  height: size.height * 0.2,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: usernameController,
                  hintText: "E-mail Or Username",
                  inputType: TextInputType.name,
                ),
                RoundedPasswordField(
                  controller: passwordController,
                ),
                RoundedButton(text: "LOGIN", press: login),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.pushNamed(context, route.signupScreen);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
