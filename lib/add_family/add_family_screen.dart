import 'package:flutter/material.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/localization/language_constants.dart';

import 'components/body.dart';

class ForgotPasswordScreen extends StatelessWidget {
  static String routeName = "/forgot_password";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        title: Text(getTranslated(context, 'Change_Password'),),
      ),
      body: Body(),
    );
  }
}
