import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/product/db_product_opertation.dart';
import 'package:gstock/Models/category.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:intl/intl.dart';

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
            builder:
                (BuildContext context, AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Products in List.'))
                  : ListView(
                      children: snapshot.data!.map((product) {
                        return Center(
                          child: ListTile(
                            title: Text(Product.fromMap(product).productTitle),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: size.height * 0.01),
                                Text('Quantity : ${Product.fromMap(product).quantity}'),
                                Text('Category : ${Category.fromMap(product).categoryTitle}'),
                                Text('Date purchase : '+DateFormat('yyyy-MM-dd')
                                    .format(Product.fromMap(product).purchaseDate)),
                              ],
                            ),
                            leading: const Icon(Icons.laptop),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  DbProduct.instance
                                      .deleteProduct(Product.fromMap(product).productId);
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
