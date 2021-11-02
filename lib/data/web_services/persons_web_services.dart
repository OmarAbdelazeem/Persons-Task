import 'dart:convert';

import 'package:http/http.dart';

class PersonsWebServices {

  final baseUrl = "https://tekdi-challenges.appspot.com/api/People";

  Future<List<dynamic>> getPersons() async {
    try {
      final response = await get(Uri.parse(baseUrl));
      print(response.body);
      return jsonDecode(response.body) as List;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> patchPerson(Map<String, dynamic> patchObj, int id) async {
    try {
      await patch(Uri.parse(baseUrl + "/$id"), body: patchObj);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Map?> postPerson(Map<String, dynamic> personObj) async {
    try {
      final response = await post(Uri.parse(baseUrl), body: personObj);
      return jsonDecode(response.body);
    } catch (e) {
      return null;
    }
  }

  Future<bool> deletePerson(int id) async {
    try {
      await delete(Uri.parse(baseUrl + "/$id"));
      return true;
    } catch (er) {
      return false;
    }
  }

}
