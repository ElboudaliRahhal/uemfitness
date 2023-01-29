
import 'package:firebase_core/firebase_core.dart';
import 'package:fitness/LoginScreen.dart';

import 'firebase_options.dart';
import 'package:flutter/material.dart';






void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MaterialApp(
    home: LoginScreen(),
  ));
}