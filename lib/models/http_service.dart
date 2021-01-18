import 'dart:convert';

import 'package:http/http.dart';
import 'package:pak_lpg/models/customerModel.dart';
import 'dart:convert';

class HttpService {
  final String postsUrl =
      "https://eccogas.biitsolutions.co.uk/api/customer/order/11";

  Future<void> deletePost(int id) async {
    Response res = await delete("$postsUrl/$id");

    if (res.statusCode == 200) {
      print("Deleted");
    }
  }

  Future<List<CustomerModel>> getPosts() async {
    Response res = await get(postsUrl);

    if (res.statusCode == 200) {
      List<dynamic> body = jsonDecode(res.body);

      List<CustomerModel> posts =
          body.map((dynamic item) => CustomerModel.fromJson(item)).toList();
      return posts;
    } else {
      throw "Can't get posts";
    }
  }
}
