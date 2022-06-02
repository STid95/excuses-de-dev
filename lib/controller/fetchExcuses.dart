import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/excuse.dart';

// Method to fetch the json and return it as a list through parsing.
Future<List<Excuse>> fetchExcuses() async {
  final response = await http
      .get(Uri.parse('https://api.jsonbin.io/b/6297b79b05f31f68b3b27f7a'));
  Iterable list =
      json.decode(response.body); //convert response body into a list
  return List<Excuse>.from(list.map((excuse) =>
      Excuse.fromJson(excuse))); //Map the list in order to parse each entry
}
