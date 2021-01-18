import 'package:flutter/material.dart';
import 'package:pak_lpg/commons/text_field_container.dart';
import 'package:pak_lpg/commons/constants.dart';


class RoundedPasswordField extends StatefulWidget {

  final String hintText;
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key key,
    this.onChanged,
    this.hintText
  }) : super(key: key);

  @override
  _RoundedPasswordFieldState createState() => _RoundedPasswordFieldState(key: key, onChanged:  this.onChanged, hintText: this.hintText);
}

class _RoundedPasswordFieldState extends State<RoundedPasswordField> {

  // Initially password is obscure
  final String hintText;
  bool _passwordVisible;
  final ValueChanged<String> onChanged;

  _RoundedPasswordFieldState({   Key key,
    this.onChanged, this.hintText});
  @override
  void initState() {
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {

    return TextFieldContainer(
      child: TextFormField(
        keyboardType: TextInputType.text,
        //controller: _userPasswordController,
        obscureText: !_passwordVisible,
        onChanged: onChanged,
        cursorColor: kPrimaryColor,//This will obscure text dynamically
        style: TextStyle(fontSize: 14),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 15.0, 16.0),
          prefixIcon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          // Here is key idea
          suffixIcon: IconButton(
            icon: Icon(
              // Based on passwordVisible state choose the icon
              _passwordVisible
                  ? Icons.visibility
                  : Icons.visibility_off,
              color: kPrimaryColor,
            ),
            onPressed: () {
              // Update the state i.e. toogle the state of passwordVisible variable
              setState(() {
                _passwordVisible = !_passwordVisible;
              });
            },
          ),
        ),
      ),
    );
  }
}


