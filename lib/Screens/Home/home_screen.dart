import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gstock/DatabaseHandler/product/db_product_opertation.dart';
import 'package:gstock/Models/admin.dart';
import 'package:gstock/components/custom_expansion_tile.dart';
import 'package:gstock/components/custom_search_delegate.dart';
import 'package:gstock/components/home_card.dart';
import 'package:gstock/constants.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/routes/route.dart' as route;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GetStorage loginStorage = GetStorage(storeAdmin);
  late Admin admin = Admin.fromMap(loginStorage.read(adminData));
  int selectedIndex = 0;
  List<Map<String, Object?>> products = [];

  getProduct () async {
    await DbProduct.instance.getProductsCategories().then((data) => {
    setState(() {
      products = data;
    })
    });
  }
  @override
  void initState(){
    getProduct();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(
          context,
          "Home Page",
          action: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: CustomSearchDelegate(products: products));
            },
          ),
        ),
        drawer: Drawer(
          child: Center(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: CircleAvatar(
                      radius: 80,
                      backgroundImage:
                          MemoryImage(base64Decode(admin.adminImage)),
                      backgroundColor: Colors.transparent),
                  accountName: Text(
                    admin.userName,
                    style: const TextStyle(
                      color: kPrimaryLightColor,
                      fontWeight: FontWeight.w400,
                      fontSize: 18.0,
                      letterSpacing: 2.0,
                    ),
                  ),
                  accountEmail: Text(
                    admin.email,
                    style: const TextStyle(
                      color: kPrimaryLightColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 1.0,
                    ),
                  ),
                  onDetailsPressed: () {
                    Navigator.pushNamed(context, route.profilScreen);
                  },
                ),
                ExpansionTile(
                  collapsedTextColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  iconColor: kPrimaryColor,
                  title: const Text("Members"),
                  children: <Widget>[
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.membersListScreen);
                      },
                      hintText: 'List Members',
                      icon: Icons.format_list_bulleted,
                    ),
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.memberAddScreen);
                      },
                      hintText: 'Add new Member',
                      icon: Icons.add,
                    ),
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.memberEditScreen);
                      },
                      hintText: 'Edit Member',
                      icon: Icons.edit,
                    ),
                  ],
                ),
                ExpansionTile(
                  collapsedTextColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  iconColor: kPrimaryColor,
                  title: const Text("Product"),
                  children: <Widget>[
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.productListScreen);
                      },
                      hintText: 'List Product',
                      icon: Icons.format_list_bulleted,
                    ),
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.productAddScreen);
                      },
                      hintText: 'Add new Product',
                      icon: Icons.add,
                    ),
                  ],
                ),
                ExpansionTile(
                  collapsedTextColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  iconColor: kPrimaryColor,
                  title: const Text("Categories"),
                  children: <Widget>[
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.categoryListScreen);
                      },
                      hintText: 'List Categories',
                      icon: Icons.format_list_bulleted,
                    ),
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.categoryAddScreen);
                      },
                      hintText: 'Add new Category',
                      icon: Icons.add,
                    ),
                  ],
                ),
                ExpansionTile(
                  collapsedTextColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  iconColor: kPrimaryColor,
                  title: const Text("Loans"),
                  children: <Widget>[
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.loanListScreen);
                      },
                      hintText: 'List Loans',
                      icon: Icons.format_list_bulleted,
                    ),
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.loanAddScreen);
                      },
                      hintText: 'Add new Loan',
                      icon: Icons.add,
                    ),
                  ],
                ),
                ExpansionTile(
                  collapsedTextColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  iconColor: kPrimaryColor,
                  title: const Text("Loan Back"),
                  children: <Widget>[
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.loansBackListScreen);
                      },
                      hintText: 'List Loans Back',
                      icon: Icons.format_list_bulleted,
                    ),
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.loanBackAddScreen);
                      },
                      hintText: 'Loan Back',
                      icon: Icons.add,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          // backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.shifting,
          elevation: 0,
          currentIndex: selectedIndex,
          selectedItemColor: kPrimaryColor,
          showUnselectedLabels: false,
          selectedLabelStyle:
              const TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              switch (index) {
                case 1:
                  Navigator.pushNamed(context, route.profilScreen)
                      .then((value) => {
                            setState(() {
                              selectedIndex = 0;
                            })
                          });
                  break;
              }
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: kPrimaryColor,
                ),
                label: "Home",
                backgroundColor: Colors.transparent),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person,
                  color: kPrimaryColor,
                ),
                label: "Profil",
                backgroundColor: Colors.transparent),
          ],
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardHome(
                      text: 'Stock',
                      image: 'packages.png',
                      namedRoute: route.productListScreen,
                    ),
                    CardHome(
                      text: 'Members',
                      image: 'teamwork.png',
                      namedRoute: route.membersListScreen,
                    ),
                  ],
                ),
                SizedBox(height: size.height * 0.03),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CardHome(
                      text: 'Loans',
                      image: 'loan.png',
                      namedRoute: route.loanListScreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
