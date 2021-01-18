import 'package:flutter/material.dart';
import 'package:pak_lpg/commons/utils.dart';
import 'package:pak_lpg/commons/constants.dart';
import 'package:pak_lpg/Dashboard/Components/TabController/TabController.dart';
import 'package:pak_lpg/Dashboard/Components/TabController/TabControllerBar.dart';

class Body extends StatefulWidget {
  @override
  _MyBodyState createState() => _MyBodyState();
}

class _MyBodyState extends State<Body> {
  final List<Tab> tabs = <Tab>[
    Tab(text: 'DASHBOARD'),
    Tab(text: 'TRACK ORDER')
  ];

  Future<String> loadViewData() async {
    return "OK";
  }

  get getWillPopScope => WillPopScope(
      onWillPop: () => utils.onBackPressed(context),
      child: MATabContoller(
        appBar: AppBar(),
        parent: context,
        tabs: tabs,
      ));

  get getFutureBuilder => FutureBuilder<String>(
      future: loadViewData(),
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.hasData) {
          return getWillPopScope;
        } else {
          return utils.circularIndicatorInView();
        }
      });

  @override
  Widget build(BuildContext context) {
    return getFutureBuilder;
  }
}
