import 'package:flutter/material.dart';
import 'package:pak_lpg/commons/constants.dart';

class MATabBar extends StatelessWidget implements PreferredSizeWidget {
  final List<Tab> tabs;
  final AppBar appBar;

  Size size;

  MATabBar({this.tabs, this.appBar});

  @override
  Size get preferredSize =>
      new Size.fromHeight(appBar.preferredSize.height * 2.5);

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return AppBar(
      brightness: Brightness.dark,
      backgroundColor: kPrimaryColor,
      title: getAppBarTitle,
      bottom: getBottom,
    );
  }

  get getAppBarTitle => Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Image.asset(
            'lib/assets/eccogas.png',
            height: 220,
            width: 220,
          ),
          SizedBox(
            width: size.width * .05,
          ),
          Text(
            kCompanyName,
            style: TextStyle(color: Colors.white70, fontSize: 24),
            textAlign: TextAlign.left,
          ),
        ],
      );

  get getBottom => PreferredSize(
      preferredSize: Size.fromHeight(40.0),
      child: Column(children: <Widget>[
        Divider(
          height: 2,
        ),
        Container(
            margin: EdgeInsets.only(left: 20),
            child: TabBar(
                isScrollable: true, indicatorColor: Colors.black, tabs: tabs))
      ]));
}
