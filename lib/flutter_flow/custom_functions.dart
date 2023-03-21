import 'dart:convert';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'lat_lng.dart';
import 'place.dart';
import '../backend/backend.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../auth/auth_util.dart';

bool qr(String? qrString) {
  String str = qrString ?? "";
  if (str == "") {
    return false;
  } else {
    return true;
  }
}

String generateChannelID(String key) {
  return key.split("&").first;
}

String generateReadAPI(String key) {
  return key.split("&").elementAt(1);
}

String generateWrite(String key) {
  return key.split("&").last;
}

String graph(String? channel) {
  channel = channel ?? "NA";
  if (channel == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/charts/6?api_key=";
    String d =
        "&width=auto&height=auto&bgcolor=000000&color=32e6ee&dynamic=true&results=100&type=line&update=15";

    return a +
        channel.split("&").first +
        c +
        channel.split("&").elementAt(1) +
        d;
  }
}

String isCuboid(bool isC) {
  if (isC == true) {
    return "Cuboid";
  } else {
    return "Cylinder";
  }
}

double calculateVolume(
  bool isCuboid,
  String length,
  String breadth,
  String height,
  String radius,
) {
  if (isCuboid == true) {
    double? a = double.tryParse(length);
    double? b = double.tryParse(breadth);
    double? c = double.tryParse(height);

    a = a ?? 0;
    b = b ?? 0;
    c = c ?? 0;
    double vol = a * b * c / 1000;
    return double.parse(vol.toStringAsFixed(2));
  } else {
    double? a = double.tryParse(height);
    double? b = double.tryParse(radius);

    a = a ?? 0;
    b = b ?? 0;
    double vol = 3.14159 * a * b * b / 1000;
    return double.parse(vol.toStringAsFixed(2));
  }
}

double tankAPI(
  double? waterVolume,
  double? capacity,
) {
  waterVolume = waterVolume ?? 0;
  capacity = capacity ?? 0;
  if (capacity == 0) {
    return 0;
  }
  return waterVolume / capacity;
}

double calculateWaterAvailable(
  String length,
  String breadth,
  String height,
  String radius,
  double? waterLevel,
  bool isCuboid,
) {
  double? length_ = double.tryParse(length);
  double? breadth_ = double.tryParse(breadth);
  double? height_ = double.tryParse(height);
  double? radius_ = double.tryParse(radius);
  waterLevel = waterLevel ?? -1;
  if (waterLevel == -1) {
    return 0;
  }

  length_ = length_ ?? 0;
  breadth_ = breadth_ ?? 0;
  height_ = height_ ?? 0;
  radius_ = radius_ ?? 0;

  if (isCuboid) {
    double vol = length_ * breadth_ * (height_ - waterLevel) / 1000;
    return double.parse(vol.toStringAsFixed(2));
  } else {
    double vol2 = 3.14159 * radius_ * radius_ * (height_ - waterLevel) / 1000;
    return double.parse(vol2.toStringAsFixed(2));
  }
}

int convertToInt(double? input) {
  input = input ?? 0;
  input = input * 100;
  return input.toInt();
}

double? stringToDouble(String str) {
  return double.tryParse(str);
}

String? cardBackground(double percentage) {
  if (percentage < 100 && percentage > 65) {
    return "https://i.postimg.cc/3xKRcNDh/full-tank-card2.jpg";
  } else if (percentage < 65 && percentage > 35) {
    return "https://i.postimg.cc/021r7ckb/half-tank-card2.jpg";
  } else {
    return "https://i.postimg.cc/m23kjCkV/quartertank-card1.jpg";
  }
}

String? boreWell(String? channel) {
  channel = channel ?? "NA";
  if (channel == "NA") {
    return "https://thingspeak.com/";
  } else {
    String a = "https://thingspeak.com/channels/";
    String c = "/charts/1?api_key=";
    String d =
        "&width=auto&height=auto&bgcolor=000000&color=32e6ee&dynamic=true&results=100&type=line&update=15";

    return a +
        channel.split("&").first +
        c +
        channel.split("&").elementAt(1) +
        d;
  }
}
