import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pak_lpg/Dashboard/DashboardScreen.dart';
import 'package:pak_lpg/commons/round_button.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/models/product.dart';
import 'package:pak_lpg/screens/order_now/components/confirmOrderScreen.dart';
import 'package:pak_lpg/screens/order_now/components/setLocationScreen.dart';

/// This Widget is the main application widget.
// class Body extends StatelessWidget {
//   final Product product;
//
//   Body({Key key, this.product}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: OrderNowPage(),
//       ),
//     );
//   }
// }
class OrderNowScreen extends StatefulWidget {
  // double price, tax, amount;
  // int quantity;

  // OrderNowScreen({Key key, this.price, this.tax, this.amount, this.quantity})
  //     : super(key: key);
  @override
  _OrderNowScreenState createState() => _OrderNowScreenState();
}

class _OrderNowScreenState extends State<OrderNowScreen> {
  bool kg11 = false;
  bool kg22 = false;
  bool kg44 = false;
  int quantity = 1;
  String stype = "";
  double price = 0;
  double tax = 0;

  //double _tax = _price / 0.05;
  // double amount = _price * _quantity;
  bool exitPage = false;

  @override
  void initState() {
    exitPage = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //orderNowScreen.price = 0;

    tax = (price * quantity) * 0.05;
    double amount = (price * quantity) + tax;
    //String stype = "";
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
            title: Text('Order Now'),
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
          body: SingleChildScrollView(
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: 5),
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    color: Colors.transparent,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(bottom: 10),
                          child: Text(
                            'Choose Product',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              kg11 = true;
                              kg22 = false;
                              kg44 = false;
                              price = 70;
                              stype = "Small";
                            });
                          },
                          child: Container(
                            // color: kg11 ? Colors.red : null,
                            height: 50,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: Colors.grey),
                            ),

                            // elevation: 0,
                            child: Container(
                              // color: Colors.transparent,
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Small:        11KG',
                                    style: TextStyle(
                                      color: kg11 ? Colors.white : null,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'AED 70',
                                    style: TextStyle(
                                        color: kg11 ? Colors.white : null,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            setState(() {
                              kg11 = false;
                              kg22 = true;
                              kg44 = false;
                              price = 100;
                              stype = "Medium";
                            });
                          },
                          child: Container(
                            // color: kg22 ? Colors.blue : null,
                            // elevation: 0,
                            height: 50,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Medium:    22KG',
                                    style: TextStyle(
                                      color: kg22 ? Colors.white : null,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'AED 100',
                                    style: TextStyle(
                                        color: kg22 ? Colors.white : null,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        InkWell(
                          onTap: () {
                            setState(() {
                              kg11 = false;
                              kg22 = false;
                              kg44 = true;
                              price = 190;
                              stype = "Large";
                            });
                          },
                          child: Container(
                            // color: kg44 ? Colors.blue : null,
                            // elevation: 0,
                            height: 50,
                            padding: EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    'Large:        44KG',
                                    style: TextStyle(
                                      color: kg44 ? Colors.white : null,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'AED 190',
                                    style: TextStyle(
                                        color: kg44 ? Colors.white : null,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              '      *Price are for LPG refills',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 12,
                                //fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
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
                                  'Quantity',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                height: 50,
                                padding: EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25.0),
                                  border: Border.all(color: Colors.grey),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Container(
                                      width: 40,
                                      margin: EdgeInsets.only(right: 10),
                                      child: new FloatingActionButton(
                                        onPressed: minusQuantity,
                                        child: new Icon(
                                          Icons.remove,
                                          color: Colors.black,
                                        ),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                    new Text('$quantity',
                                        style: new TextStyle(fontSize: 20.0)),
                                    Container(
                                      width: 40,
                                      margin: EdgeInsets.only(left: 10),
                                      child: new FloatingActionButton(
                                        heroTag: 'btn2',
                                        onPressed: addQuantity,
                                        child: new Icon(
                                          Icons.add,
                                          color: Colors.black,
                                        ),
                                        //   const IconData(0xe15b,
                                        //       fontFamily: 'MaterialIcons'),
                                        //   color: Colors.black,
                                        // ),
                                        backgroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: kDefaultPadding),
                        Container(
                          alignment: Alignment.bottomRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text(
                                "Unit Price: AED   ${price} ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  // color: kSecondaryColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "VAT (5.00%): AED   $tax",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  // color: kSecondaryColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Amount: AED   $amount ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  // color: kSecondaryColor,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Due Amount: AED   $amount ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: kSecondaryColor,
                                ),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintStyle: TextStyle(fontSize: 17),
                              hintText: 'Special Instructions, if any',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.all(25),
                            ),
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "Your order will be assigned to the nearest delivery vehicle in your area.",
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "You Can track the delivery vehicle in map real-time once the driver starts your delivery.",
                          style: TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(left: 170, right: 5),
                    height: 50.0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ConfirmOrderScreen(
                                price: price,
                                amount: amount,
                                quantity: quantity,
                                tax: tax,
                                stype: stype)));
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => SetLocationScreen()));
                      },
                      child: Container(
                        width: 180,
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
                  )
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
      ),
    );
  }

  void minusQuantity() {
    setState(() {
      if (quantity != 1) quantity--;
    });
  }

  void addQuantity() {
    setState(() {
      quantity++;
    });
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
}
