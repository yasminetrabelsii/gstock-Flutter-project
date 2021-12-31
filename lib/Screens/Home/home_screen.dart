import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:gstock/Models/admin.dart';
import 'package:gstock/components/custom_expansion_tile.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: buildAppBar(context, "Home Page"),
        drawer: Drawer(
          child: Center(
            child: ListView(
              children: [
                UserAccountsDrawerHeader(
                  currentAccountPicture: const CircleAvatar(
                      radius: 80,
                      backgroundImage: AssetImage('assets/images/user.png'),
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
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.productAddScreen);
                      },
                      hintText: 'Edit Product',
                      icon: Icons.edit,
                    ),
                  ],
                ),
                ExpansionTile(
                  collapsedTextColor: kPrimaryColor,
                  textColor: kPrimaryColor,
                  iconColor: kPrimaryColor,
                  title: const Text("Catagories"),
                  children: <Widget>[
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.categoryListScreen);
                      },
                      hintText: 'List Catagories',
                      icon: Icons.format_list_bulleted,
                    ),
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.categoryAddScreen);
                      },
                      hintText: 'Add new Category',
                      icon: Icons.add,
                    ),
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.productAddScreen);
                      },
                      hintText: 'Edit Category',
                      icon: Icons.edit,
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
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.productAddScreen);
                      },
                      hintText: 'Edit Loan',
                      icon: Icons.edit,
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
                      hintText: 'Add new Loan Back',
                      icon: Icons.add,
                    ),
                    RoundedExpansionField(
                      onTap: () {
                        Navigator.pushNamed(context, route.productAddScreen);
                      },
                      hintText: 'Edit Loan Back',
                      icon: Icons.edit,
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
