import 'package:flutter/material.dart';
import 'package:pak_lpg/Onboarding/Background.dart';
import 'package:pak_lpg/commons/no_account_text.dart';
import 'package:pak_lpg/commons/socal_card.dart';
import 'package:pak_lpg/size_config.dart';
import 'package:pak_lpg/commons/utils.dart';
import 'sign_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => utils.onBackPressed(context),
      child: Background(
        barTitle: "Sign In",
        showHeader: true,
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: SizeConfig.screenHeight / 7),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: getProportionateScreenWidth(24),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Sign in with your email and password  \nor continue with social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: SizeConfig.screenHeight * 0.06),
                  SignForm(),
                  SizedBox(height: SizeConfig.screenHeight * 0.020),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocalCard(
                        icon: "assets/icons/google-icon.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/facebook-2.svg",
                        press: () {},
                      ),
                      SocalCard(
                        icon: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: getProportionateScreenHeight(20)),
                  NoAccountText(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
