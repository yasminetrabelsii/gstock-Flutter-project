import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gstock/components/background.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/constants.dart';
import 'package:gstock/routes/route.dart' as route;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  GetStorage loginStorage = GetStorage(storeAdmin);

  @override
  void initState() {
      checkLogin();
    super.initState();
  }
  checkLogin() async {
    if (await loginStorage.read(adminData) != null) {
      Navigator.pushNamedAndRemoveUntil(context,route.homeScreen, (Route<dynamic>route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provide us total height and width of our screen
    return Background(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: size.height * 0.05),
              const Text(
                "Welcome TO Gstock",
                style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 3.0,color: kPrimaryColor),
              ),
              Image.asset(
                "assets/images/ajst.png",
                height: size.height * 0.45,
              ),
              const Text(
                "Association Jeunes Science de Tunisie",
                style: TextStyle(fontWeight: FontWeight.bold,letterSpacing: 2.0,color: kPrimaryColor),
              ),
              SizedBox(height: size.height * 0.05),
              RoundedButton(
                text: "LOGIN",
                press: () {
                  Navigator.pushNamed(context,route.loginScreen);
                },
              ),
              RoundedButton(
                text: "SIGN UP",
                color: kPrimaryLightColor,
                textColor: kPrimaryColor,
                press: () {
                  Navigator.pushNamed(context,route.signupScreen);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
