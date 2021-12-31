import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/category/db_category_operation.dart';
import 'package:gstock/DatabaseHandler/product/db_product_opertation.dart';
import 'package:gstock/Models/category.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/components/categories_dropdown.dart';
import 'package:gstock/components/image_picker.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_date_filed.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/routes/route.dart' as route;

class ProductAddScreen extends StatefulWidget {
  const ProductAddScreen({Key? key}) : super(key: key);

  @override
  State<ProductAddScreen> createState() => _ProductAddScreenState();
}

class _ProductAddScreenState extends State<ProductAddScreen> {
  late Category _selectedCategory;
  final titleController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final _purchaseDateController = TextEditingController();
  DateTime _purchaseDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  callback(selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  addProduct() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Product product = Product(
          titleController.text,
          _selectedCategory.categoryId,
          int.parse(quantityController.text),
          _purchaseDate);
      await DbProduct.instance.saveProduct(product).then((productData) {
        Navigator.pushNamedAndRemoveUntil(
            context, route.homeScreen, (Route<dynamic> route) => false);
      }).catchError((error) {
        alertDialog(context, 'Error: Data Save Fail', 1);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "Add New Product"),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: titleController,
                  hintText: "Some title",
                  icon: Icons.title,
                  // onChanged: (value) {},
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: quantityController,
                  hintText: "quantity",
                  icon: Icons.money,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: priceController,
                  hintText: "price",
                  icon: Icons.money,
                  inputType: TextInputType.number,
                ),
                SizedBox(height: size.height * 0.03),
                FutureBuilder<List<Category>>(
                  future: DbCategory.instance.getCategories(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? CategoriesDropDown(
                            callback: callback, categories: snapshot.data)
                        : const Text('No categories');
                  },
                ),
                SizedBox(height: size.height * 0.03),
                RoundedDateField(
                  controller: _purchaseDateController,
                  hintText: 'Date purchase',
                  callback: (DateTime dateTime) {
                    _purchaseDate = dateTime;
                  },
                ),
                SizedBox(height: size.height * 0.03),
                RoundedButton(
                  text: "Save",
                  press: addProduct,
                ),
                SizedBox(height: size.height * 0.1),
                // OrDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
