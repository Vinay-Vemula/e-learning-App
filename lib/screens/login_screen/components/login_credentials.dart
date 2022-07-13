import 'package:clay_containers/clay_containers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:perfex_e_learning/screens/home.dart';
import 'package:perfex_e_learning/screens/login_screen/constants/constants.dart';

class LoginCredentials extends StatefulWidget {
  const LoginCredentials({Key? key}) : super(key: key);

  @override
  State<LoginCredentials> createState() => _LoginCredentialsState();
}

class _LoginCredentialsState extends State<LoginCredentials> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool hide = true;
  final storage = new FlutterSecureStorage();

  userLogin() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      // print(userCredential.user?.uid);
      //    userCredential.then((value) {
      //   Get.to(const Home());
      // });
      await storage.write(key: "uid", value: userCredential.user?.uid);

      Get.to(Home());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // print("No User Found for that Email");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "No User Found for that Email",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      } else if (e.code == 'wrong-password') {
        //print("Wrong Password Provided by User");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Wrong Password Provided by User",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
          ),
        );
      }
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    // body: Form(

    //  child:
    return Form(
      key: _formKey,
      child: Positioned(
        top: size.height * 0.3,
        left: 0,
        right: 0,
        child: Padding(
          padding: const EdgeInsets.all(appPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello',
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 38, 59, 177)),
              ),
              Text(
                'Let\'s get started',
                style: TextStyle(
                  fontSize: 20,
                  color:
                      const Color.fromARGB(255, 29, 51, 132).withOpacity(0.5),
                  fontWeight: FontWeight.w800,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: appPadding),
                child: ClayContainer(
                  color: white,
                  borderRadius: 30,
                  depth: -50,
                  curveType: CurveType.concave,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: appPadding),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Enter Email',
                        prefixIcon: Icon(Icons.alternate_email_sharp),
                        border: InputBorder.none,
                        fillColor: black,
                        errorStyle:
                            TextStyle(color: Colors.redAccent, fontSize: 15),
                      ),
                      controller: emailController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Email';
                        } else if (!value.contains('@')) {
                          return 'Please Enter Valid Email';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
              ClayContainer(
                color: white,
                borderRadius: 200,
                depth: -50,
                curveType: CurveType.concave,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: appPadding),
                  child: TextFormField(
                    obscureText: hide,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            hide = !hide;
                          });
                        },
                        child: hide
                            ? const Icon(Icons.visibility)
                            : const Icon(Icons.visibility_off),
                      ),
                      prefixIcon: Icon(Icons.lock_outline_sharp),
                      border: InputBorder.none,
                      fillColor: black,
                      errorStyle:
                          TextStyle(color: Colors.redAccent, fontSize: 15),
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Password';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: appPadding / 2),
              //   child: Text(
              //     'Forgot Password?',
              //     style: TextStyle(
              //         fontSize: 15,
              //         color: black.withOpacity(0.6),
              //         fontWeight: FontWeight.w600,
              //         decoration: TextDecoration.underline),
              //   ),
              // )
              const SizedBox(
                height: 20,
              ),
              Center(
                child: ClayContainer(
                  color: white,
                  //height: size.height * 0.3,
                  depth: 60,
                  borderRadius: 200,
                  curveType: CurveType.concave,
                  //spread: 20,
                  customBorderRadius: const BorderRadius.only(
                      topRight: Radius.elliptical(350, 250),
                      topLeft: Radius.elliptical(350, 250),
                      bottomLeft: Radius.elliptical(350, 250),
                      bottomRight: Radius.elliptical(350, 250)),
                  child: Column(
                    children: [
                      // SizedBox(
                      //   height: size.height * 0.07,
                      // ),
                      GestureDetector(
                        child: const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: appPadding / 2,
                              horizontal: appPadding * 2),
                          child: Text(
                            'LogIn',
                            style: TextStyle(
                                color: Colors.indigoAccent,
                                fontWeight: FontWeight.w800,
                                fontSize: 23),
                          ),
                        ),
                        onTap: () {
                          // Validate returns true if the form is valid, otherwise false.
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                            });
                            userLogin();
                          }
                        },
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: appPadding),
                      //   child: Text(
                      //     'SignUp',
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.w800,
                      //         fontSize: 17,
                      //         decoration: TextDecoration.underline),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ); //   ),
    // );
  }
}
