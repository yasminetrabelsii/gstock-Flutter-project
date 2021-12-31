import 'package:flutter/material.dart';
import 'package:gstock/components/text_field_container.dart';
import 'package:gstock/constants.dart';

class RoundedPasswordField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController controller;
  const RoundedPasswordField({
    Key ?key,
    required this.onChanged,
    required this.controller,
  }) : super(key: key);

  @override
  State<RoundedPasswordField> createState() => _RoundedPasswordFieldState();
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {
  bool _isObscure  = true;
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        obscureText: _isObscure,
        onChanged: widget.onChanged,
        controller: widget.controller,
        cursorColor: kPrimaryColor,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Your Password.';
          }
          if(value.length<8){
            return 'Passwords must be at least 8 characters long.';
          }
          return null;
        },
        style: const TextStyle(color:kPrimaryColor ),
        decoration:  InputDecoration(
          icon: const Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _isObscure ? Icons.visibility : Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onPressed: (){
              setState(() {
                _isObscure=!_isObscure;
              });
            },
          ),
          hintText: "Password",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
