import 'package:agri_expert/home/home_view.dart';
import 'package:agri_expert/provider/user_provider.dart';
import 'package:agri_expert/provider/video_provider.dart';
import 'package:agri_expert/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'BottomNavigationBarView/BottomNavigationBarView.dart';
import 'auth/personal_details_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Supabase.initialize(
    url: 'https://cugwarvnvxjdrqxubywb.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN1Z3dhcnZudnhqZHJxeHVieXdiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk1Njk3NTgsImV4cCI6MjA3NTE0NTc1OH0.-8oGWycP0rvpAM5UsUsd5Y8vNK9Hw_6PI0SaMjHG3VA',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => VideoProvider()),

      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
        ),
        home: const SplashScreen(),
      ),
    );
  }
}