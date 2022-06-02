import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/excuse.dart';

// Method to update the database and get the updated json. The system only works in put so we have to send the whole json.
Future<List<Excuse>> updateExcuses(List<Excuse> excuses) async {
  final response = await http.put(
      Uri.parse('https://api.jsonbin.io/b/6297b79b05f31f68b3b27f7a'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(excuses)); //
  final excuseList = jsonDecode(response.body)['data'];
  return List<Excuse>.from(excuseList.map((excuse) => Excuse.fromJson(excuse)));
}
