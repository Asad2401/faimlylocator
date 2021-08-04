import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pak_lpg/commons/utils.dart';

import 'package:flutter/material.dart';
import 'package:pak_lpg/Dashboard/DashboardScreen.dart';
import 'package:pak_lpg/Onboarding/Components/form_error.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/commons/custom_surfix_icon.dart';
import 'package:pak_lpg/commons/default_button.dart';
import 'package:pak_lpg/screens/sign_in/sign_in_screen.dart';
import 'package:pak_lpg/size_config.dart';
import 'package:http/http.dart' as http;

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  var email;
  var password;
  var conform_password;
  var fName;
  var lName;
  var contact;
  var convertDataToJson;
  bool remember = false;
  String status = '';
  String radioButtonItem = '1';
  bool _passwordVisible = false;
  bool _passwordVisible2 = false;


  // Group Value for Radio Button.
  int id = 1;
  String errMessage = 'Error in Uploading';
  final List<String> errors = [];

  setStatus(String message) {
    setState(() {
      status = message;
    });
  }

  void _submitDetails() {
    String myUrl =
        "https://vexxortech.com/ws/ft/index.php/api/v1.0/user/register";
    http
        .post(myUrl,
            body: ({
              "email": email,
              "password": password,
              "first_name": fName,
              "last_name": lName,
              "contact": contact,
              "role": radioButtonItem,

            }))
        .then((result) {
      setStatus(result.statusCode == 200 ? result.body : errMessage);
      print(result.statusCode);
      print(result.body);
      print('body');

      if (result.statusCode == 200) {

          print(result.statusCode);
          Fluttertoast.showToast(
              msg: "${status}",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.SNACKBAR,
              backgroundColor: Colors.lightGreen,
              textColor: Colors.white,
              fontSize: 16.0,
              timeInSecForIosWeb: 1);
        }


      print(convertDataToJson);

    });





    print("ERP: ${lName}");
    print("Email: ${email}");
    print("Password: ${password}");
    print("ConfirmPassword: ${conform_password}");
    print("Full Name: ${fName}");
    print("Full Name: ${radioButtonItem}");


    // showDialog(
    //     context: context,
    //     child: AlertDialog(
    //       title: new Text("Details"),
    //       content: new SingleChildScrollView(
    //         child: new ListBody(
    //           children: <Widget>[
    //             new Text("${convertDataToJson}"),
    //             new Text("ERP No. : " + erp),
    //             new Text("Email : " + email),
    //             new Text("Password : " + password),
    //           ],
    //         ),
    //       ),
    //       actions: <Widget>[
    //         new FlatButton(
    //           child: new Text('OK'),
    //           onPressed: () {
    //             Navigator.of(context).pop();
    //             Navigator.push(
    //               context,
    //               MaterialPageRoute(
    //                 builder: (context) {
    //                   return SignInScreen();
    //                 },
    //               ),
    //             );
    //           },
    //         ),
    //       ],
    //     ));

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
  void initState() {
    super.initState();
    _passwordVisible = false;
    _passwordVisible2 = false;
  }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
           buildFirstNameFormField(),
           SizedBox(height: getProportionateScreenHeight(0)),
           buildLastNameFormField(),
           SizedBox(height: getProportionateScreenHeight(0)),
          buildEmailFormField(),
          SizedBox(height: getProportionateScreenHeight(0)),
          buildContactFormField(),
          SizedBox(height: getProportionateScreenHeight(0)),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(0)),
          buildConformPassFormField(),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(10)),
      Column(
        children: <Widget>[
          // Padding(
          //     padding: EdgeInsets.all(14.0),
          //     child: Text('Role = ' + '$radioButtonItem',
          //         style: TextStyle(fontSize: 21))
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Role:       ',
                style: new TextStyle(fontSize: 17.0,fontWeight: FontWeight.bold, color: kPrimaryColor),
              ),
              Radio(
                value: 1,
                groupValue: id,
                activeColor: kPrimaryColor,

                onChanged: (val) {
                  setState(() {
                    radioButtonItem = '1';
                    id = 1;
                  });
                },
              ),
              Text(
                'Parent',
                style: new TextStyle(fontSize: 14.0),
              ),

              Radio(
                value: 2,
                groupValue: id,
                activeColor: Colors.amber,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = '2';
                    id = 2;
                  });
                },
              ),
              Text(
                'Child',
                style: new TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ],
          ),
        ],
      ),
          SizedBox(height: getProportionateScreenHeight(10)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState.validate()) {
                _formKey.currentState.save();
                // if all are valid then go to success screen
                //Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                _submitDetails();
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "You have an account? ",
            style: TextStyle(fontSize: getProportionateScreenWidth(16)),
          ),
          GestureDetector(
            onTap: () => Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignInScreen())),
            child: Text(
              "Sign In",
              style: TextStyle(
                  fontSize: getProportionateScreenWidth(16),
                  color: kPrimaryColor),
            ),
          ),
        ],
      ),
        ],
      ),
    );
  }

  TextFormField buildConformPassFormField() {
    return TextFormField(
      obscureText: !_passwordVisible2,
      onSaved: (newValue) => conform_password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.isNotEmpty && password == conform_password) {
          removeError(error: kMatchPassError);
        }
        conform_password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if ((password != value)) {
          addError(error: kMatchPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Confirm Password",
        hintText: "Re-enter your password",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            _passwordVisible2
                ? Icons.visibility
                : Icons.visibility_off,
            color: kPrimaryColor,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              _passwordVisible2 = !_passwordVisible2;
            });
          },
        ),
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: !_passwordVisible,
      //obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 4) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 4) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Password",
        hintText: "Enter at least 4 Characters",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
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
        //CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return "";
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Email",
        hintText: "Enter your email",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            Icons.email_outlined,

            color: kPrimaryColor,
          ),),
        //CustomSurffixIcon(svgIcon: "assets/icons/Mail.svg"),
      ),
    );
  }
  TextFormField buildContactFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => contact = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kContactlNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kContactlNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Contact No.",
        hintText: "Enter your Contact No",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            Icons.phone,

            color: kPrimaryColor,
          ),),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => fName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kERPlNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kERPlNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "First Name.",
        hintText: "Enter your First Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            Icons.person,

            color: kPrimaryColor,
          ),),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      keyboardType: TextInputType.text,
      onSaved: (newValue) => lName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kENameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          addError(error: kENameNullError);
          return "";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Last Name",
        hintText: "Enter your Last Name",
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            Icons.account_circle_sharp,

            color: kPrimaryColor,
          ),),
      ),
    );
  }
}
