import 'package:fitness/AddRDV.dart';

import 'package:firebase_core/firebase_core.dart';
import 'AccountPage.dart';
import 'firebase_options.dart';
import 'package:fitness/Bottom.dart';

import 'package:fitness/Test.dart';

import 'package:flutter/material.dart';

import 'HomePage.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: Bottom(),
  ));
}