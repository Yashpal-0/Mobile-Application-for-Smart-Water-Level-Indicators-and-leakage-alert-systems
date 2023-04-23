import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogInSignUpModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for LogInEmail widget.
  TextEditingController? logInEmailController;
  String? Function(BuildContext, String?)? logInEmailControllerValidator;
  // State field(s) for LogInPassword widget.
  TextEditingController? logInPasswordController;
  late bool logInPasswordVisibility;
  String? Function(BuildContext, String?)? logInPasswordControllerValidator;
  // State field(s) for UserName widget.
  TextEditingController? userNameController;
  String? Function(BuildContext, String?)? userNameControllerValidator;
  // State field(s) for Email widget.
  TextEditingController? emailController;
  String? Function(BuildContext, String?)? emailControllerValidator;
  // State field(s) for PhoneNumber widget.
  TextEditingController? phoneNumberController;
  String? Function(BuildContext, String?)? phoneNumberControllerValidator;
  // State field(s) for SignUpPassword widget.
  TextEditingController? signUpPasswordController;
  late bool signUpPasswordVisibility;
  String? Function(BuildContext, String?)? signUpPasswordControllerValidator;
  // State field(s) for SignUpConfirmPassword widget.
  TextEditingController? signUpConfirmPasswordController;
  late bool signUpConfirmPasswordVisibility;
  String? Function(BuildContext, String?)?
      signUpConfirmPasswordControllerValidator;

  double? outputwater;
    dynamic? output;


  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    logInPasswordVisibility = false;
    signUpPasswordVisibility = false;
    signUpConfirmPasswordVisibility = false;
  }

  void dispose() {
    logInEmailController?.dispose();
    logInPasswordController?.dispose();
    userNameController?.dispose();
    emailController?.dispose();
    phoneNumberController?.dispose();
    signUpPasswordController?.dispose();
    signUpConfirmPasswordController?.dispose();
  }

  /// Additional helper methods are added here.

}
