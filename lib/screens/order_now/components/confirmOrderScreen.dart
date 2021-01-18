import 'package:flutter/material.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/models/product.dart';
import 'package:pak_lpg/screens/myorder/myorder_screen.dart';
import 'package:pak_lpg/screens/order_now/components/body.dart';
import 'package:pak_lpg/screens/order_now/components/setLocationScreen.dart';

import 'package:pak_lpg/models/customerModel.dart';
import 'package:pak_lpg/models/http_service.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pak_lpg/screens/myorder/components/orderDetail.dart';

class ConfirmOrderScreen extends StatefulWidget {
  CustomerModel customerModel;
  double price, amount, tax;
  int quantity;
  String stype;
  ConfirmOrderScreen(
      {Key key,
      this.price,
      this.amount,
      this.tax,
      this.quantity,
      this.stype,
      this.customerModel})
      : super(key: key);
  @override
  _ConfirmOrderScreenState createState() => _ConfirmOrderScreenState(
      price, amount, tax, quantity, stype, customerModel);
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  final HttpService httpService = HttpService();
  CustomerModel customerModel;
  double price, amount, tax;
  int quantity;
  String stype;
  _ConfirmOrderScreenState(this.price, this.amount, this.tax, this.quantity,
      this.stype, this.customerModel);
  bool online = false;
  bool cash = false;

  bool exitPage = false;
  @override
  void initState() {
    exitPage = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      exitPage ? Navigator.pop(context, true) : exitPage = false;
    });
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
            title: Text('Confirm Your Order'),
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
          body: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  //margin: EdgeInsets.only(top: 5),
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Please Select Payment Type',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                online = true;
                                cash = false;

                                // _price = 70;
                              });
                            },
                            child: Container(
                              width: 140,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "Online",
                                      style: TextStyle(
                                        color: online ? Colors.white : null,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 20),
                          InkWell(
                            onTap: () {
                              setState(() {
                                online = false;
                                cash = true;

                                // _price = 100;
                              });
                            },
                            child: Container(
                              width: 140,
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                  style: BorderStyle.solid,
                                  width: 2.0,
                                ),
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Center(
                                    child: Text(
                                      "Cash",
                                      style: TextStyle(
                                        color: cash ? Colors.white : null,
                                        fontFamily: 'Montserrat',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                'Your Order',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4),
                      Container(
                        //alignment: Alignment.topRight,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Quantity",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 96),
                            Text(
                              "${quantity}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 4),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Cylinder Type",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 58),
                            Text(
                              "${stype}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Unit Price:        AED",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 18),
                            Text(
                              "${price}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 4),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        //alignment: Alignment.centerLeft,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "VAT (5.00%):   AED",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              "${tax}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 6),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Amount:           AED",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              "${amount}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Text(
                              "Due Amount:   AED",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 20),
                            Text(
                              "${amount}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: kSecondaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        //alignment: Alignment.topRight,
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                // color: kSecondaryColor,
                              ),
                            ),
                            SizedBox(width: 140),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => OrderNowScreen()),
                                );
                              },
                              child: Container(
                                width: 100,
                                height: 35,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey,
                                    style: BorderStyle.solid,
                                    width: 2.0,
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Center(
                                      child: Text(
                                        "Change",
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'Montserrat',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        color: Colors.transparent,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              // margin: EdgeInsets.only(bottom: 10),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: Text(
                                '  Address',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      FutureBuilder(
                        future: httpService.getPosts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<List<CustomerModel>> snapshot) {
                          if (snapshot.hasData) {
                            List<CustomerModel> posts = snapshot.data;

                            return Container(
                              margin: EdgeInsets.all(10),
                              height: 120,
                              width: 320,
                              padding: EdgeInsets.symmetric(
                                horizontal: kDefaultPadding * .1, // 30 padding
                                vertical:
                                    kDefaultPadding / 9, // 5 top and bottom
                              ),
                              child: Text(posts[0].deliveryAddress),
                              // child: Column(
                              //   children: posts
                              //       .map(
                              //         (CustomerModel customerModel) =>
                              //             Container(
                              //           height: 120,
                              //           width: 320,
                              //           decoration: BoxDecoration(
                              //             borderRadius:
                              //                 BorderRadius.circular(10),
                              //             color: Colors.white70,
                              //             boxShadow: [kDefaultShadow],
                              //           ),
                              //           child:
                              //               Text(customerModel.deliveryAddress),
                              //         ),
                              //       )
                              //       .toList(),
                              // ),
                            );
                          }

                          return CircularProgressIndicator();
                        },
                      ),
                      // Container(
                      //   height: 120,
                      //   width: 320,
                      //   decoration: BoxDecoration(
                      //     borderRadius: BorderRadius.circular(10),
                      //     color: Colors.white70,
                      //     boxShadow: [kDefaultShadow],
                      //   ),
                      //   child: Text(customerModel.deliveryAddress),
                      // ),
                      Container(
                        alignment: Alignment.center,
                        //padding: EdgeInsets.only(left: 170, right: 5),
                        height: 50.0,
                        child: GestureDetector(
                          onTap: () {
                            // submitData();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => myOrderScreen()),
                            );
                          },
                          child: Container(
                            width: 280,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 2.0,
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    "BOOK NOW",
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        alignment: Alignment.center,
                        //padding: EdgeInsets.only(left: 170, right: 5),
                        height: 50.0,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SetLocationScreen()),
                            );
                          },
                          child: Container(
                            width: 280,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                style: BorderStyle.solid,
                                width: 2.0,
                              ),
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Center(
                                  child: Text(
                                    "UPDATE ADDRESS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // RoundedButton(
                //   text: "Continue",
                //   press: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) {
                //           return DashboardScreen();
                //         },
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void submitData() {
    String myUrl =
        "https://eccogas.biitsolutions.co.uk/api/customer/order/create";
    http
        .post(myUrl,
            body: ({
              "user_id": "11",
              "user_name": "asad",
              "warehouse_id": "21",
              "item_id": "1",
              "item_name": stype,
              "qty": quantity.toString(),
              "sale_price": price.toString(),
              "tax_amt": tax.toString(),
              "total_amount": amount.toString(),
              "unit": "blue",
              "driver_id": "31",
              "delivery_address": "sector-blue",
              "location": "1",
            }))
        .then((response) => print(response.statusCode));
  }
}

// messageAllert(String msg, String ttl) {
//   showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return new CupertinoAlertDialog(
//           title: Text(ttl),
//           content: Text(msg),
//           actions: [
//             CupertinoDialogAction(
//               isDefaultAction: true,
//               child: Column(
//                 children: <Widget>[
//                   Text('Okay'),
//                 ],
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//             ),
//           ],
//         );
//       });
// }
