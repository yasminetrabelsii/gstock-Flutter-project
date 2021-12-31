import 'package:flutter/material.dart';
import 'package:gstock/components/text_field_container.dart';
import 'package:gstock/constants.dart';
import 'package:intl/intl.dart';

class RoundedDateField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final Function(DateTime dateTime) callback;
  const RoundedDateField({
    Key? key,
    required this.hintText,
    required this.controller,
    required this.callback,
  }) : super(key: key);

  @override
  State<RoundedDateField> createState() => _RoundedInputFieldState();
}

class _RoundedInputFieldState extends State<RoundedDateField> {
  DateTime _dateTime = DateTime.now();
  _selectedTodoDate(BuildContext context) async {
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(DateTime.now().year - 5),
        lastDate: DateTime.now().add(const Duration(days: 365)));
    if (_pickedDate != null) {
      setState(() {
        _dateTime = _pickedDate;
        widget.controller.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
    widget.callback(_dateTime);
  }

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        cursorColor: kPrimaryColor,
        controller: widget.controller,
        readOnly: true,
        onTap: () {
          _selectedTodoDate(context);
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${widget.hintText}.';
          }
          return null;
        },
        style: const TextStyle(color: kPrimaryColor),
        decoration: InputDecoration(
          icon: const Icon(
            Icons.calendar_today,
            color: kPrimaryColor,
          ),
          hintText: widget.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
