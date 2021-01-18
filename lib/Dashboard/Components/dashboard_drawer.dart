import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pak_lpg/commons/constants.dart';

class DashboardDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          getUserAccountsDrawerHeader,
          new Divider(),
          ListTile(
            title: Text('Home'),
            leading: new Icon(Icons.home_outlined),
            trailing: new Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    //return Dashboard();
                  },
                ),
              );
            },
          ),
          new Divider(),
          ListTile(
            title: Text('My Account'),
            leading: new Icon(Icons.account_circle_outlined),
            trailing: new Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    //return AccountScreen();
                  },
                ),
              );
            },
          ),
          new Divider(),
          ListTile(
            title: Text('Privacy Policy'),
            leading: new Icon(Icons.speaker_notes),
            trailing: new Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    //return AccountScreen();
                  },
                ),
              );
            },
          ),
          new Divider(),
          ListTile(
            title: Text('Ecco-Gas'),
            leading: new Icon(Icons.local_fire_department_outlined),
            trailing: new Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    //return InvoicesScreen();
                  },
                ),
              );
            },
          ),
          new Divider(),
          ListTile(
            title: Text('Sign Out'),
            leading: new Icon(Icons.exit_to_app_outlined),
            trailing: new Icon(Icons.arrow_forward_ios_outlined),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    //return TasksScreen();
                  },
                ),
              );
            },
          ),
          new Divider(),
        ],
      ),
    );
  }

  get getUserAccountsDrawerHeader => UserAccountsDrawerHeader(
        accountName: new Text(""),
        accountEmail: new Text(""),
        decoration: BoxDecoration(
          color: kPrimaryColor,
        ),
        currentAccountPicture: Image.asset(
          'lib/assets/eccogas.png',
          width: 300,
          height: 150,
          fit: BoxFit.values[6],
        ),
        otherAccountsPictures: <Widget>[
          // new CircleAvatar(
          //     backgroundImage: ExactAssetImage('assets/images/group.png'))
        ],
      );
}
