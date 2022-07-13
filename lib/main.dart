import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:perfex_e_learning/bindings/initial_binding.dart';
import 'package:perfex_e_learning/screens/splashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'helpers/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await firebaseInitialization.then((value) {
    runApp(FirebaseDemo());
  });
}

class FirebaseDemo extends StatelessWidget {
  FirebaseDemo({Key? key}) : super(key: key);
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
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          // Check for Errors
          if (snapshot.hasError) {
            print("Something Went Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              initialBinding: InitialBinding(),
              home: const SplashScreen());
        });
    // return GetMaterialApp(
    //     title: 'Firebase Demo',
    //     debugShowCheckedModeBanner: false,
    //     initialBinding: InitialBinding(),
    //     home: const SplashScreen());
  }
}
