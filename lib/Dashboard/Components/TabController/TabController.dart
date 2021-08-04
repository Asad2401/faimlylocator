import 'package:flutter/material.dart';
import 'package:pak_lpg/Dashboard/Components/TabController/TabControllerBar.dart';
import 'package:pak_lpg/commons/storage.dart';

class MATabContoller extends StatefulWidget {
  final AppBar appBar;
  final BuildContext parent;
  final List<Tab> tabs;


  MATabContoller({this.appBar, this.parent, this.tabs});

  @override
  _MATabContollerState createState() => _MATabContollerState();
}

class _MATabContollerState extends State<MATabContoller> {
  String userName;
  void initState() {
    loadViewData();
    super.initState();
  }
  Future<String> loadViewData() async {


    userName = await Storage().getCustomer_name();

    return "OK";
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: widget.tabs.length,
        child: Scaffold(
            appBar: MATabBar(
              tabs: widget.tabs,
              appBar: widget.appBar,
            ),
            //drawer: DashboardDrawer(),
            body: getTabBarView
        ));
  }

  get getTabBarView => TabBarView(
          children: widget.tabs.map((Tab tab) {
        if (tab.text.contains("DASHBOARD")||tab.text.contains("ڈیش بورڈ")) {
          //return getStaggeredGridView();

        } else if (tab.text.contains("LIVE CONTRACT")||tab.text.contains("براہ راست معاہدہ")) {
        } else if (tab.text.contains("DELIVERED ORDER")||tab.text.contains("آرڈر پہنچایا گیا")) {
        } else if (tab.text.contains("CLOSING BALANCE")||tab.text.contains("بقایا رقم")) {
          //return ReceivablesBody();
        } else if (tab.text.contains("ORDER")||tab.text.contains("آرڈر")) {
        }
      }).toList());
}
