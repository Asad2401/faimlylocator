import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:pak_lpg_driver/http/driver_details.dart';

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

  String driverName;
  String driverCNIC;
  String driverCellNo;
  String driverERPId;
  String driverlicenseNo;
  String vehicleNumber;
  String _quantity;

  final key_vehicle_number = "vehicle_number";
  final key_driver_name = "driver_name";
  final key_driver_cnic = "driver_cnic";
  final key_driver_cell = "driver_cell";
  final key_driver_erp_id = "driver_erp_id";
  final key_driver_license_no = "driver_license_no";
  final key_trip_status = "trip_license_no";

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

  void updateOnboardingInfo(DriverDetails resp) {
    addNewItem(key_driver_cell, resp.driver.cell_no);
    addNewItem(key_driver_cnic, resp.driver.cnic_no);
    addNewItem(key_driver_erp_id, resp.driver.driver_erp_id);
    addNewItem(key_driver_license_no, resp.driver.licence_no);
    addNewItem(key_driver_name, resp.driver.name);
  }

  void updateVehicleNumber(String vehicleNumber) {
    addNewItem(key_vehicle_number, vehicleNumber);
  }

  void addQuantity(String quantity) {
    addNewItem(_quantity, quantity);
  }

  Future<String> getQuantity() async {
    try {
      return readWhereKey(_quantity);
    } catch (err) {
      return null;
    }
  }

  Future<String> getVehicleNumber() async {
    try {
      return readWhereKey(key_vehicle_number);
    } catch (err) {
      return null;
    }
  }

  Future<String> getDriverERPId() async {
    try {
      return readWhereKey(key_driver_erp_id);
    } catch (err) {
      return null;
    }
  }

  Future<String> getDriverName() async {
    try {
      return readWhereKey(key_driver_name);
    } catch (err) {
      return null;
    }
  }

  Future<String> getDriverCNIC() async {
    try {
      return readWhereKey(key_driver_cnic);
    } catch (err) {
      return null;
    }
  }

  Future<String> getDriverCellNo() async {
    try {
      return readWhereKey(key_driver_cell);
    } catch (err) {
      return null;
    }
  }

  Future<String> getDriverLicenseNo() async {
    try {
      return readWhereKey(key_driver_license_no);
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
