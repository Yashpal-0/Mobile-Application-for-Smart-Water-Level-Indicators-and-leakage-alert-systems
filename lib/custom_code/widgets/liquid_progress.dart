// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';

class LiquidProgress extends StatefulWidget {
  const LiquidProgress({
    Key? key,
    this.width,
    this.height,
    this.param = 0.25,
  }) : super(key: key);

  final double? width;
  final double? height;
  final double param;

  @override
  _LiquidProgressState createState() => _LiquidProgressState();
}

class _LiquidProgressState extends State<LiquidProgress> {
  @override
  Widget build(BuildContext context) {
    return LiquidLinearProgressIndicator(
      value: widget.param,
      valueColor: AlwaysStoppedAnimation(Colors.cyan),
      backgroundColor: Colors.black,
      borderColor: Colors.white,
      borderWidth: 5.0,
      borderRadius: 30.0,
      direction: Axis.vertical,
    );
  }
}
