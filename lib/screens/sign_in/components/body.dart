import 'package:flutter/material.dart';
import 'package:pak_lpg/Dashboard/Components/logistics_screen_details.dart';
import 'package:pak_lpg/Dashboard/DashboardScreen.dart';
import 'package:pak_lpg/Onboarding/Background.dart';
import 'package:pak_lpg/Onboarding/Components/form_error.dart';
import 'package:pak_lpg/commons/custom_surfix_icon.dart';
import 'package:pak_lpg/commons/default_button.dart';
import 'package:pak_lpg/commons/language.dart';
import 'package:pak_lpg/commons/no_account_text.dart';
import 'package:pak_lpg/commons/socal_card.dart';
import 'package:pak_lpg/commons/storage.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/localization/language_constants.dart';
import 'package:pak_lpg/main.dart';
import 'package:pak_lpg/models/customer_details.dart';
import 'package:pak_lpg/models/http_service.dart';
import 'package:pak_lpg/screens/forgot_password/forgot_password_screen.dart';
import 'package:pak_lpg/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  void _changeLanguage(Language language) async {
    Locale _locale = await setLocale(language.languageCode);
   // MyApp.setLocale(context, _locale);
  }




  void initState() {
    super.initState();
    autoLogIn();
    _passwordVisible = false;
  }

  String email;
  String password;
  bool remember = false;
  bool isLoggedIn = false;
  final List<String> errors = [];
  bool _passwordVisible = false;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  String message = '';

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String userEmail = prefs.getString('useremail');
    final String userPass = prefs.getString('userpass');

    if (userEmail != null || userPass != null) {
      setState(() {
        isLoggedIn = true;
        email = userEmail;
        password = userPass;
      });
      return;
    }
  }

  Future<Null> logout() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('useremail', null);
    prefs.setString('userpass', null);

    setState(() {
      email = '';
      password = '';
      isLoggedIn = false;
    });
  }

  Future<Null> loginUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('useremail', email);
    prefs.setString('userpass', password);

    setState(() {
      email = email;
      password = password;
      isLoggedIn = true;
    });

     emailController.clear();
     passwordController.clear();
  }

  // @override
  // void dispose() {
  //   emailController.dispose();
  //   passwordController.dispose();
  //   super.dispose();
  // }



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
    return Scaffold(
          appBar: AppBar(
            backgroundColor: kPrimaryColor,
            title: Text(getTranslated(context, 'signin_title'),),
            actions: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 25, left: 25),
                child: DropdownButton(
                  onChanged:(Language language){
                    _changeLanguage(language);
                  },
                  underline: SizedBox(),
                  icon: Icon(
                    Icons.language,
                    color: Colors.white,
                  ),
                  items: Language.languageList()
                      .map<DropdownMenuItem<Language>>(
                        (lang) => DropdownMenuItem<Language>(
                      value: lang,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            lang.flag,
                            style: TextStyle(fontSize: 15),
                          ),
                          Text(lang.name)
                        ],
                      ),
                    ),
                  )
                      .toList(),
                ),
              ),
            ],
          ),

          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(top: 40),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(
                            'lib/assets/loc.png',
                            height: 100,
                          ),

                          // Text(
                          //   kCompanyName,
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 5,
                          //   textAlign: TextAlign.center,
                          //   style: TextStyle(
                          //     fontSize: 28.0,
                          //     fontWeight: FontWeight.bold,
                          //     color: kPrimaryColor,
                          //     fontStyle: FontStyle.italic,
                          //   ),
                          // ),
                        ],
                      )),
                  SizedBox(height: SizeConfig.screenHeight / 50),
                  Text(
                      getTranslated(context, 'welcome'),
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: getProportionateScreenWidth(24),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    getTranslated(context, 'welcome_msg'),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[

                      //buildmobileFormField(),
                      !isLoggedIn ? TextFormField(
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
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                         Icons.email_outlined,

                          color: kPrimaryColor,
                        ),),
                    ),
                    controller: emailController,
                    ): Text(getTranslated(context, 'You_are_logged_in_as'),style: TextStyle(color: Colors.green),),
                      //Text(email),
                      SizedBox(height: getProportionateScreenHeight(30)),

                      //buildPasswordFormField(),
                      !isLoggedIn ? TextFormField(
                        obscureText: !_passwordVisible,
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
                controller: passwordController,
              ): Text(''),
                      isLoggedIn ? GestureDetector(
                        onTap: () => logout(),
                        //     Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => ForgotPasswordScreen()),
                        // ),
                        child: Text(
                          getTranslated(context, 'Use_another_account'),
                          style: TextStyle(decoration: TextDecoration.underline),
                        ),
                      ): Text(''),
                      SizedBox(height: getProportionateScreenHeight(30)),
                      Row(
                        children: [
                          // Checkbox(
                          //   value: isLoggedIn,
                          //   activeColor: kPrimaryColor,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       isLoggedIn = value;
                          //     });
                          //   },
                          // ),
                          // Text(getTranslated(context, 'remember_me'),),
                          Spacer(),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ForgotPasswordScreen()),
                            ),
                            child: Text(
                              getTranslated(context, 'change_pass'),
                              style: TextStyle(decoration: TextDecoration.underline),
                            ),
                          )
                        ],
                      ),
                      FormError(errors: errors),
                      SizedBox(height: getProportionateScreenHeight(20)),
                      DefaultButton(
                        text: getTranslated(context, 'submit_info'),
                        press: () async {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return LogisticsDetail();
                          //     },
                          //   ),
                          // );
                          if (_formKey.currentState.validate()) {
                            _formKey.currentState.save();
                            // var email = emailController.text;
                            // var password = passwordController.text;
                            // Storage().updatepassword(password);
                            // isLoggedIn ? logout() : loginUser();


                            HttpService.Login(context, email, password, true);
                            print(email);
                            loginUser();



                            //await OrderDetails.request(context, '02020207008', true);
//                // var rsp = await loginUser(email, password);
                            // print(rsp);
                            //
                            // if (rsp['status'] == "1") {
                            //   Navigator.push(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => DashboardScreen()),
                            //   );
                            // } else {
                            //   setState(() {
                            //     Text(
                            //       message = rsp['error'],
                            //       style: TextStyle(color: Colors.deepOrange),
                            //     );
                            //   });
                            // }

                          }
                        },
                      ),
                      SizedBox(height: 5),
                      Text(message),
                      SizedBox(height: 5),
                    ],
                  ),
                ),
                  SizedBox(height: SizeConfig.screenHeight * 0.020),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: [
                  //     SocalCard(
                  //       icon: "assets/icons/google-icon.svg",
                  //       press: () {},
                  //     ),
                  //     SocalCard(
                  //       icon: "assets/icons/facebook-2.svg",
                  //       press: () {},
                  //     ),
                  //     SocalCard(
                  //       icon: "assets/icons/twitter.svg",
                  //       press: () {},
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  NoAccountText(),
                ],
              ),
            ),
          ),
        );
  }

}
