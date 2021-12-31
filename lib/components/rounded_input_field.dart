import 'package:flutter/material.dart';
import 'package:gstock/components/text_field_container.dart';
import 'package:gstock/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final TextInputType inputType;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    this.icon = Icons.person,
    required this.controller,
    this.inputType=TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        cursorColor: kPrimaryColor,
        controller: controller,
        keyboardType: inputType,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintText.';
          }
          if (inputType == TextInputType.emailAddress && !validateEmail(value)) {
            return 'Please Enter Valid Email.';
          }
          if (inputType == TextInputType.name && !validateUsername(value)) {
            return '$hintText is not Valid.';
          }
          if (inputType == TextInputType.phone && value.length<8) {
            return '$hintText must be at least 8 characters long.';
          }
          return null;
        },
        style: const TextStyle(color: kPrimaryColor),
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }

  validateEmail(String email) {
    final emailReg = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
    return emailReg.hasMatch(email);
  }
  validateUsername(String username) {
    final usernameReg = RegExp(r"^\w[a-zA-Z@#0-9.]*$");
    return usernameReg.hasMatch(username);
  }
}
