import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gstock/Models/category.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/Screens/product/details/product_detail_screen.dart';

class CustomSearchDelegate extends SearchDelegate<List<Map<String, Object?>>> {
  late List<Map<String, Object?>> products;
  CustomSearchDelegate({required this.products});
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }
  @override
  Widget buildLeading(BuildContext context) {
    return const BackButton();
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return const Text("ffffff");
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(itemCount: products.length,itemBuilder:(context,i){
      // return Text(Product.fromMap(products[i]).productTitle);
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ListTile(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductDetailScreen(
                      category: Category.fromMap(products[i]),
                      product: Product.fromMap(products[i]),
                    )),
              );
            },
            title: Text(Product.fromMap(products[i]).productTitle,textAlign: TextAlign.center,),
            leading: Image.memory(base64Decode(
                Product.fromMap(products[i]).productImage)),
          ),
        ),
      );
    });
  }
}