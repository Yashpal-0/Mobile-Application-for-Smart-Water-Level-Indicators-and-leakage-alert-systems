import 'dart:async';
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
import '/custom_code/widgets/index.dart' as custom_widgets;
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
import '/custom_code/actions/index.dart' as actions;

class DashboardWidget extends StatefulWidget {
  DashboardWidget({
    Key? key,
    this.water = '0',
  }) : super(key: key);

  // final TankRecord? docReference;
  var tankKey = FFAppState().tankKey;
  String? water;

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

  double CalculatePercentage(String? maxwaterLevel, double? distance) {
    double? height = double.parse(maxwaterLevel!);
    // double? dist = double.parse(distance!);

    double percentage = (height - distance!) / height;
    return percentage;
  }

  String? waterr;
  void function() async {
    _model.output = await actions.newCustomAction(
      (currentUserDocument?.keyList?.toList() ?? []).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();
    widget.tankKey = FFAppState().tankKey;
    // _model.output = actions.newCustomAction(
    //   (currentUserDocument?.keyList?.toList() ?? []).toList(),
    // );
    function();
    List<Widget> pages = <Widget>[
      SingleChildScrollView(
        // child: Center(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Center(

              // FlutterFlowWebView(url: functions.graph(FFAppState().tankKey),
              // bypass: false,
              // height: 200.0,
              // verticalScroll: false,
              // horizontalScroll: false,
              // ),
              // ),
              // FlutterFlowWebView(
              //           url: functions.graph(widget.docReference!.tankKey),
              //           bypass: false,
              //           height: 200.0,
              //           verticalScroll: false,
              //           horizontalScroll: false,
              //         ),
              // TopBar(),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
                child: StreamBuilder<List<TankRecord>>(
                  stream: queryTankRecord(
                    parent: currentUserReference,
                    queryBuilder: (tankRecord) => tankRecord.where('TankKey',
                        isEqualTo: FFAppState().tankKey),
                    singleRecord: true,
                  ),
                  builder: (context, snapshot) {
                    // Customize what your widget looks like when it's loading.
                    if (!snapshot.hasData) {
                      return Center(
                        child: SizedBox(
                          width: 75,
                          height: 75,
                          child: SpinKitRipple(
                            color: Color(0xFF7E8083),
                            size: 75,
                          ),
                        ),
                      );
                    }
                    List<TankRecord> containerTankRecordList = snapshot.data!;
                    // Return an empty Container when the item does not exist.
                    if (snapshot.data!.isEmpty) {
                      return Container(
                        child: Text('Select the Default Tank',
                            style: TextStyle(color: Colors.white)),
                      );
                    }
                    final containerTankRecord =
                        containerTankRecordList.isNotEmpty
                            ? containerTankRecordList.first
                            : null;
                    return Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 0, 0, 0),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(containerTankRecord!.tankName!,
                                  style: TextStyle(color: Colors.white)),
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 350.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 20),
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
                                      value: 0.25,
                                      // value: _model.waterLevel!/double.parse(containerTankRecord!.height!),
                                      // value: CalculatePercentage(containerTankRecord!.height, _model.waterLevel), // Defaults to 0.5.
                                      valueColor: AlwaysStoppedAnimation(Colors
                                          .blue), // Defaults to the current Theme's accentColor.
                                      backgroundColor: Colors
                                          .black, // Defaults to the current Theme's backgroundColor.
                                      borderColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      borderWidth: 3.0,
                                      borderRadius: 25.0,
                                      direction: Axis
                                          .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                      center: Text(
                                          valueOrDefault<String>(
                                                  functions
                                                      .calculateWaterAvailable(
                                                          containerTankRecord!
                                                              .length!,
                                                          containerTankRecord!
                                                              .breadth!,
                                                          containerTankRecord!
                                                              .height!,
                                                          containerTankRecord!
                                                              .radius!,
                                                          _model.waterLevel,
                                                          containerTankRecord!
                                                              .isCuboid!)
                                                      .toString(),
                                                  '0') +
                                              ' Litres',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                    ),
                                    // child: custom_widgets.LiquidProgress(
                                    //   width: 1000,
                                    //   height: 1000,
                                    //     // param: functions.tankAPI(
                                    //     //     functions.calculateWaterAvailable(
                                    //     //         widget.docReference!.length!,
                                    //     //         widget.docReference!.breadth!,
                                    //     //         widget.docReference!.height!,
                                    //     //         widget.docReference!.radius!,
                                    //     //         widget.waterLevel,
                                    //     //         widget.docReference!.isCuboid!),
                                    //     //     functions.calculateVolume(
                                    //     //         widget.docReference!.isCuboid!,
                                    //     //         widget.docReference!.length!,
                                    //     //         widget.docReference!.breadth!,
                                    //     //         widget.docReference!.height!,
                                    //     //         widget.docReference!.radius!)),
                                    // ),
                                  ),
                                ],
                              ),

                              Stack(
                                alignment: Alignment.centerRight,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 30,
                                    decoration: new BoxDecoration(
                                      borderRadius:
                                          new BorderRadius.circular(0.0),
                                      color: Colors.black,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 0, 10, 0),
                                    child: FFButtonWidget(
                                      onPressed: () async {
                                        _model.waterLevel =
                                            await actions.callAPI(
                                          functions.generateChannelID(
                                              containerTankRecord!.tankKey!),
                                          functions.generateReadAPI(
                                              containerTankRecord!.tankKey!),
                                        );
                                        setState(() {});
                                      },
                                      text: 'Refresh',
                                      options: FFButtonOptions(
                                        width: 100,
                                        height: 30,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 0, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                10, 10, 10, 10),
                                        color: FlutterFlowTheme.of(context)
                                            .primaryBtnText,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .title3
                                            .override(
                                              fontFamily:
                                                  FlutterFlowTheme.of(context)
                                                      .title3Family,
                                              color: Color(0xFF0B0B0B),
                                              useGoogleFonts:
                                                  GoogleFonts.asMap()
                                                      .containsKey(
                                                          FlutterFlowTheme.of(
                                                                  context)
                                                              .title3Family),
                                            ),
                                        // elevation: 2,
                                        // borderSide: BorderSide(
                                        //   color: Colors.transparent,
                                        //   width: 1,
                                        // ),
                                        // borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                child: FlutterFlowWebView(
                                  url: functions
                                      .graph(containerTankRecord!.tankKey),
                                  bypass: false,
                                  height: 200.0,
                                  verticalScroll: false,
                                  horizontalScroll: false,
                                ),
                              ),

                              // Row(
                              //   mainAxisSize: MainAxisSize.max,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Padding(
                              //       padding: EdgeInsetsDirectional.fromSTEB(
                              //           0, 10, 0, 0),
                              //       child: Text(
                              //         valueOrDefault<String>(
                              //           functions
                              //               .calculateWaterAvailable(
                              //                   containerTankRecord!.length!,
                              //                   containerTankRecord!.breadth!,
                              //                   containerTankRecord!.height!,
                              //                   containerTankRecord!.radius!,
                              //                   _model.waterLevel,
                              //                   containerTankRecord!.isCuboid!)
                              //               .toString(),
                              //           '0',
                              //         ),
                              //       ),
                              //     ),
                              //   ],
                              // ),

                              // Row(
                              //   mainAxisSize: MainAxisSize.max,
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              //   children: [
                              //     Padding(
                              //       padding: EdgeInsetsDirectional.fromSTEB(
                              //           0, 0, 2, 0),
                              //       child: Text(
                              //         'water available in',
                              //       ),
                              //     ),
                              //     Padding(
                              //       padding: EdgeInsetsDirectional.fromSTEB(
                              //           2, 0, 0, 0),
                              //       child: Text(
                              //         containerTankRecord!.tankName!,
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              // Padding(
                              //   padding:
                              //       EdgeInsetsDirectional.fromSTEB(5, 10, 5, 15),
                              //   child: FFButtonWidget(
                              //     onPressed: () async {
                              //       _model.waterLevel = await actions.callAPI(
                              //         functions.generateChannelID(
                              //             containerTankRecord!.tankKey!),
                              //         functions.generateReadAPI(
                              //             containerTankRecord!.tankKey!),
                              //       );
                              //       // setState(() {});
                              //     },
                              //     text: 'Refresh',
                              //     options: FFButtonOptions(
                              //       width: 100,
                              //       height: 30,
                              //       padding: EdgeInsetsDirectional.fromSTEB(
                              //           0, 0, 0, 0),
                              //       iconPadding: EdgeInsetsDirectional.fromSTEB(
                              //           0, 0, 0, 0),
                              //       color: FlutterFlowTheme.of(context)
                              //           .primaryBtnText,
                              //       textStyle: FlutterFlowTheme.of(context).title3.override(
                              //             fontFamily: FlutterFlowTheme.of(context).title3Family,
                              //             color: Color(0xFF0B0B0B),
                              //             useGoogleFonts: GoogleFonts.asMap().containsKey(
                              //                 FlutterFlowTheme.of(context).title3Family),
                              //     ),
                              //     // elevation: 2,
                              //     // borderSide: BorderSide(
                              //     //   color: Colors.transparent,
                              //     //   width: 1,
                              //     // ),
                              //     // borderRadius: BorderRadius.circular(8),
                              //   ),
                              // ),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              // ListView.builder(
              //   padding: EdgeInsets.zero,
              //   scrollDirection: Axis.vertical,
              //   itemCount: tanks.length,
              //   itemBuilder: (context, tanksIndex) {
              //     final tanksItem = tanks[tanksIndex];

              //     return InkWell(
              //       onTap: () async {
              //         _model.outputwater = await actions.callAPI(
              //           functions.generateChannelID(
              //               tanksItem['TankKey'].toString()),
              //           functions.generateReadAPI(
              //               tanksItem['TankKey'].toString()),
              //         );

              // ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: FFButtonWidget(
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
                      padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                      iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                      color: Colors.white,
                      textStyle: FlutterFlowTheme.of(context)
                          .subtitle2
                          .override(
                            fontFamily: 'Poppins',
                            color: Colors.black,
                            fontSize: 14,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(
                                FlutterFlowTheme.of(context).subtitle2Family),
                          ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        // ),
      ),
      Icon(
        Icons.invert_colors,
        size: 150,
      )
    ];

    return Scaffold(
      backgroundColor: Colors.black,
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
                    Text('Default Tank', style: TextStyle(color: Colors.white)),
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
        title: Text(
          'Dashboard',
        ),
        centerTitle: true,
      ),
      body: pages.elementAt(selectedindex),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 0, 24, 29),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(
              Icons.invert_colors,
              color: Colors.white,
            ),
            label: 'Starr',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.show_chart, color: Colors.white),
            label: 'Pravah',
          ),
        ],
        currentIndex: selectedindex,
        unselectedItemColor: Colors.white,
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

// class TopBar extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustomPaint(
//       child: Container(
//         height: 300.0,
//       ),
//       painter: CurvePainter(),
//     );
//   }
// }

// class CurvePainter extends CustomPainter{
//   @override
//   void paint(Canvas canvas, Size size) {
//   Path path = Path();
//   Paint paint = Paint();


//   path.lineTo(0, size.height *0.25);
//   path.quadraticBezierTo(size.width* 0.10, size.height*0.20,   size.width*0.17, size.height*0.40);
//   path.quadraticBezierTo(size.width*0.20, size.height*0.5, size.width*0.25, size.height*0.40);
//   path.quadraticBezierTo(size.width*0.40, size.height*0.0, size.width*0.50, size.height*0.20);
//   path.quadraticBezierTo(size.width*0.60, size.height*0.35, size.width*0.65, size.height*0.15);
//   path.quadraticBezierTo(size.width*0.70, size.height*0.40, size.width, 0);
//   path.close();

//   paint.color = colorThree;
//   canvas.drawPath(path, paint);

//   path = Path();
//   path.lineTo(0, size.height*0.20);
//   path.quadraticBezierTo(size.width*0.10, size.height*0.30, size.width*0.15, size.height*0.10);
//   path.quadraticBezierTo(size.width*0.20, size.height*0.0, size.width*0.27, size.height*0.10);
//   path.quadraticBezierTo(size.width*0.45, size.height*0.50, size.width*0.50, size.height*0.30);
//   path.quadraticBezierTo(size.width*0.55, size.height*0.0, size.width*0.75, size.height*0.25);
//   path.quadraticBezierTo(size.width*0.85, size.height*0.43, size.width, size.height*0.10);
//   path.lineTo(size.width, 0);
//   path.close();

//   paint.color = colorTwo;
//   canvas.drawPath(path, paint);

//   path =Path();
//   path.lineTo(0, size.height*0.25);
//   path.quadraticBezierTo(size.width*0.10, size.height*0.5, size.width*0.22, size.height*0.20);
//   path.quadraticBezierTo(size.width*0.30, size.height*0.40, size.width*0.40, size.height*0.25);
//   path.quadraticBezierTo(size.width*0.52, size.height*0.0, size.width*0.65, size.height*0.20);
//   path.quadraticBezierTo(size.width*0.75, size.height*0.35, size.width, size.height*0.10);
//   path.lineTo(size.width, 0);
//   path.close();

//   paint.color = colorOne;
//   canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(CustomPainter oldDelegate) {
//     return oldDelegate != this;
//   }

// }

