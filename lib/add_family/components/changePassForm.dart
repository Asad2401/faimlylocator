import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pak_lpg/Onboarding/Components/form_error.dart';
import 'package:pak_lpg/commons/custom_surfix_icon.dart';
import 'package:pak_lpg/commons/default_button.dart';
import 'package:pak_lpg/commons/no_account_text.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/localization/language_constants.dart';
import 'package:pak_lpg/screens/sign_in/sign_in_screen.dart';
import 'package:pak_lpg/size_config.dart';
import 'package:http/http.dart' as http;

class ForgotPassForm extends StatefulWidget {
  @override
  _ForgotPassFormState createState() => _ForgotPassFormState();
}

class _ForgotPassFormState extends State<ForgotPassForm> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String password;
  String new_password;
  String email;
  bool remember = false;
  final List<String> errors = [];

  String status = '';

  String errMessage = 'Error in Uploading';


  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
  void _submitDetails() {

    String myUrl =
        base_url + "changePassword.php";

    http
        .post(myUrl,
        body: ({

          "email": email,
          "old_password": password,
          "password": new_password,

        }))
        .then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
      print(result.statusCode);

      if (result.statusCode == 200) {
        Fluttertoast.showToast(
            msg: "${status}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.SNACKBAR,
            backgroundColor: Colors.lightGreen,
            textColor: Colors.white,
            fontSize: 16.0,
            timeInSecForIosWeb: 1);


      }




    });


  }

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(25)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(25)),
          buildnewPasswordFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(60)),
          DefaultButton(
            text: getTranslated(context, 'Continue'),
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                //Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                _submitDetails();
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(35)),
          //NoAccountText(),
        ],
      ),
    );
  }



  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: getTranslated(context, 'Enter_your_password'));
        } else if (value.length >= 4) {
          removeError(error: getTranslated(context, 'Password_too_short'));
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: getTranslated(context, 'Enter_your_password'));
          return "";
        } else if (value.length < 4) {
          addError(error: getTranslated(context, 'Password_too_short'));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, 'password'),
        hintText: getTranslated(context, 'password_hint'),

        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
      controller: passwordController,
    );
  }

  TextFormField buildnewPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => new_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: getTranslated(context, 'Enter_your_password'));
        } else if (value.length >= 4) {
          removeError(error: getTranslated(context, 'Password_too_short'));
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: getTranslated(context, 'Enter_your_password'));
          return "";
        } else if (value.length < 4) {
          addError(error: getTranslated(context, 'Password_too_short'));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, 'new_password'),
        hintText: getTranslated(context, 'new_passwordhint'),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: getTranslated(context, 'Enter_your_email'));
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: getTranslated(context, 'Enter_Valid_Email'));
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: getTranslated(context, 'Enter_your_email'));
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: getTranslated(context, 'Enter_Valid_Email'));
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: getTranslated(context, 'email'),
        hintText: getTranslated(context, 'email_hint'),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
      controller: emailController,
    );
  }
}
