import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gstock/Models/category.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/constants.dart';
import 'package:intl/intl.dart';

class ProductDetailScreen extends StatefulWidget {
  final Product product;
  final Category category;
  const ProductDetailScreen(
      {Key? key, required this.product, required this.category})
      : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Product Detail"),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Center(
                    child: Ink.image(
                      image: MemoryImage(
                          base64Decode(widget.product.productImage)),
                      fit: BoxFit.fitWidth,
                      height: 200,
                    ),
                  ),
                  const Divider(
                    color: kPrimaryColor,
                    height: 25.0,
                  ),
                  Row(
                    children: [
                      const Text(
                        'Product Title : ',
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        widget.product.productTitle,
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w400,
                          fontSize: 18.0,
                          letterSpacing: 2.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.03),
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.category,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(width: 10.0),
                      const Text(
                        "Category : ",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        widget.category.categoryTitle,
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
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.add_shopping_cart,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(width: 10.0),
                      const Text(
                        "Quantity : ",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        widget.product.quantity.toString(),
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
                  Row(
                    children: <Widget>[
                      const Icon(
                        Icons.calendar_today,
                        color: kPrimaryColor,
                      ),
                      const SizedBox(width: 10.0),
                      const Text(
                        "Date Purchase : ",
                        style: TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Text(
                        DateFormat('yyyy-MM-dd')
                            .format(widget.product.purchaseDate),
                        style: const TextStyle(
                          color: kPrimaryColor,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
