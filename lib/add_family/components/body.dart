import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pak_lpg/Onboarding/Components/form_error.dart';
import 'package:pak_lpg/commons/default_button.dart';
import 'package:pak_lpg/localization/language_constants.dart';

import 'package:pak_lpg/screens/forgot_password/components/changePassForm.dart';

import 'package:pak_lpg/size_config.dart';
import 'package:http/http.dart' as http;

import '../../../constants.dart';

class BodyAddFamily extends StatefulWidget {
  @override
  _BodyAddFamilyState createState() => _BodyAddFamilyState();
}

class _BodyAddFamilyState extends State<BodyAddFamily> {

  final _formKey = GlobalKey<FormState>();

  String email;
  String contact;
  bool remember = false;
  bool visibleForm = false;

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
          "old_password": contact,

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

  AppBar buildAppBar(BuildContext context) {

    List<Widget> actions = [];
    actions.add(IconButton(
        icon: Icon(Icons.add),
        onPressed: () {

          setState(() {
            visibleForm = true;
          });
        }));

    double height = MediaQuery.of(context).size.height;
    return new AppBar(
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        //foregroundColor: kPrimaryColor1,
        //shadowColor: kPrimaryColor1,
        toolbarHeight: height * .1,
        title: new Text('Family'),
        actions: actions
    );

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),

      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20), vertical: 30),
            child: Column(
              children: [
                visibleForm ? Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight * 0.04),
                  Text('Add Family',
                    style: TextStyle(
                      fontSize: getProportionateScreenWidth(28),
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Enter Details to Add your family members',
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.1),
                  buildEmailFormField(),
                  SizedBox(height: getProportionateScreenHeight(25)),
                  buildContactFormField(),
                  SizedBox(height: getProportionateScreenHeight(25)),
                  FormError(errors: errors),
                  SizedBox(height: getProportionateScreenHeight(60)),
                  DefaultButton(
                    text: 'Send Request',
                    press: () {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        // if all are valid then go to success screen
                        //Navigator.pushNamed(context, CompleteProfileScreen.routeName);
                        setState(() {
                          visibleForm = false;
                        });
                        //_submitDetails();
                      }
                    },
                  ),
                  SizedBox(height: getProportionateScreenHeight(35)),
                  //NoAccountText(),
                ],
              ),
            ) :
                Text('Hit (+) to add your family',style: TextStyle(color: Colors.green),),
              ],
            ),
          ),
        ),
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
}
