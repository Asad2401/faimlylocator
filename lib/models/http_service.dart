import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:pak_lpg/Dashboard/Components/home_page.dart';
import 'package:pak_lpg/Dashboard/Components/logistics_screen_details.dart';
import 'package:pak_lpg/commons/storage.dart';
import 'package:pak_lpg/models/customer_details.dart';
import 'package:pak_lpg/models/get_location_model.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/commons/utils.dart';

import 'package:http/http.dart' as http;

String erp;

class HttpService {


  static void Login(BuildContext context, String userName, String password, bool resync) async {

    http.Response response;
    try
    {
      final GlobalKey<State> _keyLoader = new GlobalKey<State>();
      // var map = new Map<String, dynamic>();
      // map['email'] = userName;
      // map['password'] = password;
      // Map data = {
      //   "email":userName,
      //   "password":password
      // };
      //encode Map to JSON
      //var body = json.encode(data);


      utils.showLoadingDialog(context, _keyLoader);

      response = await http.post(
        // log_in_url + auth_key,
        'https://vexxortech.com/ws/ft/index.php/api/v1.0/user/logtest?email=$userName&password=$password',
        headers: {"Content-Type": "application/json"},

       // body: map,
      );

      //print("==================$userName CODE==================");
      //Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
      Navigator.of(context).pop();

      //print("==================$userName CODE==================");

      if (response.statusCode == 200) {

        LoginModel loginModel = LoginModel.fromJson(json.decode(response.body));
        StorageBase storage = Storage();
        //await storage.updatetokenInfo(loginModel);
        //OnboardingResponseNew resp = OnboardingResponseNew.fromJson(json.decode(response.body));

        print("==================RESPONSE CODE==================");
        print(response.body);


        if(loginModel.isSuccess == 1) {
          print(loginModel.response.me.firstName);
          print(loginModel.response.me.contact);
          print(loginModel.response.child[1].firstName);
          print(loginModel.response.child[1].email);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return LogisticsDetail();
              },
            ),
          );

          // Requests.getInvoiceData(context, loginModel.jwt);
          print('===========Calling From Login=========');
        }

      } else {

        //utils().showDialogCustom(context, "Failed", "Failed to connect with the server. Server Response Code = " + response.statusCode.toString(), "OK");
      }
    }

    catch(error) {
      print(error);
    }

  }

  static Future<LocationModel1> Locations(BuildContext context, String id, String lagLog, bool resync) async {

    http.Response response;
    try
    {
      final GlobalKey<State> _keyLoader = new GlobalKey<State>();

      utils.showLoadingDialog(context, _keyLoader);

      response = await http.post(
        // log_in_url + auth_key,
        'https://vexxortech.com/ws/ft/index.php/api/v1.0/user/updateLoc?id=$id&latlong=$lagLog',
        headers: {"Content-Type": "application/json"},

      );

       if (response.statusCode == 200) {

        LocationModel1 locationModel = LocationModel1.fromJson(json.decode(response.body));
        final data = jsonDecode(response.body);
        StorageBase storage = Storage();
        //await storage.updatetokenInfo(loginModel);
        //OnboardingResponseNew resp = OnboardingResponseNew.fromJson(json.decode(response.body));

        print("==================RESPONSE CODE==================");
        print(response.body);


        if(locationModel.isSuccess == 1) {

          print(locationModel.response[1].uid);
          print('ocationModel.response[1].uid');
          print(locationModel.response[1].latlong);
          print(locationModel.response[1].parentId);
          print(locationModel.response[1].allowChild);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return LogisticsDetail();
          //     },
          //   ),
          // );

          // Requests.getInvoiceData(context, loginModel.jwt);
          print('===========Calling From Login=========');
          return LocationModel1.fromJson(data);
        }

      }
    }

    catch(error) {
      print(error);
    }

  }















}

