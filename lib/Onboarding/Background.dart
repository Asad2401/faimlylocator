import 'package:flutter/material.dart';
import 'package:pak_lpg/materials/onboarding.dart';

class Background_signup extends StatelessWidget {
  final Widget child;

  const Background_signup({
    Key key,
    @required this.child,
  }) : super(key: key);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: onboarding.getAppBar("Sign up", true, context),
        backgroundColor: Colors.white70,
        body: Stack(
          children: <Widget>[
            //  ,
            child,
            onboarding.getHeader(size, .21)
            //Positioned(top: 0.0, child: onboarding.getHeader(size, .21)),
          ],
        ));
  }
}

class Background extends StatelessWidget {
  final Widget child;
  final String barTitle;
  final bool showHeader;

  const Background(
      {Key key,
      @required this.child,
      @required this.barTitle,
      @required this.showHeader = false})
      : super(key: key);

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: onboarding.getAppBar(barTitle, false, context),
      backgroundColor: Colors.white70,
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(children: <Widget>[
          if (showHeader) onboarding.getHeader(size, .21),
          Container(
            decoration: new BoxDecoration(
                image: new DecorationImage(
                    fit: BoxFit.scaleDown,
                    scale: 0.8,
                    colorFilter: new ColorFilter.mode(
                        Colors.white70.withOpacity(0.5), BlendMode.dstATop),
                    image: new AssetImage(''))),
          ),
          child
        ]),
      ),
    );
  }
}
