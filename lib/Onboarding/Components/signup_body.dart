import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:pak_lpg/commons/constants.dart';
import 'package:pak_lpg/Onboarding/Background.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:email_validator/email_validator.dart';
import 'package:pak_lpg/Dashboard/DashboardScreen.dart';

class Body extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class MyData {
  String fullName = '';
  String cellNumber = '';
  String email = '';
  String cnic = '';
  String password = '';
  String confirmPassword = '';
}

class _MyBodyState extends State<Body> {
  int currStep = 0;
  static var _focusNode = new FocusNode();
  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  static MyData data = new MyData();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
      print('Has focus: $_focusNode.hasFocus');
    });
  }

  @override
  void dispose() {
    //_focusNode.dispose();
    super.dispose();
  }

  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context)
          .showSnackBar(new SnackBar(content: new Text(message)));
    }

    StepState _getState(int i) {
      if (currStep == i) {
        return StepState.editing;
      } else if (currStep > i) {
        return StepState.complete;
      } else {
        return StepState.indexed;
      }
    }

    void _submitDetails() {
      final FormState formState = _formKey.currentState;
      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
        formState.setState(() {});
      } else {
        formState.save();
        print("Name: ${data.fullName}");
        print("CNIC: ${data.cnic}");
        print("Phone: ${data.cellNumber}");
        print("Email: ${data.email}");

        showDialog(
            context: context,
            child: new AlertDialog(
              title: new Text("Details"),
              //content: new Text("Hello World"),
              content: new SingleChildScrollView(
                child: new ListBody(
                  children: <Widget>[
                    new Text("Name : " + data.fullName),
                    new Text("Phone : " + data.cellNumber),
                    new Text("Email : " + data.email),
                    new Text("Age : " + data.cnic),
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  child: new Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
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
              ],
            ));
      }
    }

    var controller_cnic = new MaskedTextController(mask: '00000-0000000-0');
    var controller_cell_number =
        new MaskedTextController(mask: '0000-0000-000');

    List<Step> steps = [
      new Step(
          title: const Text("Basic Info"),
          isActive: true,
          state: _getState(0),
          content: Column(
            children: <Widget>[
              new TextFormField(
                focusNode: _focusNode,
                keyboardType: TextInputType.text,
                autocorrect: false,
                onSaved: (String value) {
                  data.fullName = value;
                },
                maxLines: 1,
                //initialValue: 'Aseem Wangoo',
                validator: (name) {
                  Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                  RegExp regex = new RegExp(pattern);
                  if (!regex.hasMatch(name))
                    return 'Invalid username';
                  else
                    return null;
                },
                decoration: new InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Muhammad Asim Bajwa',
                    //filled: true,
                    icon: const Icon(Icons.perm_identity_rounded),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.black)),
              ),
              new TextFormField(
                controller: controller_cnic,
                keyboardType: TextInputType.number,
                autocorrect: false,
                onSaved: (String value) {
                  data.cnic = value;
                },
                maxLines: 1,
                //initialValue: 'Aseem Wangoo',
                validator: (value) {
                  if (value.isEmpty || value.length < 1) {
                    return 'Please enter CNIC';
                  }
                },
                decoration: new InputDecoration(
                    labelText: 'CNIC',
                    hintText: 'Enter CNIC without dashes',
                    //filled: true,
                    icon: const Icon(Icons.account_box_outlined),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.black)),
              )
            ],
          )),
      new Step(
          title: const Text('Contact Info'),
          //subtitle: const Text('Subtitle'),
          isActive: true,
          //state: StepState.editing,
          state: _getState(1),
          content: Column(
            children: <Widget>[
              new TextFormField(
                controller: controller_cell_number,
                keyboardType: TextInputType.phone,
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty || value.length < 10) {
                    return 'Please enter valid mobile number';
                  }
                },
                onSaved: (String value) {
                  data.cellNumber = value;
                },
                maxLines: 1,
                decoration: new InputDecoration(
                    labelText: 'Mobile Number',
                    hintText: '03338595969',
                    icon: const Icon(Icons.phone),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.black)),
              ),
              new TextFormField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                validator: (email) => EmailValidator.validate(email)
                    ? null
                    : "Invalid email address",
                onSaved: (String value) {
                  data.cellNumber = value;
                },
                maxLines: 1,
                decoration: new InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter a your Email',
                    icon: const Icon(Icons.email),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.black)),
              )
            ],
          )),
      new Step(
          title: const Text('Password'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: _getState(2),
          // state: StepState.disabled,
          content: Column(
            children: <Widget>[
              new TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_passwordVisible,
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty || value.length < 4) {
                    return 'Please enter a password';
                  } else {
                    data.password = value;
                  }
                },
                onSaved: (String value) {
                  data.password = value;
                },
                maxLines: 1,
                initialValue: '',
                decoration: new InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter a password',
                    icon: const Icon(Icons.lock),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(
                        //Based on passwordVisible state choose the icon
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
                    )),
              ),
              new TextFormField(
                keyboardType: TextInputType.visiblePassword,
                obscureText: !_confirmPasswordVisible,
                autocorrect: false,
                validator: (value) {
                  if (value.isEmpty || value.length < 4) {
                    return 'Please enter confirm password';
                  } else if (value.compareTo(data.password) != 0) {
                    return 'Password & Confirm Password not same.';
                  }
                },
                onSaved: (String value) {
                  data.confirmPassword = value;
                },
                maxLines: 1,
                initialValue: '',
                decoration: new InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Enter confirm password',
                    icon: const Icon(Icons.lock),
                    labelStyle: new TextStyle(
                        decorationStyle: TextDecorationStyle.solid,
                        color: Colors.black),
                    suffixIcon: IconButton(
                      icon: Icon(
                        //Based on passwordVisible state choose the icon
                        _confirmPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: kPrimaryColor,
                      ),
                      onPressed: () {
                        // Update the state i.e. toogle the state of passwordVisible variable
                        setState(() {
                          _confirmPasswordVisible = !_confirmPasswordVisible;
                        });
                      },
                    )),
              )
            ],
          )),
      new Step(
          title: const Text('Sign up'),
          // subtitle: const Text('Subtitle'),
          isActive: true,
          state: _getState(3),
          // state: StepState.disabled,
          content: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                width: size.width * .75,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Container(
                      child: FlatButton(
                        padding: EdgeInsets.symmetric(vertical: 5),
                        onPressed: _submitDetails,
                        child: Text(
                          "Sign up",
                          style: TextStyle(fontSize: 16),
                        ),
                        color: kPrimaryColor,
                        textColor: Colors.white70,
                      ),
                    )),
              )
            ],
          ))
    ];

    return new Background_signup(
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        height: size.height * .9,
        child: Theme(
          data: ThemeData(
              accentColor: kPrimaryColor,
              primarySwatch: colorCustom,
              colorScheme: ColorScheme.light(primary: kPrimaryColor)),
          child: new Form(
            key: _formKey,
            child: new ListView(children: <Widget>[
              SizedBox(height: size.height * 0.23),
              new Stepper(
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      currStep != 3
                          ? Row(
                              children: <Widget>[
                                FlatButton(
                                  onPressed: onStepCancel,
                                  child: Text("Back"),
                                ),
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      child: FlatButton(
                                        onPressed: onStepContinue,
                                        child: Text("Next"),
                                        color: kPrimaryColor,
                                        textColor: Colors.white70,
                                      ),
                                    )),
                              ],
                            )
                          : Row(
                              children: <Widget>[
                                Container(
                                  child: null,
                                ),
                                Container(
                                  child: null,
                                ),
                              ],
                            )
                    ],
                  );
                },
                physics: ClampingScrollPhysics(),
                steps: steps,
                type: StepperType.vertical,
                currentStep: this.currStep,
                onStepContinue: () {
                  setState(() {
                    if (currStep < steps.length - 1) {
                      currStep = currStep + 1;
                    } else {
                      currStep = 0;
                    }
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currStep > 0) {
                      currStep = currStep - 1;
                    } else {
                      currStep = 0;
                    }
                  });
                },
                onStepTapped: (step) {
                  setState(() {
                    currStep = step;
                  });
                },
              )
            ]),
          ),
        ),
      ),
    ));
  }
}
