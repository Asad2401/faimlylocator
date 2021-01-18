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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/111.png"), fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              title: Text(customer.Id.toString()),
              centerTitle: true,
              leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  }),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
              onPressed: () async {
                await httpService.deletePost(customer.userId);
                Navigator.of(context).pop();
              },
            ),
            body: SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.all(20.0),
                margin: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  border: Border.all(
                    color: Colors.grey,
                    style: BorderStyle.solid,
                    width: 2.0,
                  ),
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Order ID:     " + customer.Id.toString(),
                          style: TextStyle(
                            color: Colors.white,
                            //fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(3.0),
                          ),
                          child: Text("Assigned"),
                        )
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Name:         " + customer.userName,
                          style: TextStyle(
                            color: Colors.black,
                            //fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        // Padding(
                        //   padding: const EdgeInsets.all(12.0),
                        //   child: Card(
                        //     elevation: 10,
                        //     child: Column(
                        //       children: <Widget>[
                        //         ListTile(
                        //           title: Text("ID"),
                        //           subtitle: Text("${customer.Id}"),
                        //         ),
                        //         ListTile(
                        //           title: Text("Name"),
                        //           subtitle: Text("${customer.userName}"),
                        //         ),
                        //         ListTile(
                        //           title: Text("Order Date"),
                        //           subtitle: Text("${customer.orderDate}"),
                        //         ),
                        //         ListTile(
                        //           title: Text("Delivery Address"),
                        //           subtitle: Text("${customer.deliveryAddress}"),
                        //         ),
                        //         ListTile(
                        //           title: Text("Cylinder Type"),
                        //           subtitle: Text("${customer.itemName}"),
                        //         ),
                        //         ListTile(
                        //           title: Text("Quantity"),
                        //           subtitle: Text("${customer.Qty}"),
                        //         ),
                        //         ListTile(
                        //           title: Text("Unit Price"),
                        //           subtitle: Text("${customer.salePrice}"),
                        //         ),
                        //         ListTile(
                        //           title: Text("Total Amount"),
                        //           subtitle: Text("${customer.totalamount}"),
                        //         ),
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Address:     " + customer.deliveryAddress,
                          style: TextStyle(
                            color: Colors.black,
                            //fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Date:           " + customer.orderDate,
                          style: TextStyle(
                            color: Colors.black,
                            //fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 2,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Cylinder Type:     " + customer.itemName,
                          style: TextStyle(
                            color: Colors.black,
                            //fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity:        " + customer.Qty.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            //fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Unit Price:     " + customer.salePrice.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            //fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Tax(5.00%):   " + customer.taxAmt.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            //fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 10,
                      thickness: 1,
                      color: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Price:    " + customer.totalamount.toString(),
                          style: TextStyle(
                            color: Colors.black,
                            //fontFamily: 'Montserrat',
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
