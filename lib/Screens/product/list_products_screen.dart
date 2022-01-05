import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/product/db_product_opertation.dart';
import 'package:gstock/Models/category.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/constants.dart';
import 'package:intl/intl.dart';

import 'details/product_detail_screen.dart';
import 'edit/edit_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "List Products"),
      body: Center(
        child: FutureBuilder<List<Map<String, Object?>>>(
            future: DbProduct.instance.getProductsCategories(),
            builder: (BuildContext context, AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                    child: CircularProgressIndicator(
                  color: kPrimaryColor,
                ));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Products in List.'))
                  : ListView(
                      children: snapshot.data!.map((product) {
                        return Center(
                          child: ListTile(
                            onLongPress: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductEditScreen(
                                          category: Category.fromMap(product),
                                          product: Product.fromMap(product),
                                        )),
                              );
                            },
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                      category: Category.fromMap(product),
                                      product: Product.fromMap(product),
                                    )),
                              );
                            },
                            title: Text(Product.fromMap(product).productTitle,textAlign: TextAlign.center,),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * 0.01),
                                Text(
                                    'Quantity : ${Product.fromMap(product).quantity}'),
                                Text(
                                    'Category : ${Category.fromMap(product).categoryTitle}'),
                                Text('Date purchase : ' +
                                    DateFormat('yyyy-MM-dd').format(
                                        Product.fromMap(product).purchaseDate)),
                              ],
                            ),
                            leading: Image.memory(base64Decode(
                                Product.fromMap(product).productImage)),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  DbProduct.instance.deleteProduct(
                                      Product.fromMap(product).productId);
                                });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
            }),
      ),
    );
  }
}
