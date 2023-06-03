import 'package:flutter/material.dart';
import 'package:tracker/Helpers/auth_screen.dart';
import 'package:tracker/Helpers/screen_router.dart';
import 'package:tracker/constants.dart';
import 'package:tracker/screens/home.dart';
import 'package:tracker/screens/login.dart';
import 'package:tracker/screens/onboarding_screen.dart';
import 'package:tracker/screens/signup.dart';
import 'package:firebase_core/firebase_core.dart';
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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.green[600],
      ),
      initialRoute: '/auth',
      routes: {
        '/home': (context) => ScreenRouter(),
        // '/onboarding': (context) => OnboardingScreen(),
        '/login': (context) => Login(),
        '/signup': (context) => Signup(),
        '/auth': (context) => AuthScreen(),
      },
    );
  }
}
