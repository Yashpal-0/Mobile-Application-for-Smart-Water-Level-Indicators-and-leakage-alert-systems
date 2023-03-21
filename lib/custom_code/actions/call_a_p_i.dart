// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom action code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:http/http.dart' as http;
import 'dart:convert';

Future<dynamic> callAPI(
  String channelID,
  String readAPI,
) async {
  String str1 = '/channels/';
  String str2 = '/feeds.json?api_key=';
  String str3 = '&results=1';
  String str = str1 + channelID + str2 + readAPI + str3;
  String thingspeak = 'https://api.thingspeak.com/';
  var url = Uri.parse(thingspeak + str);
  var res = await http.get(url);
  var jdata = json.decode(res.body);
  var obj = jdata["feeds"][0]["field6"];
  try {
    var ans = double.tryParse(obj);
    return ans;
  } catch (e) {
    return 0.0;
  }
}
