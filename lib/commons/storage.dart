import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:pak_lpg/models/customer_details.dart';
import 'dart:convert';


class Storage extends StorageBase {
  static final Storage _instance = Storage._internal();

  factory Storage() {
    return _instance;
  }

  Storage._internal() {
    _storage = FlutterSecureStorage();
  }
}

abstract class StorageBase {
  @protected
  FlutterSecureStorage _storage;

  final key_customer_id = "customer_id";
  final key_customer_name = "customer_name";
  final key_business_category = "business_category";
  final key_cnic = "cnic";
  final key_tax_type = "tax_type";
  final key_sales_tax_no = "sales_tax_no";
  final key_ntn_no = "ntn_no";
  final key_phone_no = "phone_no";
  final key_contact_person = "contact_person";
  final key_contact_phone = "contact_phone";
  final key_contact_phone_2 = "contact_phone_2";
  final key_city = "city";
  final key_market_person = "market_person";
  final key_district = "district";
  final key_privince = "privince";
  final key_email = "email";
  final key_address = "address";
  final key_registration_date = "registration_date";
  final key_password = "password";
  final key_count = "count";
  final key_total_quantity = "total_quantity";
  final key_total_contract_quantity = "total_contract_quantity";
  /////Order Details APIs data
  final key_ledger_code = "ledger_code";
  final key_ledger_desc = "ledger_desc";
  final key_p_tpye = "p_tpye";
  final key_pp_tpye = "pp_tpye";
  final key_transport_name = "transport_name";
  final key_site_name = "site_name";
  final key_vehicle_no = "vehicle_no";
  final key_freight = "freight";
  final key_contact_no = "contact_no";
  final key_quantity = "quantity";
  final key_load_date = "load_date";
  final key_contract_no = "contract_no";
  final key_allocation = "allocation";
  final key_allocation_date = "allocation_date";
  final key_trip_id = "trip_id";
  final Key_logistics_json = "Key_logistics_json";
  final key_support_number = "key_support_number";
  final key_cylinder_id = "key_cylinder_id";
  final key_cylinder_type = "key_cylinder_type";
  final key_cylinder_rate = "key_cylinder_rate";

  List<_SecItem> _items = [];

  void deleteAll() async {
    await _storage.deleteAll();
    readAll();
  }

  void addNewItem(String key, String value) async {
    await _storage.write(key: key, value: value);
    readAll();
  }

  Future writeSecureData(String status, String value) async {
    var writeData = await _storage.write(key: status, value: value);
    return writeData;
  }

  Future readSecureData(String status) async {
    var readData = await _storage.read(key: status);
    return readData;
  }

  Future<String> readWhereKey(String key) async {
    final keyValue = await _storage.read(key: key);
    return keyValue;
  }

  Future<List<_SecItem>> readAll() async {
    final all = await _storage.readAll();
    return _items =
        all.keys.map((key) => _SecItem(key, all[key])).toList(growable: false);
  }


  void updatepassword(String password) {
    addNewItem(key_password, password);
  }

  Future<String> getCylinderId() async {
    try {
      return readWhereKey(key_cylinder_id);
    } catch (err) {
      return null;
    }
  }

  Future<String> getCylinderType() async {
    try {
      return readWhereKey(key_cylinder_type);
    } catch (err) {
      return null;
    }
  }

  Future<String> getCylinderRate() async {
    try {
      return readWhereKey(key_cylinder_rate);
    } catch (err) {
      return null;
    }
  }

  Future<String> getpassword() async {
    try {
      return readWhereKey(key_password);
    } catch (err) {
      return null;
    }
  }

  Future<String> getCustomer_id() async {
    try {
      return readWhereKey(key_customer_id);
    } catch (err) {
      return null;
    }
  }

  Future<String> getCustomer_name() async {
    try {
      return readWhereKey(key_customer_name);
    } catch (err) {
      return null;
    }
  }

  Future<String> getBusiness_category() async {
    try {
      return readWhereKey(key_business_category);
    } catch (err) {
      return null;
    }
  }

  Future<String> getkey_cnic() async {
    try {
      return readWhereKey(key_cnic);
    } catch (err) {
      return null;
    }
  }

  Future<String> getTax_type() async {
    try {
      return readWhereKey(key_tax_type);
    } catch (err) {
      return null;
    }
  }

  Future<String> getSales_tax_no() async {
    try {
      return readWhereKey(key_sales_tax_no);
    } catch (err) {
      return null;
    }
  }

  Future<String> getNtn_no() async {
    try {
      return readWhereKey(key_ntn_no);
    } catch (err) {
      return null;
    }
  }

  Future<String> getPhone_no() async {
    try {
      return readWhereKey(key_phone_no);
    } catch (err) {
      return null;
    }
  }

  Future<String> getContact_person() async {
    try {
      return readWhereKey(key_contact_person);
    } catch (err) {
      return null;
    }
  }

  Future<String> getContact_phone() async {
    try {
      return readWhereKey(key_contact_phone);
    } catch (err) {
      return null;
    }
  }

  Future<String> getCity() async {
    try {
      return readWhereKey(key_city);
    } catch (err) {
      return null;
    }
  }

  Future<String> getContact_phone_2() async {
    try {
      return readWhereKey(key_contact_phone_2);
    } catch (err) {
      return null;
    }
  }

  Future<String> getMarket_person() async {
    try {
      return readWhereKey(key_market_person);
    } catch (err) {
      return null;
    }
  }

  Future<String> getDistrict() async {
    try {
      return readWhereKey(key_district);
    } catch (err) {
      return null;
    }
  }

  Future<String> getPrivince() async {
    try {
      return readWhereKey(key_privince);
    } catch (err) {
      return null;
    }
  }

  Future<String> getEmail() async {
    try {
      return readWhereKey(key_email);
    } catch (err) {
      return null;
    }
  }

  Future<String> getAddress() async {
    try {
      return readWhereKey(key_address);
    } catch (err) {
      return null;
    }
  }

  Future<String> getRegistration_date() async {
    try {
      return readWhereKey(key_registration_date);
    } catch (err) {
      return null;
    }
  }

  Future<String> getTotalCount() async {
    try {
      return readWhereKey(key_count);
    } catch (err) {
      return null;
    }
  }

  Future<String> getTotalQuantity() async {
    try {
      return readWhereKey(key_total_quantity);
    } catch (err) {
      return null;
    }
  }

  Future<String> getTotalContract() async {
    try {
      return readWhereKey(key_total_contract_quantity);
    } catch (err) {
      return null;
    }
  }

  Future<String> getLedger_code() async {
    try {
      return readWhereKey(key_ledger_code);
    } catch (err) {
      return null;
    }
  }

  Future<String> getLedger_desc() async {
    try {
      return readWhereKey(key_ledger_desc);
    } catch (err) {
      return null;
    }
  }

  Future<String> getP_tpye() async {
    try {
      return readWhereKey(key_p_tpye);
    } catch (err) {
      return null;
    }
  }

  Future<String> getPP_tpye() async {
    try {
      return readWhereKey(key_pp_tpye);
    } catch (err) {
      return null;
    }
  }

  Future<String> getTransport_name() async {
    try {
      return readWhereKey(key_transport_name);

    } catch (err) {
      return null;
    }
  }

  Future<String> getSite_name() async {
    try {
      return readWhereKey(key_site_name);
    } catch (err) {
      return null;
    }
  }

  Future<String> getVehicle_no() async {
    try {
      return readWhereKey(key_vehicle_no);
    } catch (err) {
      return null;
    }
  }

  Future<String> getFreight() async {
    try {
      return readWhereKey(key_freight);
    } catch (err) {
      return null;
    }
  }

  Future<String> getContact_no() async {
    try {
      return readWhereKey(key_contact_no);
    } catch (err) {
      return null;
    }
  }

  Future<String> getQuantity() async {
    try {
      return readWhereKey(key_quantity);
    } catch (err) {
      return null;
    }
  }

  Future<String> getLoad_date() async {
    try {
      return readWhereKey(key_load_date);
    } catch (err) {
      return null;
    }
  }

  Future<String> getContract_no() async {
    try {
      return readWhereKey(key_contract_no);
    } catch (err) {
      return null;
    }
  }

  Future<String> getAllocation() async {
    try {
      return readWhereKey(key_allocation);
    } catch (err) {
      return null;
    }
  }

  Future<String> getAllocation_date() async {
    try {
      return readWhereKey(key_allocation_date);
    } catch (err) {
      return null;
    }
  }

  Future<String> getsupport_number() async {
    try {
      return readWhereKey(key_support_number);
    } catch (err) {
      return null;
    }
  }

  Future<String> getTrip_id() async {
    try {
      return readWhereKey(key_trip_id);
    } catch (err) {
      return null;
    }
  }
}

class _SecItem {
  _SecItem(this.key, this.value);

  final String key;
  final String value;
}

