import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/models/customerModel.dart';
import 'package:pak_lpg/models/http_service.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pak_lpg/screens/myorder/components/orderDetail.dart';
import 'package:pak_lpg/screens/order_now/components/addAddressScreen.dart';
import 'package:pak_lpg/screens/order_now/components/confirmOrderScreen.dart';

class SetLocationScreen extends StatelessWidget {
  final HttpService httpService = HttpService();
  // final Product product;
  // const Body({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // it provide us total height and width
    Size size = MediaQuery.of(context).size;
    // it enable scrolling on small devices

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
            title: Text('Set Location'),
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
          body: Column(
            children: [
              FutureBuilder(
                future: httpService.getPosts(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<CustomerModel>> snapshot) {
                  if (snapshot.hasData) {
                    List<CustomerModel> posts = snapshot.data;

                    return Container(
                      margin: EdgeInsets.all(10),
                      height: 200,
                      width: 320,
                      padding: EdgeInsets.symmetric(
                        horizontal: kDefaultPadding * .1, // 30 padding
                        vertical: kDefaultPadding / 9, // 5 top and bottom
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white70,
                        boxShadow: [kDefaultShadow],
                      ),
                      // child: Container(
                      //   padding: EdgeInsets.symmetric(
                      //     horizontal: kDefaultPadding * 1.5, // 30 padding
                      //     vertical: kDefaultPadding / 1, // 5 top and bottom
                      //   ),

                      // height: 50,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(20),
                      //   color: kBackgroundColor,
                      //   boxShadow: [kDefaultShadow],
                      // ),
                      child: ListView(
                        children: posts
                            .map(
                              (CustomerModel customerModel) => ListTile(
                                title: Text(customerModel.userName),
                                subtitle: Text(
                                  customerModel.orderDate.toString(),
                                ),
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => OrderDetail(
                                    customer: customerModel,
                                  ),
                                )),
                              ),
                            )
                            .toList(),
                      ),
                    );
                  }

                  return CircularProgressIndicator();
                },
              ),
              // Container(
              //   //alignment: Alignment.topRight,
              //   padding: EdgeInsets.only(left: 150, right: 5),
              //   height: 30.0,
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(
              //             builder: (context) => SetLocationScreen()),
              //       );
              //     },
              //     child: Container(
              //       width: 120,
              //       decoration: BoxDecoration(
              //         border: Border.all(
              //           color: Colors.grey,
              //           style: BorderStyle.solid,
              //           width: 2.0,
              //         ),
              //         color: Colors.white70,
              //         borderRadius: BorderRadius.circular(30.0),
              //       ),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.center,
              //         children: <Widget>[
              //           Center(
              //             child: Text(
              //               "Edit Address",
              //               style: TextStyle(
              //                 color: Colors.black,
              //                 fontFamily: 'Montserrat',
              //                 fontSize: 12,
              //                 fontWeight: FontWeight.w600,
              //                 letterSpacing: 1,
              //               ),
              //             ),
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
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
                          builder: (context) => AddAddressScreen()),
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
                            "ADD ADDRESS",
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
              SizedBox(height: 8),
              Container(
                alignment: Alignment.center,
                //padding: EdgeInsets.only(left: 170, right: 5),
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
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
                            "CONTINUE",
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
      ),
    );
  }
}

// Future<CustomerModel> getCustomer() async {
//   final url = "https://eccogas.biitsolutions.co.uk/api/customer/order/1";
//   final response = await http.get(url);
//
//   if (response.statusCode == 200) {
//     print(response.body);
//     List<dynamic> jsonCustomer = jsonDecode(response.body);
//     return CustomerModel.fromJson(jsonCustomer[0]);
//   } else {
//     throw Exception();
//   }
// }
//////////extra-code/////
// body: Center(
// child: FutureBuilder<CustomerModel>(
// future: getCustomer(),
// builder: (context, snapshot) {
// if (snapshot.hasData) {
// final customer = snapshot.data;
//
// return Text(
// "Name :, ${customer.userName} \n Skill : ${customer.itemName}");
// } else if (snapshot.hasError) {
// return Text(snapshot.error.toString());
// }
//
// return CircularProgressIndicator();
// },
// ),
// ),
