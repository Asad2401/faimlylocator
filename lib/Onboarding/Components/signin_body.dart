import 'package:flutter/material.dart';
import 'package:pak_lpg/commons/utils.dart';
import 'package:pak_lpg/commons/constants.dart';
import 'package:pak_lpg/commons/round_input_field.dart';
import 'package:pak_lpg/commons/round_field_password.dart';
import 'package:pak_lpg/commons/round_button.dart';
import 'package:pak_lpg/commons/already_have_an_account_acheck.dart';
import 'package:pak_lpg/Onboarding/Background.dart';
import 'package:pak_lpg/Onboarding/SignupScreen.dart';
import 'package:pak_lpg/Dashboard/DashboardScreen.dart';

class Body extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<Body> {
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String mobileNumber;
    String password;

    Future<String> loadViewData() async {
      if (mobileNumber == null) {
        mobileNumber = "";
      }
      return "OK";
    }

    return WillPopScope(
      onWillPop: () => utils.onBackPressed(context),
      child: Background(
        barTitle: "Sign In",
        showHeader: true,
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(children: <Widget>[
              Column(children: <Widget>[
                SizedBox(height: size.height * 0.35),
                RoundedInputField(
                  hintText: (mobileNumber == null || mobileNumber.length <= 0)
                      ? "Enter Mobile Number"
                      : mobileNumber,
                  readonly: (mobileNumber == null || mobileNumber.length <= 0)
                      ? false
                      : true,
                  onChanged: (value) {
                    mobileNumber = value;
                  },
                ),
                SizedBox(height: size.height * 0.001),
                RoundedPasswordField(
                  hintText: "Password",
                  onChanged: (value) {
                    password = value;
                  },
                ),
                SizedBox(height: size.height * 0.04),
                RoundedButton(
                  text: "LOGIN",
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DashboardScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(height: size.height * 0.02),
                GestureDetector(
                  // When the child is tapped, show a snackbar.
                    onTap: () {
                      final snackBar =
                      SnackBar(content: Text("Clicked the Container!"));

                      Scaffold.of(context).showSnackBar(snackBar);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(color: kSecondaryTextColour),
                    )),
                SizedBox(height: size.height * 0.02),
                AlreadyHaveAnAccountCheck(
                  login: true,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignupScreen();
                        },
                      ),
                    );
                  },
                )
              ])
            ])),
      ),
    );
  }
}

