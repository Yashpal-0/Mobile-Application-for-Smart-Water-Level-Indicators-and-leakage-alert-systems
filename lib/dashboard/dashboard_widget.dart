import '../primary_tank/primary_tank_widget.dart';
import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/about_widget.dart';
import '/components/contact_us_widget.dart';
import '/components/dev_info_widget.dart';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/custom_code/actions/index.dart' as actions;
import '/flutter_flow/custom_functions.dart' as functions;
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dashboard_model.dart';
export 'dashboard_model.dart';
import '/flutter_flow/flutter_flow_web_view.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'dart:ui';
import 'package:hydrow/edit_profile/edit_profile_widget.dart';
import 'package:hydrow/edit_device/edit_device_widget.dart';
import 'package:hydrow/tank_summary/tank_summary_widget.dart';

class DashboardWidget extends StatefulWidget {
  const DashboardWidget({
    Key? key,
    /*this.docReference*/
  }) : super(key: key);

  // final TankRecord? docReference;

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

int selectedindex = 0;
Color colorOne = Colors.blue[300]!;
Color colorTwo = Colors.blue[200]!;
Color colorThree = Colors.blue[100]!;

final appTheme = ThemeData(
  primarySwatch: Colors.red,
);

class _DashboardWidgetState extends State<DashboardWidget>
    with TickerProviderStateMixin {
  late DashboardModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  final animationsMap = {
    'columnOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0.0,
          end: 1.0,
        ),
      ],
    ),
  };

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => DashboardModel());

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      await actions.lockOrientation();
    });
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    List<Widget> pages = <Widget>[
      SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Container(
                  width: double.infinity,
                  height: 400.0,
                  padding: EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black!,
                        Colors.black!,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(0.0),
                  ),
                  child: LiquidLinearProgressIndicator(
                    value: 0.5,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      _getColor(0.3),
                    ),
                    backgroundColor: Colors.transparent,
                    borderRadius: 1.0,
                    borderWidth: 0.0,
                    borderColor: Colors.blue[300]!,
                    direction: Axis.vertical,
                  ),
                ),
              ),
              // FlutterFlowWebView(
              //           url: functions.graph(widget.docReference!.tankKey),
              //           bypass: false,
              //           height: 200.0,
              //           verticalScroll: false,
              //           horizontalScroll: false,
              //         ),
              TopBar(),
              // Container(
              //   height: 400,
              //   padding: EdgeInsets.all(0),
              //   decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [
              //           Colors.blue[300]!,
              //           Colors.black!,
              //         ],
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //       ),
              //       shape: BoxShape.rectangle,
              //       borderRadius: BorderRadius.circular(0.0),
              //     ),
              // child:
              FFButtonWidget(
                onPressed: () async {
                  _model.output = await actions.newCustomAction(
                    (currentUserDocument?.keyList?.toList() ?? []).toList(),
                  );

                  context.pushNamed(
                    'TankSummary',
                    queryParams: {
                      'water': serializeParam(
                        _model.output,
                        ParamType.JSON,
                      ),
                    }.withoutNulls,
                  );

                  setState(() {});
                },
                text: 'Show all devices',
                options: FFButtonOptions(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 25, 25, 25),
                  iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                  color: Color.fromARGB(255, 9, 135, 185),
                  textStyle: FlutterFlowTheme.of(context).subtitle2.override(
                        fontFamily: 'Poppins',
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w500,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(
                            FlutterFlowTheme.of(context).subtitle2Family),
                      ),
                ),
              ),
              // ),
            ],
          ),
        ),
      ),
      ),
      Icon(
        Icons.invert_colors,
        size: 150,
      )
    ];

    return Scaffold(
      endDrawer: Drawer(
        width: 200,
        child: Container(
          color: Colors.black,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 100,
                width: double.infinity,
                child: DrawerHeader(
                  child: Text(
                    '',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 24, 29),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/logo1.jpg'))),
                ),
              ),
              
              ListTile(
                leading: Icon(Icons.add, color: Colors.white),
                title:
                    Text('Add Device', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  context.pushNamed('AddDeviceQRScan');
                },
              ),
               ListTile(
                leading: Icon(Icons.propane_tank, color: Colors.white),
                title:
                    Text('Primary Tank', style: TextStyle(color: Colors.white)),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrimaryTankWidget()),
                  )
                },
              ),
              ListTile(
                leading: Icon(Icons.edit, color: Colors.white),
                title:
                    Text('Edit Profile', style: TextStyle(color: Colors.white)),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditProfileWidget()),
                  )
                },
              ),
              ListTile(
                leading: Icon(Icons.settings, color: Colors.white),
                title: Text('Device Settings',
                    style: TextStyle(color: Colors.white)),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EditDeviceWidget()),
                  )
                },
              ),
             
              ListTile(
                leading: Icon(Icons.playlist_add_check, color: Colors.white),
                title: Text('Terms & Conditions',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SecondRoute_tc()),
                  )
                },
              ),
              ListTile(
                leading: Icon(Icons.exit_to_app, color: Colors.white),
                title: Text('Logout', style: TextStyle(color: Colors.white)),
                onTap: () async {
                  GoRouter.of(context).prepareAuthEvent();
                  await signOut();

                  context.goNamedAuth('LogInSignUp', mounted);
                },
              ),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 24, 29),
      ),
      body: pages.elementAt(selectedindex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.invert_colors),
            label: 'Starr',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.show_chart),
            label: 'Pravah',
          ),
        ],
        currentIndex: selectedindex,
        onTap: onTapItem,
      ),
    );
  }

  void onTapItem(int index) {
    setState(() {
      selectedindex = index;
    });
  }
}

class AddDevices extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return (Drawer());
  }
}

class SecondRoute_ds extends StatelessWidget {
  const SecondRoute_ds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Device Settings'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class SecondRoute_pt extends StatelessWidget {
  const SecondRoute_pt({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Primary Tank'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

class SecondRoute_tc extends StatelessWidget {
  const SecondRoute_tc({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}

Color _getColor(double value) {
  if (value >= 0.8) {
    return Colors.blue[900]!;
  } else if (value >= 0.6) {
    return Colors.blue[700]!;
  } else if (value >= 0.4) {
    return Colors.blue[500]!;
  } else if (value >= 0.2) {
    return Colors.blue[300]!;
  } else {
    return Colors.blue[200]!;
  }
}

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 300.0,
      ),
      painter: CurvePainter(),
    );
  }
}

class CurvePainter extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
  Path path = Path();
  Paint paint = Paint();


  path.lineTo(0, size.height *0.75);
  path.quadraticBezierTo(size.width* 0.10, size.height*0.70,   size.width*0.17, size.height*0.90);
  path.quadraticBezierTo(size.width*0.20, size.height, size.width*0.25, size.height*0.90);
  path.quadraticBezierTo(size.width*0.40, size.height*0.40, size.width*0.50, size.height*0.70);
  path.quadraticBezierTo(size.width*0.60, size.height*0.85, size.width*0.65, size.height*0.65);
  path.quadraticBezierTo(size.width*0.70, size.height*0.90, size.width, 0);
  path.close();

  paint.color = colorThree;
  canvas.drawPath(path, paint);

  path = Path();
  path.lineTo(0, size.height*0.50);
  path.quadraticBezierTo(size.width*0.10, size.height*0.80, size.width*0.15, size.height*0.60);
  path.quadraticBezierTo(size.width*0.20, size.height*0.45, size.width*0.27, size.height*0.60);
  path.quadraticBezierTo(size.width*0.45, size.height, size.width*0.50, size.height*0.80);
  path.quadraticBezierTo(size.width*0.55, size.height*0.45, size.width*0.75, size.height*0.75);
  path.quadraticBezierTo(size.width*0.85, size.height*0.93, size.width, size.height*0.60);
  path.lineTo(size.width, 0);
  path.close();

  paint.color = colorTwo;
  canvas.drawPath(path, paint);

  path =Path();
  path.lineTo(0, size.height*0.75);
  path.quadraticBezierTo(size.width*0.10, size.height*0.55, size.width*0.22, size.height*0.70);
  path.quadraticBezierTo(size.width*0.30, size.height*0.90, size.width*0.40, size.height*0.75);
  path.quadraticBezierTo(size.width*0.52, size.height*0.50, size.width*0.65, size.height*0.70);
  path.quadraticBezierTo(size.width*0.75, size.height*0.85, size.width, size.height*0.60);
  path.lineTo(size.width, 0);
  path.close();

  paint.color = colorOne;
  canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }

}