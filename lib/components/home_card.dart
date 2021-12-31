import 'package:flutter/material.dart';
import 'package:gstock/constants.dart';

class CardHome extends StatelessWidget {
  String image;
  String text;
  String namedRoute;
  CardHome(
      {Key? key,
      required this.image,
      required this.text,
      required this.namedRoute})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 177,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: kPrimaryColor
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset(
                'assets/images/$image',
                width: 120,
                height: 120,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: const TextStyle(
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.pushNamed(context, namedRoute);
      },
    );
  }
}
