import 'package:cloud_firestore/cloud_firestore.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:perfex_e_learning/controllers/appcontroller.dart';

AppController appController = AppController.instance;
final Future<FirebaseApp> firebaseInitialization = Firebase.initializeApp();
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
