import 'package:provider/provider.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:workmanager/workmanager.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_core/firebase_core.dart';
import 'auth/firebase_user_provider.dart';
import 'auth/auth_util.dart';
import 'dart:math';
import 'dart:async';
import 'backend/firebase/firebase_config.dart';
import 'flutter_flow/flutter_flow_theme.dart';
import 'flutter_flow/flutter_flow_util.dart';
import 'flutter_flow/internationalization.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'flutter_flow/nav/nav.dart';
import 'index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initFirebase();

  final appState = FFAppState(); // Initialize FFAppState

  if (!kIsWeb) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }
  WidgetsFlutterBinding.ensureInitialized();

  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  var android = AndroidInitializationSettings('@mipmap/ic_launcher');
  var iOS = DarwinInitializationSettings();

  var initializationSettings =
      InitializationSettings(android: android, iOS: iOS);
  await flip.initialize(initializationSettings);

  Workmanager().initialize(
    callbackDispatcher,
    isInDebugMode: true,
  );

  // Register periodic task
  await Workmanager().registerPeriodicTask(
    "2",
    "simplePeriodicTask",
    frequency: Duration(minutes: 15),
  );

  runApp(ChangeNotifierProvider(
    create: (context) => appState,
    child: MyApp(),
  ));
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();

    // Android notification settings
    var androidPlatformChannelSpecifics = const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      importance: Importance.max,
      priority: Priority.high,
    );

    // iOS notification settings
    var iOSPlatformChannelSpecifics = DarwinNotificationDetails();

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    
    // Fetch data from Thingspeak
    final response = await http.get(Uri.parse(
        'https://api.thingspeak.com/channels/2086669/feeds.json?api_key=F0QFTNP2WB3II639&results=2'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final feeds = data['feeds'];
      if (feeds.isNotEmpty) {
        final value = feeds[0]['field6'];
        await flip.show(
          0,
          'Field 6 Value',
          'The value of field 6 is $value',
          platformChannelSpecifics,
          payload: 'Default_Sound',
        );
      }
    }

    return Future.value(true);
  });
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>()!;
}

class _MyAppState extends State<MyApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.system;

  late Stream<HydrowFirebaseUser> userStream;

  late AppStateNotifier _appStateNotifier;
  late GoRouter _router;

  final authUserSub = authenticatedUserStream.listen((_) {});
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  // late Timer _timer;
  // Random random = Random();
  // int randomNumber = 0;

  @override
  void initState() {
    super.initState();
    _appStateNotifier = AppStateNotifier();
    _router = createRouter(_appStateNotifier);
    // _timer = Timer.periodic(Duration(seconds: 10), (timer) {
    //   setState(() {
    //     randomNumber = random.nextInt(100) + 1;
    //     if (randomNumber > 50) {
    //       _showNotification();
    //     }
    //   });
    // });
    userStream = hydrowFirebaseUserStream()
      ..listen((user) => _appStateNotifier.update(user));
    jwtTokenStream.listen((_) {});
    Future.delayed(
      Duration(seconds: 1),
      () => _appStateNotifier.stopShowingSplashImage(),
    );
  }

  // Future<void> _showNotification() async {
  //   var android = AndroidNotificationDetails(
  //     'channel_id',
  //     'Channel Name',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //   );
  //   var platform = NotificationDetails(android: android);
  //   await flutterLocalNotificationsPlugin.show(
  //     0,
  //     'Random Number',
  //     'The generated number is $randomNumber',
  //     platform,
  //     payload: 'Welcome to the Local Notification demo',
  //   );
  // }

  @override
  void dispose() {
    authUserSub.cancel();
    // _timer.cancel();
    super.dispose();
  }

  void setLocale(String language) {
    setState(() => _locale = createLocale(language));
  }

  void setThemeMode(ThemeMode mode) => setState(() {
        _themeMode = mode;
      });

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hydrow',
      localizationsDelegates: [
        FFLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(brightness: Brightness.light),
      themeMode: _themeMode,
      routeInformationParser: _router.routeInformationParser,
      routerDelegate: _router.routerDelegate,
    );
  }
}
