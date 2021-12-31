import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/category/db_category_operation.dart';
import 'package:gstock/Models/category.dart';
import 'package:gstock/components/alert_dialog.dart';
import 'package:gstock/components/rounded_button.dart';
import 'package:gstock/components/rounded_input_field.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/routes/route.dart' as route;

class CategoryAddScreen extends StatefulWidget {
  const CategoryAddScreen({Key? key}) : super(key: key);

  @override
  State<CategoryAddScreen> createState() => _CategoryAddScreenState();
}

class _CategoryAddScreenState extends State<CategoryAddScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    addCategory() async {
      if (titleController.text.isEmpty) {
        alertDialog(context, 'Please Enter Username Or Email', 1);
      } else if (descriptionController.text.isEmpty) {
        alertDialog(context, 'Please Enter Password', 1);
      } else {
        Category category = Category(titleController.text, descriptionController.text);
        await DbCategory.instance.saveCategory(category).then((userData) {
          Navigator.pushNamedAndRemoveUntil(
              context, route.homeScreen, (Route<dynamic> route) => false);
        }).catchError((error) {
          alertDialog(context, 'Error: Data Save Fail', 1);
        });
      }
    }
    return Scaffold(
      appBar: buildAppBar(context, "Add New Category"),
      body:SingleChildScrollView(
        child: Center(
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
                controller: descriptionController,
                hintText: "Some description",
                icon: Icons.description,
                // onChanged: (value) {},
              ),
              SizedBox(height: size.height * 0.03),
              RoundedButton(
                text: "Save",
                press: addCategory,
              ),
              SizedBox(height: size.height * 0.1),
              // OrDivider(),
            ],
          ),
        ),
      ),
    );
  }
}
