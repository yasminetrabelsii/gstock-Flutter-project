import 'package:flutter/material.dart';
import 'package:gstock/Models/members.dart';
import 'package:gstock/components/text_field_container.dart';

import 'package:gstock/constants.dart';

class MembersDropDown extends StatefulWidget {
  final List<Members>? members;
  final Function(Members) callback;

  const MembersDropDown({Key? key,required this.members,
    required this.callback,}) : super(key: key);

  @override
  State<MembersDropDown> createState() => _MembersDropDownState();
}

class _MembersDropDownState extends State<MembersDropDown> {
  String _selectMembers = 'Select member';
  final _selectMembersController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: DropdownButton<Members>(
          hint: TextFormField(
            cursorColor: kPrimaryColor,
            controller: _selectMembersController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please choose a member';
              }
              return null;
            },
            style: const TextStyle(color: kPrimaryColor),
            decoration: InputDecoration(
              icon: const Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              hintText: _selectMembers,
              border: InputBorder.none,
            ),
          ),
          style: const TextStyle(color: kPrimaryColor),
          isExpanded: true,
          onChanged: (Members? value){
            setState(() {
              _selectMembers=value!.email;
              _selectMembersController.text=value.email;
              widget.callback(value);
            });
          },
          items: widget.members!.map((member) {
            return DropdownMenuItem(
              value: member,
              child: Text(member.email),
            );
          }).toList()
      ),
    );
  }
}

