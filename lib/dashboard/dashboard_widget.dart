import 'dart:async';
import '../components/TermsandCondition_widget.dart';
import '../primary_tank/primary_tank_widget.dart';
import '/auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/about_widget.dart';
import '/components/contact_us_widget.dart';
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

  // Getting the default tank and giving the key to tankKey variable.
  var tankKey = FFAppState().tankKey;
  String? water;

  @override
  _DashboardWidgetState createState() => _DashboardWidgetState();
}

int selectedindex = 0;

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
    //Giving the Default tank key to widget tankKey
    widget.tankKey = FFAppState().tankKey;
    List<Widget> pages = <Widget>[
      SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 20),
                child: StreamBuilder<List<TankRecord>>(
                  //Fetching the tank record of the default tank
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
                    //If data found return the Water tank container
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
                              Stack(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    height: 350.0,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        10, 10, 10, 10),
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
                                    //Liquid linear progress indicator 
                                    child: LiquidLinearProgressIndicator(
                                      // value: 0.75,
                                      //Calculating the water level in range of 0-1 for widget value
                                      value: functions.tankAPI(
                                          functions.calculateWaterAvailable(
                                              containerTankRecord!.length!,
                                              containerTankRecord!.breadth!,
                                              containerTankRecord!.height!,
                                              containerTankRecord!.radius!,
                                              _model.waterLevel,
                                              containerTankRecord!.isCuboid!),
                                          functions.calculateVolume(
                                              containerTankRecord!.isCuboid!,
                                              containerTankRecord!.length!,
                                              containerTankRecord!.breadth!,
                                              containerTankRecord!.height!,
                                              containerTankRecord!.radius!)),
                                      valueColor: AlwaysStoppedAnimation(
                                          Color.fromARGB(255, 44, 69,
                                              99)), // Defaults to the current Theme's accentColor.
                                      backgroundColor: Colors
                                          .black, // Defaults to the current Theme's backgroundColor.
                                      borderColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                      borderWidth: 3.0,
                                      borderRadius: 25.0,
                                      direction: Axis
                                          .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                                      center: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.95,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0),
                                          borderRadius:
                                              BorderRadius.circular(17.0),
                                        ),
                                        child: Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  15.0, 15.0, 0.0, 15.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Align(
                                                alignment: AlignmentDirectional(
                                                    1.0, 0.0),
                                                child: Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(
                                                          0.0, 0.0, 20.0, 0.0),
                                                  child: Text(
                                                    containerTankRecord!
                                                        .tankName!,
                                                    style: FlutterFlowTheme.of(
                                                            context)
                                                        .bodyText1
                                                        .override(
                                                          fontFamily: 'Poppins',
                                                          color: Colors.white,
                                                          fontSize: 40.0,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          useGoogleFonts: GoogleFonts
                                                                  .asMap()
                                                              .containsKey(
                                                                  FlutterFlowTheme.of(
                                                                          context)
                                                                      .bodyText1Family),
                                                        ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 5.0, 0.0, 5.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.6,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        100, 0, 0, 0),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(17.0),
                                                      bottomRight:
                                                          Radius.circular(17.0),
                                                      topLeft:
                                                          Radius.circular(17.0),
                                                      topRight:
                                                          Radius.circular(0.0),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.max,
                                                    children: [
                                                      Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              //Creating a text of total water available in the tank
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
                                                                      _model
                                                                          .waterLevel,
                                                                      containerTankRecord!
                                                                          .isCuboid!)
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Color(
                                                                        0xFF22FF00),
                                                                    fontSize:
                                                                        44.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyText1Family),
                                                                  ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment:
                                                                AlignmentDirectional(
                                                                    1.0, 0.0),
                                                            child: Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                              child: Text(
                                                                ' L',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: Color(
                                                                          0xFF22FF00),
                                                                      fontSize:
                                                                          44.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyText1Family),
                                                                    ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Align(
                                                        alignment:
                                                            AlignmentDirectional(
                                                                1.0, 0.0),
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                      0.0,
                                                                      0.0,
                                                                      10.0,
                                                                      0.0),
                                                          child: Text(
                                                            'available for use',
                                                            style: FlutterFlowTheme
                                                                    .of(context)
                                                                .bodyText1
                                                                .override(
                                                                  fontFamily:
                                                                      'Poppins',
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      14.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                  useGoogleFonts: GoogleFonts
                                                                          .asMap()
                                                                      .containsKey(
                                                                          FlutterFlowTheme.of(context)
                                                                              .bodyText1Family),
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(
                                                        0.0, 0.0, 0.0, 5.0),
                                                child: Container(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4,
                                                  decoration: BoxDecoration(
                                                    color: Color.fromARGB(
                                                        120, 0, 0, 0),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      bottomLeft:
                                                          Radius.circular(17.0),
                                                      bottomRight:
                                                          Radius.circular(0.0),
                                                      topLeft:
                                                          Radius.circular(17.0),
                                                      topRight:
                                                          Radius.circular(0.0),
                                                    ),
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        AlignmentDirectional(
                                                            1.0, 0.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.max,
                                                      children: [
                                                        Row(
                                                          mainAxisSize:
                                                              MainAxisSize.max,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Text(
                                                              //Calculating percentage of water filled in the tank
                                                              functions
                                                                  .convertToInt(functions.tankAPI(
                                                                      functions.calculateWaterAvailable(
                                                                          containerTankRecord!
                                                                              .length!,
                                                                          containerTankRecord!
                                                                              .breadth!,
                                                                          containerTankRecord!
                                                                              .height!,
                                                                          containerTankRecord!
                                                                              .radius!,
                                                                          _model
                                                                              .waterLevel,
                                                                          containerTankRecord!
                                                                              .isCuboid!),
                                                                      containerTankRecord!
                                                                          .capacity))
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Color(
                                                                        0xFF01C7B9),
                                                                    fontSize:
                                                                        35.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyText1Family),
                                                                  ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          10.0,
                                                                          0.0),
                                                              child: Text(
                                                                '%',
                                                                style: FlutterFlowTheme.of(
                                                                        context)
                                                                    .bodyText1
                                                                    .override(
                                                                      fontFamily:
                                                                          'Poppins',
                                                                      color: Color(
                                                                          0xFF01C7B9),
                                                                      fontSize:
                                                                          35.0,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      useGoogleFonts: GoogleFonts
                                                                              .asMap()
                                                                          .containsKey(
                                                                              FlutterFlowTheme.of(context).bodyText1Family),
                                                                    ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                          0.0,
                                                                          0.0,
                                                                          20.0,
                                                                          0.0),
                                                              child: Column(
                                                                mainAxisSize:
                                                                    MainAxisSize
                                                                        .max,
                                                                children: [
                                                                  Text(
                                                                    'Tank',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyText1Family),
                                                                        ),
                                                                  ),
                                                                  Text(
                                                                    'Filled',
                                                                    style: FlutterFlowTheme.of(
                                                                            context)
                                                                        .bodyText1
                                                                        .override(
                                                                          fontFamily:
                                                                              'Poppins',
                                                                          color:
                                                                              Colors.white,
                                                                          fontSize:
                                                                              15.0,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                          useGoogleFonts:
                                                                              GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyText1Family),
                                                                        ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.35,
                                                decoration: BoxDecoration(
                                                  color: Color.fromARGB(
                                                      130, 0, 0, 0),
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(17.0),
                                                    bottomRight:
                                                        Radius.circular(0.0),
                                                    topLeft:
                                                        Radius.circular(17.0),
                                                    topRight:
                                                        Radius.circular(0.0),
                                                  ),
                                                ),
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Align(
                                                      alignment:
                                                          Alignment.centerRight,
                                                      child: Padding(
                                                        padding:
                                                            EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                    0.0,
                                                                    0.0,
                                                                    10.0,
                                                                    0.0),
                                                        child: Text(
                                                          'Total Capacity ',
                                                          style: FlutterFlowTheme
                                                                  .of(context)
                                                              .bodyText1
                                                              .override(
                                                                fontFamily:
                                                                    'Poppins',
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 10.0,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                useGoogleFonts: GoogleFonts
                                                                        .asMap()
                                                                    .containsKey(
                                                                        FlutterFlowTheme.of(context)
                                                                            .bodyText1Family),
                                                              ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0.0,
                                                                  0.0,
                                                                  10.0,
                                                                  0.0),
                                                      child: Row(
                                                        mainAxisSize:
                                                            MainAxisSize.max,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              //Total Capacity of the tank
                                                              containerTankRecord!
                                                                  .capacity!
                                                                  .toString(),
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyText1Family),
                                                                  ),
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: Text(
                                                              'L',
                                                              style: FlutterFlowTheme
                                                                      .of(context)
                                                                  .bodyText1
                                                                  .override(
                                                                    fontFamily:
                                                                        'Poppins',
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                        20.0,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    useGoogleFonts: GoogleFonts
                                                                            .asMap()
                                                                        .containsKey(
                                                                            FlutterFlowTheme.of(context).bodyText1Family),
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
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
                                        //Calling the api to fetch the water level from the tank
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
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                                    //Fetching the graph
                                child: FlutterFlowWebView(
                                  url: functions
                                      .graph(containerTankRecord!.tankKey),
                                  bypass: false,
                                  height: 200.0,
                                  verticalScroll: false,
                                  horizontalScroll: false,
                                ),
                              ),

                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: FFButtonWidget(
                    //Upon clicking the show all devices it will redirect to TankSummary page
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
      //End drawer
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
                  //Box decoration for Hydrow Logo
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 0, 24, 29),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage('assets/images/logo1.jpg'))),
                ),
              ),
              //Tiles List
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
                        builder: (context) => const TermsandCondition()),
                  )
                },
              ),
              ListTile(
                leading: Icon(Icons.playlist_add_check, color: Colors.white),
                title: Text('About',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AboutWidget()),
                  )
                },
              ),
              ListTile(
                leading: Icon(Icons.playlist_add_check, color: Colors.white),
                title: Text('Contact Us',
                    style: TextStyle(
                      color: Colors.white,
                    )),
                onTap: () => {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ContactUsWidget()),
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
      //App bar
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 0, 24, 29),
        title: Text(
          'Dashboard',
        ),
        centerTitle: true,
      ),
      //It will select the Starr or Pravah dashboard based of selectedindex value
      body: pages.elementAt(selectedindex),
      //Bottom navigation bar of Starr and Pravah
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
//Switching of index value upon clicking
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