import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants.dart';
import 'login_screen.dart';

class SplashScreenSimple extends StatefulWidget {
  const SplashScreenSimple({super.key});

  @override
  State<SplashScreenSimple> createState() => _SplashScreenSimpleState();
}

class _SplashScreenSimpleState extends State<SplashScreenSimple> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AppConstants.backgroundColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.movie_filter,
                size: 100,
                color: AppConstants.primaryColor,
              ),
              const SizedBox(height: 20),
              Text(
                AppConstants.appName,
                style: GoogleFonts.montserrat(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppConstants.primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}