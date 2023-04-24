import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'TermsandConditions_model.dart';

class TermsandCondition extends StatefulWidget {
  const TermsandCondition({Key? key}) : super(key: key);

  @override
  State<TermsandCondition> createState() => _TermsandConditionState();
}

class _TermsandConditionState extends State<TermsandCondition> {
  late TermsandConditionModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TermsandConditionModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    return SingleChildScrollView(
      child: Container(
        width: 400.0,
        height: 1700.0,
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      EdgeInsetsDirectional.fromSTEB(15.0, 15.0, 15.0, 15.0),
                  child: Text(
                    'Terms and Conditions',
                    textAlign: TextAlign.left,
                    style: FlutterFlowTheme.of(context).bodyText1.override(
                          fontFamily: 'Poppins',
                          color: Colors.white,
                          fontSize: 28.0,
                          useGoogleFonts: GoogleFonts.asMap().containsKey(
                              FlutterFlowTheme.of(context).bodyText1Family),
                        ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
              child: Text(
                'Please read these Terms and Conditions of Use ("Terms") carefully before downloading, installing, or using the water tank monitoring mobile application (the "App") on your Android device. By downloading, installing, or using the App, you agree to be bound by these Terms and all associated services offered by Hydrow\n\n1. License:Owner grants you a non-exclusive and revocable license to use the App on your Android device in accordance with these Terms and the applicable usage rules set forth in the Google Play Store Terms of Service.\n2. Restrictions:You are not allowed to copy, modify, distribute, sell, or transfer the App or any portion thereof; attempting to reverse engineer or extract source code from the App is strictly prohibited unless such activity is expressly permitted by law. You are not permitted to use the App for any illegal or unauthorized purpose.\n3. Ownership:The App, along with all intellectual property rights therein, is owned exclusively by Owner and its licensors; no rights or licenses are granted to you by implication or otherwise besides the limited license granted to you within these Terms.\n4. Privacy:Owner values your privacy and is committed to protecting your personal information for details about how we collect and use your data.\n5. Disclaimer of Warranties: The App is provided without warranty of any kind; Owner disclaims all express and implied warranties including merchantability, fitness for a specific purpose, and non-infringement. There is no guarantee that this application will meet all your requirements nor that its operation will be error-free and uninterrupted at all times.\n 6. Limitation of Liability: In no event shall Owner be liable for any direct or indirect damages arising out of or in connection with the use or inability to use this application even if a warning has been given regarding such damages; some jurisdictions do not allow exclusion/limitation of liability for consequential/incidental damages so this limitation may not apply to you .\n7. Indemnification: You agree to defend, hold harmless Owner as well as its affiliates, officers, directors, employees, agents and licensors from any claims resulting from your use of the App .\n8. Changes To Terms: Owner reserves the right to modify these Terms at any time without notice and without liability towards you; continued usage signifies agreement with revised terms .\n9. Termination: Owner may terminate these Terms as well as access to this application at any time without prior warning .\n10. Governing Law : These Terms shall be governed by their courts ; any legal actions resulting from these terms should be brought there too .\n11. Entire Agreement : These terms constitute the complete agreement between both parties concerning usage of this app , superseding all prior communications between both parties regarding it .',
                textAlign: TextAlign.left,
                style: FlutterFlowTheme.of(context).bodyText1.override(
                      fontFamily: 'Poppins',
                      color: Colors.white,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                      useGoogleFonts: GoogleFonts.asMap().containsKey(
                          FlutterFlowTheme.of(context).bodyText1Family),
                    ),
              ),
            ),
            Container(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Go Back!'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
