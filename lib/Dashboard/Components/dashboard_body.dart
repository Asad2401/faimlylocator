import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:pak_lpg/Dashboard/Components/dashboard_drawer.dart';
import 'package:pak_lpg/commons/storage.dart';
import 'package:pak_lpg/commons/utils.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/localization/language_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<Tab> tabs;
  Size size;
  String userName;
  String customerId;
  String version;

  Future<String> loadViewData() async {


    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String ver = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    version = ver + "(" + buildNumber + ")";

    userName = await Storage().getCustomer_name();
    customerId = await Storage().getCustomer_id();

    return "OK";
  }

  Future<Locale> getLocale1() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
    return _locale1(languageCode);
  }
   _locale1(String languageCode) {
    switch (languageCode) {
      case ENGLISH:
        tabs = <Tab>[

          Tab(text: 'DASHBOARD'),
           Tab(text: 'BANK DETAILS'),
          // Tab(text: 'ORDER'),
          // Tab(text: 'DELIVERED ORDER'),
          // Tab(text: 'CLOSING BALANCE'),
        ];
        break;
      case URDU:
        tabs = <Tab>[

          Tab(text: 'ڈیش بورڈ'),
          Tab(text: 'بینک کی تفصیلات'),
          // Tab(text: 'آرڈر'),
          // Tab(text: 'آرڈر پہنچایا گیا'),
          // Tab(text: 'بقایا رقم'),
        ];
        break;

      default:
        return Locale(ENGLISH, 'US');
    }
  }

  get getWillPopScope => WillPopScope(

      onWillPop: () => utils.onBackPressed(context),
      child: DefaultTabController(
          length: tabs.length,
          child: Scaffold(
              appBar: buildAppBar(context),
              drawer: DashboardDrawer(userName: userName, version: version, customerId: customerId),
              body: getTabBarView))
  );
  get getTabBarView => TabBarView(
      children: tabs.map((Tab tab) {
        if (tab.text.contains("DASHBOARD")||tab.text.contains("ڈیش بورڈ")) {
          //return getStaggeredGridView();

        } else if (tab.text.contains("BANK DETAILS")||tab.text.contains("بینک کی تفصیلات")) {
          //return BankDetails();
        } else if (tab.text.contains("DELIVERED ORDER")||tab.text.contains("آرڈر پہنچایا گیا")) {
        } else if (tab.text.contains("CLOSING BALANCE")||tab.text.contains("بقایا رقم")) {
          //return ReceivablesBody();
        } else if (tab.text.contains("ORDER")||tab.text.contains("آرڈر")) {
        }
      }).toList());

  PreferredSize buildAppBar(BuildContext context) {

    List<Widget> actions = [];

    double height = MediaQuery.of(context).size.height;
    return PreferredSize(
      preferredSize: Size.fromHeight(height * .17),
      child: new AppBar(
          backgroundColor: kPrimaryColor,
          //foregroundColor: kPrimaryColor1,
          shadowColor: kPrimaryColor1,
          toolbarHeight: height * .1,
          title: getAppBarTitle,
          bottom: getBottom,
          actions: actions),
    );
  }

  get getAppBarTitle => Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[

      Image.asset(
        'assets/images/logo.png',
        height: 40,
      ),
      SizedBox(width: 0),
      Text(kCompanyName, style: TextStyle(color: Colors.white70, fontSize: 24), textAlign: TextAlign.left,),
    ],
  );

  get getBottom => PreferredSize(

      preferredSize: Size.fromHeight(40.0),
      child: Column(
          children: <Widget>[
            Divider(
              height: 1,
            ),
            Container(
                margin: EdgeInsets.only(left: 20),
                child: TabBar(
                    isScrollable: true,
                    indicatorColor: Colors.white,
                    tabs: tabs
                )
            )
          ]
      )
  );

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
  void initState() {


    getLocale1();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getTranslated(context, 'Reporting_Time');


    return getFutureBuilder;
  }
}
