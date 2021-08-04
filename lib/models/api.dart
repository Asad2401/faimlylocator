import 'package:http/http.dart' as http;
import 'dart:convert';

Future loginUser(String email, String password) async {
  String url =
      "https://biitsolutions.co.uk/eccogas/eccogasapis/api/customer/login";
  final response = await http.post(url,
      headers: {"Accept": "Application/json"},
      body: {'email': email, 'password': password});
  var convertedDatatoJson = jsonDecode(response.body);
  return convertedDatatoJson;
}
