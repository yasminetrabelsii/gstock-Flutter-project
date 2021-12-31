import 'package:flutter/material.dart';
import 'package:gstock/Screens/Category/list_categories_screen.dart';
import 'package:gstock/Screens/Home/home_screen.dart';
import 'package:gstock/Screens/LoanBack/add/add_loanback_screen.dart';
import 'package:gstock/Screens/LoanBack/list_loanback.dart';
import 'package:gstock/Screens/Loans/add/add_loans_screen.dart';
import 'package:gstock/Screens/Loans/list_loans_screen.dart';
import 'package:gstock/Screens/Login/login_screen.dart';
import 'package:gstock/Screens/Profil/Edit/edit_screen.dart';
import 'package:gstock/Screens/Profil/Show/profil_screen.dart';
import 'package:gstock/Screens/Signup/signup_screen.dart';
import 'package:gstock/Screens/Welcome/welcome_screen.dart';
import 'package:gstock/Screens/Category/add/add_category_screen.dart';
import 'package:gstock/Screens/members/add/add_member_screen.dart';
import 'package:gstock/Screens/members/edit/edit_member_screen.dart';
import 'package:gstock/Screens/members/list_members_screen.dart';
import 'package:gstock/Screens/product/add/add_product_screen.dart';
import 'package:gstock/Screens/product/list_products_screen.dart';


//route name
const String welcomeScreen = "welcome";
const String loginScreen = "login";
const String signupScreen = "signup";
const String homeScreen = "home";
const String profilScreen = "profil";
const String editProfilScreen = "editProfil";
const String categoryAddScreen = "CategoryAdd";
const String categoryListScreen = "CategoryList";
const String productAddScreen = "ProductAdd";
const String membersListScreen = "MembersList";
const String memberAddScreen = "MemberAdd";
const String memberEditScreen = "MemberEdit";
const String productListScreen = "ProductList";
const String loanAddScreen = "LoanAdd";
const String loanListScreen = "LoanList";
const String loanBackAddScreen = "LoanBackAdd";
const String loansBackListScreen = "LoansBackList";

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case welcomeScreen:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
    case loginScreen:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case signupScreen:
      return MaterialPageRoute(builder: (context) => const SignUpScreen());
    case homeScreen:
      return MaterialPageRoute(builder: (context) => const HomeScreen());
    case profilScreen:
      return MaterialPageRoute(builder: (context) => const ProfilScreen());
    case editProfilScreen:
      return MaterialPageRoute(builder: (context) => const EditProfilScreen());
    case categoryAddScreen:
      return MaterialPageRoute(builder: (context) => const CategoryAddScreen());
    case categoryListScreen:
      return MaterialPageRoute(builder: (context) => const CategoryListScreen());
    case productAddScreen:
      return MaterialPageRoute(builder: (context) => const ProductAddScreen());
    case membersListScreen:
      return MaterialPageRoute(builder: (context) => const MembersListScreen());
    case memberAddScreen:
      return MaterialPageRoute(builder: (context) => const MemberAddScreen());
    case productListScreen:
      return MaterialPageRoute(builder: (context) => const ProductListScreen());
    case loanAddScreen:
      return MaterialPageRoute(builder: (context) => const LoanAddScreen());
    case memberEditScreen:
      return MaterialPageRoute(builder: (context) => const MemberEditScreen());
    case loanListScreen:
      return MaterialPageRoute(builder: (context) => const LoanListScreen());
    case loanBackAddScreen:
      return MaterialPageRoute(builder: (context) => const LoanBackAddScreen());
    case loansBackListScreen:
      return MaterialPageRoute(builder: (context) => const LoansBackListScreen());
    default:
      return MaterialPageRoute(builder: (context) => const WelcomeScreen());
  }
}
