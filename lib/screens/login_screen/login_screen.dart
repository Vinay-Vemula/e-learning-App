import 'package:flutter/material.dart';
import 'package:perfex_e_learning/screens/login_screen/components/background_design.dart';
import 'package:perfex_e_learning/screens/login_screen/components/login_credentials.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Stack(
            children: const [
              BackgroundDesign(),
              LoginCredentials(),
              //BottomContainer(),
            ],
          ),
        ),
      ),
    );
  }
}
