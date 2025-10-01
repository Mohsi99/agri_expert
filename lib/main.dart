import 'package:agri_expert/home/home_view.dart';
import 'package:agri_expert/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'BottomNavigationBarView/BottomNavigationBarView.dart';
import 'auth/personal_details_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:
          ThemeData(bottomNavigationBarTheme: BottomNavigationBarThemeData()),
      home: SplashScreen(),
    );
  }
}
