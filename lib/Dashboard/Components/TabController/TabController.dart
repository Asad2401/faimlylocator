import 'package:flutter/material.dart';
import 'package:pak_lpg/Dashboard/Components/TabController/TabControllerBar.dart';
import 'package:pak_lpg/Dashboard/Components/dashboard_body2.dart';
import 'package:pak_lpg/Dashboard/Components/dashboard_drawer.dart';
import 'package:pak_lpg/Dashboard/Components/StaggeredGridView/MAStaggeredGridView.dart';

class MATabContoller extends StatelessWidget {
  final AppBar appBar;
  final BuildContext parent;
  final List<Tab> tabs;

  MATabContoller({this.appBar, this.parent, this.tabs});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: tabs.length,
        child: Scaffold(
            appBar: MATabBar(
              tabs: tabs,
              appBar: appBar,
            ),
            drawer: DashboardDrawer(),
            body: getTabBarView));
  }

  get getTabBarView => TabBarView(
          children: tabs.map((Tab tab) {
        if (tab.text.contains("DASHBOARD")) {
          return MAStaggeredGridView();
          //return getStaggeredGridView();

        } else if (tab.text.contains("TRACK ORDER")) {
          return Dashboard_body2();
        } else if (tab.text.contains("GOALS")) {
          //return GoalsScreen();

        } else if (tab.text.contains("TASKS")) {
          //return TasksScreen();
        } else if (tab.text.contains("INVOICES")) {
          //return InvoicesScreen();
        }
      }).toList());
}
