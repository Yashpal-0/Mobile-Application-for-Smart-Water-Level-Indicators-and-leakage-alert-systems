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

String generateChannelID(String key) {
  return key.split("&").first;
}

String generateReadAPI(String key) {
  return key.split("&").elementAt(1);
}

Future<dynamic> newCustomAction(List<String> keys) async {
  String str1 = '/channels/';
  String str2 = '/fields/1&6.json?api_key=';
  String str3 = '&results=1';
  String FinalString = "{\"tanks\"" + ":[";

  String thingspeak = 'https://api.thingspeak.com/';
  for (int i = 0; i < keys.length; i++) {
    String ChannelID = generateChannelID(keys[i]);
    String ReadAPI = generateReadAPI(keys[i]);
    String str = str1 + ChannelID + str2 + ReadAPI + str3;
    String str10 = "https://api.thingspeak.com/channels/" +
        ChannelID +
        "/fields/1/last.json?api_key=" +
        ReadAPI;

    var url = Uri.parse(thingspeak + str);
    var response = await http.get(url);
    var jdata = json.decode(response.body);
    var waterLevel = jdata["feeds"][0]["field6"];

    var url2 = Uri.parse(str10);
    var response2 = await http.get(url2);
    var jdata2 = json.decode(response2.body);
    var tankName = jdata2["field1"];

    var String2 = "{\"TankName\":" +
        "\"" +
        tankName +
        "\"" +
        ", \"WaterLevel\":" +
        "\"" +
        waterLevel +
        "\"" +
        "}";
    if (i == keys.length - 1) {
      FinalString += String2;
    } else {
      FinalString += String2 + ",";
    }
  }
  FinalString += "]}";
  var mapObject = json.decode(FinalString);

  return mapObject;
}
