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
import 'package:intl/intl.dart';

class ProductEditScreen extends StatefulWidget {
  final Product product;
  final Category category;
  const ProductEditScreen(
      {Key? key, required this.product, required this.category})
      : super(key: key);

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  late Category _selectedCategory;
  final titleController = TextEditingController();
  final quantityController = TextEditingController();
  final _purchaseDateController = TextEditingController();
  DateTime _purchaseDate = DateTime.now();
  late String _imageFileBase64;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    callback(widget.category);
    titleController.text = widget.product.productTitle;
    quantityController.text = widget.product.quantity.toString();
    _purchaseDateController.text = DateFormat('yyyy-MM-dd').format(widget.product.purchaseDate);
    _purchaseDate = widget.product.purchaseDate;
    _imageFileBase64 = widget.product.productImage;
  }

  callback(selectedCategory) {
    setState(() {
      _selectedCategory = selectedCategory;
    });
  }

  updateProducts() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Product product = Product(
          titleController.text,
          _selectedCategory.categoryId,
          int.parse(quantityController.text),
          _purchaseDate,
          _imageFileBase64,
      );
      product.productId = widget.product.productId;
      await DbProduct.instance.updateProduct(product).then((productData) {
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
      appBar: buildAppBar(context, "Edit Product"),
      body: SingleChildScrollView(
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                ImagePickerWidget(
                  isUserImage: false,
                  isEdit: true,
                  imageFileBase64: _imageFileBase64,
                  callback: (String imageFileBase64) {
                    setState(() {
                      _imageFileBase64 = imageFileBase64;
                    });
                  },
                ),
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
                FutureBuilder<List<Category>>(
                  future: DbCategory.instance.getCategories(),
                  builder: (context, snapshot) {
                    return snapshot.hasData
                        ? CategoriesDropDown(callback: callback, categories: snapshot.data)
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
                  text: "Update",
                  press: updateProducts,
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
