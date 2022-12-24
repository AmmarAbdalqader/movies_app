import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:movies_app/Helpers/Requests/API_Key.dart';

class HTTP {
  static Future<http.Response> get(String url, String addOn) async {
    url = mainURL + url + "/$api_key";

    if (addOn != "") {
      url += "/$addOn";
    }

    log(url);

    final response = await http.get(Uri.parse(url));
    log(response.statusCode.toString());

    return response;
  }
}
