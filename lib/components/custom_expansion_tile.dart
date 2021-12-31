import 'package:flutter/material.dart';
import 'package:gstock/components/text_field_container.dart';
import 'package:gstock/constants.dart';

class RoundedExpansionField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function() onTap;
  const RoundedExpansionField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        readOnly: true,
        onTap: onTap,
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
}
