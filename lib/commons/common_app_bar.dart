import 'package:flutter/material.dart';
import 'package:pak_lpg/commons/constants.dart';

class CommonTopBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final double topBarHeight;

  @override
  final Size preferredSize;

  CommonTopBar({
    @required this.title,
    @required this.topBarHeight,
  }): preferredSize = Size.fromHeight(topBarHeight);

  List<Widget> getListOfChildren(BuildContext context, double width) {

    List<Widget> ret = [];
    ret.add(InkWell(
      child: Container(
        width: width * .6,
        child: Row(
          children: <Widget>[
            Icon(Icons.arrow_back, color: Colors.white70,),
            SizedBox(width: width*.03,),
            Text(title, style: TextStyle(color: Colors.white70, fontSize: 20)),
          ],
        ),
      ),
      onTap: () => Navigator.pop(context),
    ));

    return ret;
  }
  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    double paddingTop = MediaQuery.of(context).padding.top;
    return Container(
        padding: new EdgeInsets.only(top: paddingTop),
        decoration: new BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  kPrimaryColor,
                  kPrimaryColor1
                ]
            ),
            boxShadow: [
              new BoxShadow(
                color: Colors.grey[500],
                blurRadius: 5.0,
                spreadRadius: 1.0,
              )
            ]
        ),
        child: new Padding(
          padding: const EdgeInsets.only(
              left: 30.0, top: 30.0, right: 40.0, bottom: 20.0),
          child: new Column(
            children: <Widget>[
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children:getListOfChildren(context, width)
              ),
            ],
          ),
        ));
  }
}