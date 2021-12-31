import 'package:flutter/material.dart';
import 'package:gstock/Models/category.dart';
import 'package:gstock/components/text_field_container.dart';

import 'package:gstock/constants.dart';

class CategoriesDropDown extends StatefulWidget {
  final List<Category>? categories;
  final Function(Category) callback;

  const CategoriesDropDown({Key? key,required this.categories,
    required this.callback,}) : super(key: key);

  @override
  State<CategoriesDropDown> createState() => _CategoriesDropDownState();
}

class _CategoriesDropDownState extends State<CategoriesDropDown> {
  String _selectCategory = 'Select category';
  final _selectCategoryController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: DropdownButton<Category>(
          hint: TextFormField(
            cursorColor: kPrimaryColor,
            controller: _selectCategoryController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please choose a category';
              }
              return null;
            },
            style: const TextStyle(color: kPrimaryColor),
            decoration: InputDecoration(
              icon: const Icon(
                Icons.category,
                color: kPrimaryColor,
              ),
              hintText: _selectCategory,
              border: InputBorder.none,
            ),
          ),
          style: const TextStyle(color: kPrimaryColor),
          isExpanded: true,
          onChanged: (Category? value){
            setState(() {
              _selectCategory=value!.categoryTitle;
              _selectCategoryController.text=value.categoryTitle;
              widget.callback(value);
            });
          },
          items: widget.categories!.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.categoryTitle),
            );
          }).toList()
      ),
    );
  }
}

