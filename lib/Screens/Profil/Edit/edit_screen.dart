import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gstock/DatabaseHandler/admin/db_admin_operation.dart';
import 'package:gstock/Models/admin.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/components/image_picker.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/components/rounded_password_field.dart';
import 'package:gstock/constants.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/routes/route.dart' as route;

class EditProfilScreen extends StatefulWidget {
  const EditProfilScreen({Key? key}) : super(key: key);

  @override
  State<EditProfilScreen> createState() => _EditProfilScreenState();
}

class _EditProfilScreenState extends State<EditProfilScreen> {
  GetStorage loginStorage = GetStorage(storeAdmin);
  late Admin admin ;
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpassword = TextEditingController();
  String? _imageFileBase64;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    admin = Admin.fromMap(loginStorage.read(adminData));
    setState(() {
      emailController.text=admin.email;
      usernameController.text=admin.userName;
      passwordController.text=admin.password;
    });
    super.initState();
  }
  update() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      admin.email=emailController.text;
      admin.userName=usernameController.text;
      admin.password=passwordController.text;
      if(_imageFileBase64 !=null) {
        admin.adminImage=_imageFileBase64!;
      }
      await DbAdmin.instance.updateAdmin(admin).then((adminDta) {
        loginStorage.write(adminData, admin.toMap());
        Navigator.pushNamedAndRemoveUntil(
            context, route.homeScreen, (Route<dynamic> route) => false);
      }).catchError((error) {
        alertDialog(context, 'Error: Data Save Fail', 1);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Edit Profile"),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                ImagePickerWidget(imageFileBase64: admin.adminImage,isEdit: true,callback: (String imageFileBase64) {setState(() {
                  _imageFileBase64 = imageFileBase64;
                });},),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: usernameController,
                  hintText: "Your Username",
                  // onChanged: (value) {},
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: emailController,
                  hintText: "Your Email",
                  icon: Icons.email,
                  // onChanged: (value) {},
                ),
                SizedBox(height: size.height * 0.03),
                RoundedPasswordField(
                  controller: passwordController,
                ),
                RoundedButton(
                  text: "UPDATE",
                  press: update,
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
