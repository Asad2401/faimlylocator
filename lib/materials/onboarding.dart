import 'package:flutter/material.dart';
import 'package:pak_lpg/constants.dart';

class onboarding {
  static Container getAppBarContainer() {
    return Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              kPrimaryColor,
              kPrimaryColor,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
    );
  }

  static AppBar getAppBar(
      String title, bool displayBackArrow, BuildContext context) {
    if (displayBackArrow) {
      return AppBar(
        brightness: Brightness.dark,
        backgroundColor: kPrimaryColor,
        flexibleSpace: getAppBarContainer(),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(),
        ),
        //bottom: getBottom,
      );
    } else {
      return AppBar(
        brightness: Brightness.dark,
        backgroundColor: kPrimaryColor,
        flexibleSpace: getAppBarContainer(),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(),
        ),
        //bottom: getBottom,
      );
    }
  }

  static getHeader(Size size, double heightFactor) {
    return Container(
      padding: EdgeInsets.only(top: size.height * .02),
      width: size.width,
      height: size.height * heightFactor,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              kBackgroundColor,
              kBackgroundColor,
            ],
            begin: const FractionalOffset(0.0, 0.0),
            end: const FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Column(
        children: <Widget>[
          Padding(
              padding: EdgeInsets.only(top: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'lib/assets/logo.png',
                    height: 90,
                  ),
                  SizedBox(
                    width: 10,
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
          // Container(
          //   padding: EdgeInsets.only(left: size.width * .05),
          //     width: size.width * 0.5,
          //     child: Text(
          //       "Sign into your account",
          //       textAlign: TextAlign.center,
          //       style: TextStyle(
          //         fontSize: 16.0,
          //         fontWeight: FontWeight.bold,
          //         color: kSecondryGradientColor,
          //         fontStyle: FontStyle.italic,
          //       ),
          //     ))
        ],
      ),
    );
  }
}
