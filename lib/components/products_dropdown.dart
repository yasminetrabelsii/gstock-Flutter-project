import 'package:flutter/material.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/components/text_field_container.dart';

import 'package:gstock/constants.dart';

class ProductsDropDown extends StatefulWidget {
  final List<Product>? products;
  final Function(Product) callback;

  const ProductsDropDown({Key? key,required this.products,
    required this.callback,}) : super(key: key);

  @override
  State<ProductsDropDown> createState() => _ProductsDropDownState();
}

class _ProductsDropDownState extends State<ProductsDropDown> {
  String _selectProducts = 'Select product';
  final _selectProductsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: DropdownButton<Product>(
          hint: TextFormField(
            cursorColor: kPrimaryColor,
            controller: _selectProductsController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please choose a product';
              }
              return null;
            },
            style: const TextStyle(color: kPrimaryColor),
            decoration: InputDecoration(
              icon: const Icon(
                Icons.laptop,
                color: kPrimaryColor,
              ),
              hintText: _selectProducts,
              border: InputBorder.none,
            ),
          ),
          style: const TextStyle(color: kPrimaryColor),
          isExpanded: true,
          onChanged: (Product? value){
            setState(() {
              _selectProducts=value!.productTitle;
              _selectProductsController.text=value.productTitle;
              widget.callback(value);
            });
          },
          items: widget.products!.map((product) {
            return DropdownMenuItem(
              value: product,
              child: Column(
                children: [
                  const Divider(),
                  Text(product.productTitle),
                  Text("Quantity In Stock : "+product.quantity.toString()),
                  const Divider(),
                ],
              ),
            );
          }).toList()
      ),
    );
  }
}

