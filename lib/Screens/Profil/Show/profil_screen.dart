import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gstock/Models/admin.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/constants.dart';
import 'package:gstock/routes/route.dart' as route;
import 'package:gstock/components/appbar_widget.dart';

class ProfilScreen extends StatefulWidget {
  const ProfilScreen({Key? key}) : super(key: key);

  @override
  State<ProfilScreen> createState() => _ProfilScreenState();
}

class _ProfilScreenState extends State<ProfilScreen> {
  GetStorage loginStorage = GetStorage(storeAdmin);
  late Admin admin;

  @override
  void initState() {
    admin = Admin.fromMap(loginStorage.read(adminData));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(
        context,
        "My Profil",
        action: IconButton(
          icon: const Icon(Icons.edit),
          onPressed: () {
            Navigator.pushNamed(context, route.editProfilScreen);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30.0, 40.0, 30.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  children: const [
                    CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('assets/images/user.png'),
                        backgroundColor: Colors.transparent),
                  ],
                ),
              ),
              const Divider(
                color: kPrimaryColor,
                height: 50.0,
              ),
              const Text(
                'USERNAME :',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                admin.userName,
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              const Text(
                'Email :',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2.0,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                children: <Widget>[
                  const Icon(
                    Icons.email,
                    color: kPrimaryColor,
                  ),
                  const SizedBox(width: 10.0),
                  Text(
                    admin.email,
                    style: const TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.03),
              Center(
                child: RoundedButton(
                    text: "LogOut",
                    press: () {
                      loginStorage.erase();
                      Navigator.pushNamedAndRemoveUntil(context,
                          route.welcomeScreen, (Route<dynamic> route) => false);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
