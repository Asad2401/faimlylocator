import 'package:flutter/material.dart';
import 'package:pak_lpg/Onboarding/Background.dart';
import 'package:pak_lpg/size_config.dart';

import 'package:pak_lpg/constants.dart';

import 'sign_up_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Background_signup(
      child: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          'lib/assets/loc.png',
                          height: 100,
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
                    ),
                  ),
                 // SizedBox(height: SizeConfig.screenHeight * 0.02), // 4%
                  Text("Register Account", style: headingStyle),
                  Text(
                    "Complete your details",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.03),
                  SignUpForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
