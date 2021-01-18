import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pak_lpg/screens/myorder/myorder_screen.dart';
import 'package:pak_lpg/screens/order_now/components/body.dart';

class MAStaggeredGridView extends StatelessWidget {
  double tileTitleFontSize = 24.0;
  double tileNumberFontSize = 20.0;

  get CountTextStyle => TextStyle(
      color: Colors.blue,
      fontSize: tileNumberFontSize,
      fontWeight: FontWeight.w400);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double heightFactor = 3.7;
    double sizedBoxHeight = size.height * .01;
    return StaggeredGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 12.0,
        mainAxisSpacing: 12.0,
        padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
        children: <Widget>[
          Material(
              elevation: 10.0,
              borderRadius: BorderRadius.circular(12.0),
              shadowColor: Color(0x802196F3),
              child: InkWell(
                  // Do onTap() if it isn't null, otherwise do print()
                  onTap: () {
                    Navigator.push(
                      context,
                      //MaterialPageRoute(builder: (context) => ProductsScreen()),
                      MaterialPageRoute(builder: (context) => OrderNowScreen()),
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                                elevation: 10,
                                color: Colors.green,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.add_shopping_cart_outlined,
                                      color: Colors.white, size: 35.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text('Order Now',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)),
                            SizedBox(
                              height: sizedBoxHeight,
                            ),
                            //Text("150", style: CountTextStyle),
                          ])))),
          Material(
              elevation: 14.0,
              borderRadius: BorderRadius.circular(12.0),
              shadowColor: Color(0x802196F3),
              child: InkWell(
                  // Do onTap() if it isn't null, otherwise do print()
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => myOrderScreen()),
                    );
                  },
                  child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                                elevation: 10,
                                color: Colors.redAccent,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.payment,
                                      color: Colors.white, size: 35.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 16.0)),
                            Text('My Order',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)),
                            SizedBox(
                              height: sizedBoxHeight,
                            ),
                            //Text("1026", style: CountTextStyle),
                          ])))),
          Material(
              elevation: 14.0,
              borderRadius: BorderRadius.circular(12.0),
              shadowColor: Color(0x802196F3),
              child: InkWell(
                  // Do onTap() if it isn't null, otherwise do print()
                  onTap: () => {print('Not set yet')},
                  child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                                elevation: 10,
                                color: Colors.orangeAccent,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.monetization_on_outlined,
                                      color: Colors.white, size: 35.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 14.0)),
                            Text('Refer/Earn',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)),
                            SizedBox(
                              height: sizedBoxHeight,
                            ),
                            //Text("450", style: CountTextStyle),
                          ])))),
          Material(
              elevation: 14.0,
              borderRadius: BorderRadius.circular(12.0),
              shadowColor: Color(0x802196F3),
              child: InkWell(
                  // Do onTap() if it isn't null, otherwise do print()
                  onTap: () => {print('Not set yet')},
                  child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Material(
                                elevation: 10,
                                color: Colors.pinkAccent,
                                shape: CircleBorder(),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.money,
                                      color: Colors.white, size: 35.0),
                                )),
                            Padding(padding: EdgeInsets.only(bottom: 14.0)),
                            Text('LPG Price',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16)),
                            SizedBox(
                              height: sizedBoxHeight,
                            ),
                            //Text("10", style: CountTextStyle),
                          ])))),
          Material(
              elevation: 14.0,
              borderRadius: BorderRadius.circular(12.0),
              shadowColor: Color(0x802196F3),
              child: InkWell(
                  // Do onTap() if it isn't null, otherwise do print()
                  onTap: () => {print('Not set yet')},
                  child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //Text('Support',
                                //  style: TextStyle(color: Colors.blueAccent)),
                                Text("Support",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16))
                              ],
                            ),
                            Material(
                                elevation: 10,
                                color: Colors.lightBlueAccent,
                                borderRadius: BorderRadius.circular(24.0),
                                child: Center(
                                    child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Icon(Icons.support_agent_outlined,
                                      color: Colors.white, size: 35.0),
                                )))
                          ])))),
        ],
        staggeredTiles: [
          StaggeredTile.extent(1, size.height / heightFactor),
          StaggeredTile.extent(1, size.height / heightFactor),
          StaggeredTile.extent(1, size.height / heightFactor),
          StaggeredTile.extent(1, size.height / heightFactor),
          StaggeredTile.extent(2, size.height / 6.9),
        ]);
  }
}
