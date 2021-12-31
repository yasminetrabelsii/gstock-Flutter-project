import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gstock/DatabaseHandler/members/db_members_opertation.dart';
import 'package:gstock/Models/members.dart';
import 'package:gstock/components/appbar_widget.dart';
import 'package:gstock/constants.dart';

class MembersListScreen extends StatefulWidget {
  const MembersListScreen({Key? key}) : super(key: key);

  @override
  _MembersListScreenState createState() => _MembersListScreenState();
}

class _MembersListScreenState extends State<MembersListScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: buildAppBar(context, "List Members"),
      body: Center(
        child: FutureBuilder<List<Members>>(
            future: DbMembers.instance.getMembers(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Members>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading...'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Members in List.'))
                  : ListView(
                      children: snapshot.data!.map((member) {
                        return Center(
                          child: ListTile(
                            title: Text(
                                "First Name :${member.firstName},Last Name:${member.lastName}"),
                            subtitle: Text(member.adresse),
                            leading: const Icon(Icons.person),
                            trailing: IconButton(
                              icon: const Icon(
                                Icons.delete_forever,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                setState(() {
                                  DbMembers.instance
                                      .deleteMember(member.memberId);
                                });
                              },
                            ),
                            onTap: () => showModalBottomSheet(
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(20)
                                )),
                                builder: (context) {
                                  return Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Center(
                                          child: Column(
                                            children: [
                                              const CircleAvatar(
                                                  radius: 60,
                                                  backgroundImage: AssetImage(
                                                      'assets/images/user.png'),
                                                  backgroundColor:
                                                      Colors.transparent),
                                              SizedBox(
                                                  height: size.height * 0.03),
                                              const Text(
                                                'Member Details',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 3.0),
                                              ),
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
                                              member.lastName,
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
                                              member.firstName,
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
                                              member.cin,
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
                                              Icons.email,
                                              color: kPrimaryColor,
                                            ),
                                            const SizedBox(width: 10.0),
                                            Text(
                                              member.email,
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
                                              Icons.phone,
                                              color: kPrimaryColor,
                                            ),
                                            const SizedBox(width: 10.0),
                                            Text(
                                              member.phone,
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
                                              Icons.location_on ,
                                              color: kPrimaryColor,
                                            ),
                                            const SizedBox(width: 10.0),
                                            Text(
                                              member.adresse,
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
                                  );
                                },
                                context: context),
                          ),
                        );
                      }).toList(),
                    );
            }),
      ),
    );
  }
}
