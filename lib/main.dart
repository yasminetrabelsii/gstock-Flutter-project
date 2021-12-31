import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gstock/constants.dart';
import 'package:gstock/routes/route.dart' as route;

void main() async {
  await GetStorage.init(storeAdmin);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gstock(AJST)',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: kPrimaryLightColor,
      ),
      onGenerateRoute: route.controller,
      initialRoute: route.welcomeScreen,
    );
  }
}
