// ignore_for_file: file_names

import 'dart:async';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:perfex_e_learning/screens/home.dart';
import 'package:perfex_e_learning/screens/login_screen/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  final storage = new FlutterSecureStorage();

  Future<bool> checkLoginStatus() async {
    String? value = await storage.read(key: "uid");
    if (value == null) {
      return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds: 3000),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => FutureBuilder(
                    future: checkLoginStatus(),
                    builder:
                        ((BuildContext context, AsyncSnapshot<bool> snapshot) {
                      if (snapshot.data == false) {
                        return LoginScreen();
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return Home();
                    })))));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      //child: FlutterLogo(size: MediaQuery.of(context).size.height)
      child: Image.asset(
        "assets/gif/pel.gif",
        scale: MediaQuery.of(context).size.aspectRatio * 0.05,
      ),
    );
  }
}
