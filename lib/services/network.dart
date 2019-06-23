import 'package:http/http.dart' as http ;
import 'dart:convert';

class NetworkModel {
  NetworkModel({this.url});
  String url;

  Future<dynamic> getData() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedjson = jsonDecode(response.body);
      return decodedjson;
    } else {
      return response.statusCode;
    }
  }
}
