import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter_open_whatsapp/flutter_open_whatsapp.dart';
import 'package:pak_lpg/Dashboard/Components/TabController/menu_item.dart';
import 'package:pak_lpg/Dashboard/Components/logistics_screen_details.dart';
import 'package:pak_lpg/Dashboard/DashboardScreen.dart';
import 'package:pak_lpg/add_family/add_family_screen.dart';

import 'package:pak_lpg/commons/storage.dart';

import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/localization/language_constants.dart';
import 'package:pak_lpg/screens/sign_in/components/body.dart';
import 'package:pak_lpg/screens/sign_in/sign_in_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DashboardDrawer extends StatefulWidget {
  final String userName;
  final String customerId;
  final String version;

  DashboardDrawer({Key key, this.userName, this.version, this.customerId}) : super(key: key);

  @override
  _DashboardDrawerState createState() => _DashboardDrawerState(this.userName, this.version, this.customerId);
}

class _DashboardDrawerState extends State<DashboardDrawer> {
  final String userName;
  final String version;
  final String customerId;


  _DashboardDrawerState(this.userName, this.version, this.customerId);

  final signIn = Body();

    @override
  void initState() {
     // loadViewData();
    super.initState();
  }

    String support_number_IT = '+92-(344)8761342';
    String support_number_sale = '+97-(150)6038477';
    String support_number_ac = '+92-(300)0642744';

    // Future<String> loadViewData() async {
    //   StorageBase storage = Storage();
    //
    //   userName = await storage.getCustomer_name();
    //   if (userName == null) {
    //     userName = "";
    //   }
    // }

    @override
    Widget build(BuildContext context) {

      return Drawer(

        child: Row(

          children: <Widget>[
            //getUserAccountsDrawerHeader(userName, version),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                color: kPrimaryColor,
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 60,
                    ),
                    Image.asset(
                      'lib/assets/loc.png',
                      height: 60,
                    ),

                    Text(
                      kCompanyName,
                      style: TextStyle(color: Colors.white70, fontSize: 24),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      'version: 0.0.1',
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                      textAlign: TextAlign.left,
                    ),
                    Divider(
                      height: 10,
                      thickness: 0,
                      color: kPrimaryColor,
                      indent: 32,
                      endIndent: 32,
                    ),
                    Flexible(

                        child: Text(
                          'userName'+'\nledger Code : '+'customerId',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                          textAlign: TextAlign.left,
                        ),


                    ),
                    Divider(
                      height: 20,
                      thickness: 0.5,
                      color: Colors.white.withOpacity(0.3),
                      indent: 32,
                      endIndent: 32,
                    ),

                    MenuItem(
                      icon: Icons.home,
                      title: getTranslated(context, 'home'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen()),
                        );
                      },
                    ),
                    MenuItem(
                      icon: Icons.supervised_user_circle_outlined,
                      title: 'Family',
                      //getTranslated(context, 'Business_Address'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddFamilyScreen()),
                        );
                      },
                    ),
                    MenuItem(
                      icon: Icons.feedback_outlined,
                      title: 'Send Feedback',
                      //getTranslated(context, 'Bank_Details'),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => UploadBankDetails()),
                        // );
                      },
                    ),
                    MenuItem(
                      icon: Icons.settings,
                      title: 'Settings',
                      //getTranslated(context, 'Bank_Details'),
                      onTap: () {
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //       builder: (context) => UploadBankDetails()),
                        // );
                      },
                    ),

                    Padding(
                      padding: const EdgeInsets.only(left: 17),
                      child: Row(

                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.support,
                            color: Colors.white,
                            size: 25.0,
                          ),
                          Center(

                              child: MaterialButton(onPressed: (){
                                FlutterOpenWhatsapp.sendSingleMessage(support_number_IT, "Hello");
                              },
                                child: Text('Support',style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 16,
                                    color: Colors.white),),
                              )
                          ),
                        ],
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 17),
                    //   child: Row(
                    //
                    //     //mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Icon(
                    //         Icons.call,
                    //         color: Colors.white,
                    //         size: 25.0,
                    //       ),
                    //       Center(
                    //
                    //           child: MaterialButton(onPressed: (){
                    //             FlutterOpenWhatsapp.sendSingleMessage(support_number_sale, "Hello Mr. Rashid");
                    //           },
                    //             child: Text(getTranslated(context, 'For_Sales_Support'),style: TextStyle(
                    //                 fontWeight: FontWeight.w300,
                    //                 fontSize: 16,
                    //                 color: Colors.white),),
                    //           )
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 17),
                    //   child: Row(
                    //
                    //     //mainAxisAlignment: MainAxisAlignment.center,
                    //     children: <Widget>[
                    //       Icon(
                    //         Icons.wifi_calling_outlined,
                    //         color: Colors.white,
                    //         size: 25.0,
                    //       ),
                    //       Center(
                    //
                    //           child: MaterialButton(onPressed: (){
                    //             FlutterOpenWhatsapp.sendSingleMessage(support_number_ac, "Hello Mr. Tariq");
                    //           },
                    //             child: Text(getTranslated(context, 'For_Accounts_Support'),style: TextStyle(
                    //                 fontWeight: FontWeight.w300,
                    //                 fontSize: 16,
                    //                 color: Colors.white),),
                    //           )
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    //
                    // MenuItem(
                    //   icon: Icons.local_fire_department_outlined,
                    //   title: getTranslated(context, 'AYAN_ENERGY_Bank_Details'),
                    //   onTap: () {
                    //     // Navigator.push(
                    //     //   context,
                    //     //   MaterialPageRoute(
                    //     //       builder: (context) => BankDetails()),
                    //     // );
                    //   },
                    // ),
                    new FlatButton(
                      child: Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: new Text(
                            getTranslated(context, 'logout'),
                            style: TextStyle(color: Colors.black),
                          )),
                      onPressed: () async{
                        Storage().deleteAll();
                        SharedPreferences preferences = await SharedPreferences.getInstance();
                        await preferences.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignInScreen()));
                      },
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),

      );
    }

    UserAccountsDrawerHeader getUserAccountsDrawerHeader(String userName,
        String version) {
      return UserAccountsDrawerHeader(
        accountName: new Text("AYAN ENERGY"),
        accountEmail: new Padding(padding: EdgeInsets.only(right: 20.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(userName),
              Text(version)
            ],
          ),),
        decoration: BoxDecoration(
          color: kPrimaryColor,
        ),
        currentAccountPicture: new CircleAvatar(
            backgroundColor: kPrimaryColor,
            backgroundImage: ExactAssetImage('assets/images/logo.png')),
        otherAccountsPictures: <Widget>[
          // new CircleAvatar(
          //     backgroundImage: ExactAssetImage('assets/images/group.png'))
        ],
      );
    }

}
