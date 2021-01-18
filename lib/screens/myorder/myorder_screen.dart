import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pak_lpg/constants.dart';
import 'package:pak_lpg/models/product.dart';

import 'components/body.dart';

class myOrderScreen extends StatelessWidget {
  final Product product;

  const myOrderScreen({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: kPrimaryColor,
      //appBar: buildAppBar(),
      body: Body(
          //product: product,
          ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      elevation: 0,
      centerTitle: false,
      title: Text('My Order'),
      actions: <Widget>[
        IconButton(
          icon: SvgPicture.asset("assets/icons/notification.svg"),
          onPressed: () {},
        ),
      ],
    );
  }
}
