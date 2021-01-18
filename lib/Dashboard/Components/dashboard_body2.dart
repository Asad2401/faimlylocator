import 'package:flutter/material.dart';

import '../../constants.dart';

class Dashboard_body2 extends StatefulWidget {
  @override
  _Dashboard_body2State createState() => _Dashboard_body2State();
}

class _Dashboard_body2State extends State<Dashboard_body2> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on_sharp,
            size: 60.0,
            color: kPrimaryColor,
          ),
          SizedBox(
            height: 10.0,
          ),
          Text(
            "Track Driver Location",
            style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20.0,
          ),
          Text(""),
          FlatButton(
            height: 50,
            minWidth: 240,
            onPressed: () {},
            color: kPrimaryColor,
            child: Text("TRACK NOW",
                style: TextStyle(color: Colors.white, fontSize: 18)),
          )
        ],
      ),
    );
  }
}
