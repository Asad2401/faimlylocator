import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/models/product.dart';

import 'components/body.dart';

class OrderNow extends StatelessWidget {
  final double price;

  const OrderNow({Key key, this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPrimaryColor,

      appBar: buildAppBar(),

      // body: Body(
      //   //price: price,
      //
      //     ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      title: Text('Order Now'),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/notification.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}
