import 'package:flutter/material.dart';
import 'package:pak_lpg/models/customerModel.dart';
import 'package:pak_lpg/models/http_service.dart';

import '../../../constants.dart';

class OrderDetail extends StatelessWidget {
  final CustomerModel customer;
  final HttpService httpService = HttpService();

  OrderDetail({this.customer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text(customer.userName),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          await httpService.deletePost(customer.userId);
          Navigator.of(context).pop();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            elevation: 10,
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text("ID"),
                  subtitle: Text("${customer.userId}"),
                ),
                ListTile(
                  title: Text("Name"),
                  subtitle: Text("${customer.userName}"),
                ),
                ListTile(
                  title: Text("Order Date"),
                  subtitle: Text("${customer.orderDate}"),
                ),
                ListTile(
                  title: Text("Delivery Address"),
                  subtitle: Text("${customer.deliveryAddress}"),
                ),
                ListTile(
                  title: Text("Cylinder Type"),
                  subtitle: Text("${customer.itemName}"),
                ),
                ListTile(
                  title: Text("Quantity"),
                  subtitle: Text("${customer.Qty}"),
                ),
                ListTile(
                  title: Text("Unit Price"),
                  subtitle: Text("${customer.salePrice}"),
                ),
                ListTile(
                  title: Text("Total Amount"),
                  subtitle: Text("${customer.totalamount}"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
