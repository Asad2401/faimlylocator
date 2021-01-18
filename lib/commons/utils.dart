import 'package:flutter/material.dart';
import 'dart:io';

class utils {

  static bool validatePhoneNumber(String number) {
    return RegExp(r"^(?:[+0]9)?[0-9]{10,13}$").hasMatch(number);
  }
  static bool validateEmail(String email) {
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  }
  static Future<bool> onBackPressed(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        actions: <Widget>[
          new FlatButton(
              child: new Text("No"),
              onPressed: () {
                Navigator.of(context).pop();
              }
          ),
          //SizedBox(height: 10),
          new FlatButton(
            child: new Text("Yes"),
            onPressed: ()=> exit(0),
          ),
        ],
      ),
    ) ??
        false;
  }

  static Widget circularIndicatorInView() {
    return new WillPopScope(
        onWillPop: () async => false,
        child: SimpleDialog(
            backgroundColor: Colors.black54,
            children: <Widget>[
              Center(
                child: Column(children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 10,),
                  Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                ]),
              )
            ]));
  }
  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
                      ]),
                    )
                  ]));
        });
  }

  void showDialogCustom(BuildContext context, String title, String body, String button) {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text(title),
          content: new Text(body),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text(button),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}