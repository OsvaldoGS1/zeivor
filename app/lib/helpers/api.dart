import 'dart:convert';

import 'package:http/http.dart' as http;

// ignore: constant_identifier_names
enum Method { GET, POST, PUT, DELETE }

class ApiService {
  // final String baseUrl = 'http://localhost:3000/api';
  final String baseUrl = 'http://192.168.0.113:3000/api';
  // final String ruta = 'http://localhost:3000/';
  final String ruta = 'http://192.168.0.113:3000/';

  String? menssage;
  int? status;

  ApiService();

  Future<dynamic> fetchData(String endpoint,
      {Method method = Method.GET,
      Map<String, dynamic>? body,
      String? authorization}) async {
    http.Response response;
    final headers = {
      "Content-Type": "application/json",
    };

    Uri url;

    if (authorization != null) {
      String base = 'https://python.hank.mx/';
      url = Uri.parse('$base$endpoint');
      headers['Authorization'] = authorization;
    } else {
      url = Uri.parse('$baseUrl/$endpoint');
    }
    // print(url);

    switch (method) {
      case Method.GET:
        response = await http.get(url, headers: headers);
        break;
      case Method.POST:
        response =
            await http.post(url, headers: headers, body: jsonEncode(body));
        break;
      case Method.PUT:
        response =
            await http.put(url, headers: headers, body: jsonEncode(body));
        break;
      case Method.DELETE:
        response = await http.delete(url, headers: headers);
        break;
    }
    status = response.statusCode;
    return jsonDecode(response.body);
  }
}
