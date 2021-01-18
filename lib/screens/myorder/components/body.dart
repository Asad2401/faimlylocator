import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/models/customerModel.dart';
import 'package:pak_lpg/models/http_service.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:pak_lpg/screens/myorder/components/orderDetail.dart';

class Body extends StatelessWidget {
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
            title: Text('My Orders'),
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
          body: FutureBuilder(
            future: httpService.getPosts(),
            builder: (BuildContext context,
                AsyncSnapshot<List<CustomerModel>> snapshot) {
              if (snapshot.hasData) {
                List<CustomerModel> posts = snapshot.data;
                return ListView(
                  children: posts
                      .map(
                        (CustomerModel customerModel) => Container(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Order ID:     " +
                                        customerModel.Id.toString(),
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
                                    child: Text(
                                      "Assigned",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'Montserrat',
                                        //fontSize: 16,
                                        //fontWeight: FontWeight.w600,
                                      ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Date:     " + customerModel.orderDate,
                                    style: TextStyle(
                                      color: Colors.black,
                                      //fontFamily: 'Montserrat',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      onTap: () => Navigator.of(context)
                                          .push(MaterialPageRoute(
                                        builder: (context) => OrderDetail(
                                          customer: customerModel,
                                        ),
                                      )),
                                      child: Container(
                                        child: Icon(
                                          Icons.arrow_forward_ios_rounded,
                                          color: Colors.grey,
                                          size: 25.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                );
              }
              return CircularProgressIndicator();
            },
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
