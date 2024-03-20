// ignore_for_file: prefer_const_constructors, unused_import, avoid_web_libraries_in_flutter, depend_on_referenced_packages, prefer_const_literals_to_create_immutables, unnecessary_import
import 'dart:io';

import 'package:device_preview/device_preview.dart';
//import 'package:firebase_core/firebase_core.dart';

import 'package:ecg_app/screens/FolderListScreen.dart';
import 'package:ecg_app/screens/For%20Test%20screens/MyHomePage.dart';
import 'package:ecg_app/screens/For%20Test%20screens/new.dart';
import 'package:ecg_app/screens/For%20Test%20screens/test.dart';
import 'package:ecg_app/screens/OPENUP.dart';
import 'package:ecg_app/screens/homepage.dart';
import 'package:ecg_app/screens/line_chart_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
// Future<void> main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//    await Firebase.initializeApp();
//   runApp(
//     DevicePreview(
//       enabled: !kReleaseMode,
//       builder: (context) => MyApp(), // Wrap your app
//     ),
//   );
// }


import 'package:flutter/foundation.dart' show kIsWeb; // Import kIsWeb
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (!kIsWeb) {
    // Initialize Firebase only if not running in a web environment
    // Add your Firebase configuration here
    await Firebase.initializeApp();
    

  }else{
  
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: 'AIzaSyCsMrtXRm0MWjuC4Xx8b4oxII53fucApQA',
        appId: '1:292233040618:android:9c554ab1f33899c7e0bd93',
        messagingSenderId: '292233040618 ',
        projectId: 'arduino-ecg-f7bf6',
        databaseURL: "https://arduino-ecg-f7bf6-default-rtdb.asia-southeast1.firebasedatabase.app",
        storageBucket: 'arduino-ecg-f7bf6.appspot.com'
      )
    );
  }

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}



class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
static const String title = 'ECG';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: title,
      theme: ThemeData(primaryColor: Colors.blueGrey[900]),
      debugShowCheckedModeBanner: false,
        home: OPENUP(),
    );
  }
}


