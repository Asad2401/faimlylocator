import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pak_lpg/Dashboard/DashboardScreen.dart';
import 'package:pak_lpg/commons/storage.dart';

import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/commons/utils.dart';
import 'package:pak_lpg/localization/language_constants.dart';

class CustomerAddress {
  String id;
  String ledger_code;
  String address_1;
  String address_2;
  String country;
  String state;
  String city;
  String zip_code;


  CustomerAddress(
      {this.id,
      this.ledger_code,
      this.address_1,
      this.address_2,
      this.country,
      this.state,
      this.city,
      this.zip_code});

  factory CustomerAddress.fromJson(Map<String, dynamic> json) {
    if (json == null || json.length <= 0) {
      return CustomerAddress();
    }

    return CustomerAddress(
        id: json["id"]== null ? "" : json['id'],
        ledger_code: json["ledger_code"]== null ? "" : json['ledger_code'],
        address_1: json["address_1"]== null ? "" : json['address_1'],
        address_2: json["address_2"]== null ? "" : json['address_2'],
        country: json["country"]== null ? "" : json['country'],
        state: json["state"]== null ? "" : json['state'],
        city: json["city"]== null ? "" : json['city'],
        zip_code: json["zip_code"]== null ? "" : json['zip_code'],

    );
  }
}

class CustomerAddressDetails {
  String code;
  final String message;
  List<CustomerAddress> customerAddress;

  CustomerAddressDetails({this.code, this.customerAddress, this.message});

  factory CustomerAddressDetails.fromJson(Map<String, dynamic> json) {
    try {
      var data = (json['data'] as List)
          .map((i) => CustomerAddress.fromJson(i))
          .toList();
      if (data != null) {
        return CustomerAddressDetails(
          code: json['code'] == null ? 0 : json['code'],
          message: json['message'] == null ? "" : json['message'],
          customerAddress: data,
        );
      } else {
        return CustomerAddressDetails(
          code: json['code'] == null ? 0 : json['code'],
          message: json['message'] == null ? "" : json['message'],
          customerAddress: [],
        );
      }
    } catch (error) {
      return CustomerAddressDetails(
        code: json['code'] == null ? "" : json['code'],
        message: json['message'] == null ? "" : json['message'],
        customerAddress: [],
      );
    }
  }

  static Future<List<CustomerAddress>> request(
      BuildContext context, String ledgercode, bool showLoading) async {
    String get_key_url =
        base_url + "get_customer_site_location.php?ledger_code=${ledgercode}";
    // http://ayanenergyapps.com/management/api/exposeAPI/customer_deliveryorder.php?customer_id=03040301225

   // http.Response response;
    try {
      final GlobalKey<State> _keyLoader = new GlobalKey<State>();

      if (showLoading) utils.showLoadingDialog(context, _keyLoader);

      final http.Response response = await http.get(get_key_url);
      print("email,${get_key_url}");
      if (showLoading)
        Navigator.of(_keyLoader.currentContext, rootNavigator: true).pop();


      if (response.statusCode == 200) {
        CustomerAddressDetails resp =
        CustomerAddressDetails.fromJson(json.decode(response.body));
        print(response.statusCode);
        print(response.body);

        if (resp.code == 100) {
          utils.showDialogCustom(
              context,
              "Failed",
              resp.message.length == 0 ? "record not found" : resp.message,
              "OK");
          return [];
        }
        return resp.customerAddress;

      }
    } catch (error) {
      Future.delayed(Duration.zero, () => utils.dataSuccessfullyLoaded(context, getTranslated(context, 'Not_Found'),getTranslated(context, 'Data_Not_Found'),getTranslated(context, 'OK')));
      return [];
    }
  }
}
