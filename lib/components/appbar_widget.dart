import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gstock/constants.dart';

AppBar buildAppBar(BuildContext context, String title ,
    {Widget action = const SizedBox(height: 0)}) {
  return AppBar(
    title: Text(title,
        style:
            const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 3.0)),
    actions: [
      action
    ],
    centerTitle: true,
    backgroundColor: Colors.transparent,
    foregroundColor: kPrimaryColor,
    elevation: 0,
  );
}
