import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/catalog_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to the home page after a delay
    Timer(Duration(seconds: 3), () {
      // Get the context from the navigator key
      final navigator = Navigator.of(context);
      navigator.pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                CatalogScreen()), // Replace `HomePage` with your actual home page widget
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF4CAF50),
      body: Center(
        child: Image.asset(
          'assets/image/splash/nahes.png',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
