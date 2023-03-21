import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBGweTkfwJLMzyVnZ0VsqVXf076BXr5V2E",
            authDomain: "hydrow-4dcfc.firebaseapp.com",
            projectId: "hydrow-4dcfc",
            storageBucket: "hydrow-4dcfc.appspot.com",
            messagingSenderId: "741170172423",
            appId: "1:741170172423:web:764bf60eb09f3184a790a2",
            measurementId: "G-FTD87GWSQ7"));
  } else {
    await Firebase.initializeApp();
  }
}
