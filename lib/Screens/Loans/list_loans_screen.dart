import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/loans/db_loans_operation.dart';
import 'package:gstock/Models/loans.dart';
import 'package:gstock/Models/members.dart';
import 'package:gstock/Models/product.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:intl/intl.dart';
import 'package:gstock/constants.dart';

class LoanListScreen extends StatefulWidget {
  const LoanListScreen({Key? key}) : super(key: key);

  @override
  State<LoanListScreen> createState() => _LoanListScreenState();
}

class _LoanListScreenState extends State<LoanListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "List Loans"),
      body: Center(
        child: FutureBuilder<List<Map<String, Object?>>>(
            future: DbLoan.instance.getLoansWithAllInfo(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Map<String, Object?>>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Loans in List.'))
                  : ListView(
                      children: snapshot.data!.map((data) {
                        return ListTile(
                          title: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        'Loans ID '+Loans.fromMap(data).loanId.toString(),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            letterSpacing: 3.0),
                                      ),
                                      Loans.fromMap(data).isVerified
                                          ? const Icon(
                                              Icons.check,
                                              color: Colors.green,
                                            )
                                          : const Icon(
                                              Icons.clear,
                                              color: Colors.red,
                                            ),
                                      SizedBox(height: size.height * 0.03),
                                      // const CircleAvatar(
                                      //     radius: 60,
                                      //     backgroundImage: AssetImage(
                                      //         'assets/images/user.png'),
                                      //     backgroundColor: Colors.transparent),
                                      // SizedBox(height: size.height * 0.03),
                                    ],
                                  ),
                                ),
                                const Divider(
                                  color: kPrimaryColor,
                                  height: 25.0,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Last Name :',
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      Members.fromMap(data).lastName,
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.03),
                                Row(
                                  children: [
                                    const Text(
                                      'First Name :',
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      Members.fromMap(data).firstName,
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 18.0,
                                        letterSpacing: 2.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.03),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.credit_card,
                                      color: kPrimaryColor,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      Members.fromMap(data).cin,
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.03),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.laptop,
                                      color: kPrimaryColor,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      Product.fromMap(data).productTitle,
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.03),
                                Row(
                                  children: <Widget>[
                                    const Text(
                                      "Nombre Of pieces : ",
                                      style: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      Loans.fromMap(data).loanQuantity.toString(),
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.03),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.calendar_today,
                                      color: kPrimaryColor,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      'Date out : ' +
                                          DateFormat('yyyy-MM-dd').format(
                                              Loans.fromMap(data).dateOut),
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: size.height * 0.03),
                                Row(
                                  children: <Widget>[
                                    const Icon(
                                      Icons.calendar_today,
                                      color: kPrimaryColor,
                                    ),
                                    const SizedBox(width: 10.0),
                                    Text(
                                      'Date Back : ' +
                                          DateFormat('yyyy-MM-dd').format(
                                              Loans.fromMap(data).dateBack),
                                      style: const TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w400,
                                        letterSpacing: 1.0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          // trailing: IconButton(
                          //   icon: const Icon(
                          //     Icons.delete_forever,
                          //     color: Colors.red,
                          //   ),
                          //   onPressed: () {
                          //     setState(() {
                          //       DbProduct.instance.deleteProduct(
                          //           Product.fromMap(product).productId);
                          //     });
                          //   },
                          // ),
                        );
                      }).toList(),
                    );
            }),
      ),
    );
  }
}
