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
import 'package:pak_lpg/models/logistics_model.dart';
import 'package:pak_lpg/models/myorder_model.dart';
import 'package:pak_lpg/models/order_details.dart';
import 'package:pak_lpg/models/orderdetails_model.dart';
import 'package:pak_lpg/models/receivables_model.dart';

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















  static Future<ReceivablesInfo> GetReceivables(BuildContext context, String ledger_code, bool showLoading) async {

    http.Response response;
    try
    {
      String url = kBaseUrl + "customer_closing_balance.php?ledgercode=${ledger_code}";
      //https://ayanenergyapps.com/management/managmentapi/receivables_json.php
      var uri = Uri.parse(url);
      final http.Response response = await http.get(uri);
print('ledger_code${ledger_code}');
      if (response.statusCode == 200) {

        List<ReceivablesModel> listModel = [];

        final data = jsonDecode(response.body);

        //double total_receivables = 0;


        return ReceivablesInfo(receivables: listModel);
        //CustomerStorage().updateOnboardingInfo(resp);
      }
    }
    catch(error) {
      print(error);
    }

    return null;
  }
  static Future<LogisticsInfo> GetLogisticsInfo(BuildContext context, String ledger_code,bool showLoading) async {

    http.Response response;
    try
    {
      String url = kBaseUrl2 + "vehicle_transit.php?ledger_code=${ledger_code}";
     // https://ayanenergyapps.com/management/api/exposeAPI/vehicle_transit.php?ledger_code=03040301242
    //?category=${ledger_code}
      var uri = Uri.parse(url);
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
          print(response.body);
          print('?ledger_code=${ledger_code}');



          List<LogisticsInformationModel> listModel = [];

        final data = jsonDecode(response.body);
        double bowzer_in_transit_quantity = 0;
        double bulk_sales_quantity = 0;
        double bowzer_at_plant_quantity = 0;


        LogisticsInfo fInfo = LogisticsInfo(bowzer_at_plant_quantity: bowzer_at_plant_quantity, bowzer_in_transit_quantity: bowzer_in_transit_quantity,
            bulk_sales_quantity: bulk_sales_quantity, logisticsInformation: listModel);

        return fInfo;
        //CustomerStorage().updateOnboardingInfo(resp);
      }
    }
    catch(error) {

      print(error);
    }

    return null;
  }

  static Future<MyOrderInfo> GetMyOrderInfo(BuildContext context, String ledger_code, bool showLoading) async {

    http.Response response;
    try
    {
      String url = kBaseUrl2 + "customer_orders.php?ledger_code=${ledger_code}";
      //https://ayanenergyapps.com/management/api/exposeAPI/customer_orders.php?ledger_code=03040301168

      var uri = Uri.parse(url);
      print(url);
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {

        print(response.body);
        List<MyOrderModel> listModel = [];

        final data = jsonDecode(response.body);





        MyOrderInfo fInfo = MyOrderInfo(myorderInformation: listModel);

        return fInfo;
        //CustomerStorage().updateOnboardingInfo(resp);
      }
    }
    catch(error) {
      print(error);
    }

    return null;
  }

  static Future<OrderDetailsInfo> GetOrderDetailsInfo(BuildContext context, String order_id, bool showLoading) async {

    http.Response response;
    try
    {
      String url = kBaseUrl2 + "customer_orders.php?order_id=${order_id}";
      //https://ayanenergyapps.com/management/api/exposeAPI/customer_orders.php?ledger_code=03040301168

      var uri = Uri.parse(url);
      final http.Response response = await http.get(uri);

      if (response.statusCode == 200) {

        print(response.body);
        List<OrderDetailsModel> listModel = [];

        final data = jsonDecode(response.body);





        OrderDetailsInfo fInfo = OrderDetailsInfo(orderDetailsInformation: listModel);

        return fInfo;
        //CustomerStorage().updateOnboardingInfo(resp);
      }
    }
    catch(error) {
      print(error);
    }

    return null;
  }

}

