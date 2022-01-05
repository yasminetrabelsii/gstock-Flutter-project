import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/category/db_category_operation.dart';
import 'package:gstock/Models/category.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/constants.dart';

import 'edit/edit_category_screen.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({Key? key}) : super(key: key);

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "List Categories"),
      body: Center(
        child: FutureBuilder<List<Category>>(
            future: DbCategory.instance.getCategories(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Category>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CircularProgressIndicator(color: kPrimaryColor,));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Categories in List.'))
                  : ListView(
                children: snapshot.data!.map((category) {
                  return Center(
                    child: ListTile(
                      onLongPress: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategoryEditScreen(
                                category: category,
                              )),
                        );
                      },
                      title: Text(category.categoryTitle,textAlign: TextAlign.center,),
                      subtitle: Text(category.description),
                      leading: const Icon(Icons.category),
                      trailing: IconButton(icon: const Icon(Icons.delete_forever,color: Colors.red,),
                        onPressed: () {
                        setState(() {
                          DbCategory.instance.deleteCategory(category.categoryId);
                        });
                        },),
                    ),
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
