//Import Statements
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

Future<List> fetchLaunch() async {
  /**
   * Asyn func that grabs next 5 launches from API
   * Preprocesses to convert to a list of Maps<String, Dynamic>
   */

  String apiReq = 'https://fdo.rocketlaunch.live/json/launches/next/5';   //API to request
  final response = await http.get(apiReq);                                //Send get request
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse and return the JSON.
    return jsonDecode(response.body)['result'];
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Launch');
  }
}


