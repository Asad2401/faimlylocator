import 'package:flutter/material.dart';
import 'package:pak_lpg/commons/text_field_container.dart';
import 'package:pak_lpg/commons/constants.dart';

class RoundedInputField extends StatelessWidget {

  final bool readonly;
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.readonly,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        readOnly: readonly,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 16.0),
          prefixIcon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          hintText: hintText,
          border: InputBorder.none
        ),
      )
    );
  }
}
