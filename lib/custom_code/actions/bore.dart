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

Future<dynamic> bore() async {
  var url = Uri.parse(
      'https://api.thingspeak.com/channels/1893786/feeds.json?api_key=QU3TXDEH144KI4WZ&results=1');
  var res = await http.get(url);
  var jdata = json.decode(res.body);
  var jbody = jdata["feeds"][0]["field1"];
  return jbody;
}
