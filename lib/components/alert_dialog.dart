import 'package:flutter/material.dart';
import 'package:gstock/constants.dart';

alertDialog(BuildContext context, String msg ,int s,{String label="CLOSE"}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: kPrimaryColor,
    content: Text(msg),
    duration: Duration(seconds: s),
    action: SnackBarAction(
      textColor: Colors.red,
      label: 'CLOSE',
      onPressed: () { },
    ),
  ));
}