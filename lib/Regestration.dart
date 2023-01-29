
import 'package:fitness/LoginScreen.dart';
import 'package:fitness/User_info.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';












class Registration extends StatefulWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  MyStatefulWidget(),

    );
  }
}
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController studentnumberController = TextEditingController();
  TextEditingController passwordconfirmationController = TextEditingController();
  String erreur ='';




  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),

        child: ListView(

          children: <Widget>[

            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  'Fitness UEMF',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  '',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                  hintText: 'Enter your email',


                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: studentnumberController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Student number',
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Full name',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextField(


                obscureText: true,
                controller: passwordconfirmationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Password confirmation',

                ),
              ),
            ),
            SizedBox(height: 30,),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Sign in'),
                  onPressed: () async {


                    UserCredential userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text);

                     String userId = userCredential.user!.uid;
                     final user_info = User_info(emailController.text, nameController.text, studentnumberController.text,"https://i.stack.imgur.com/l60Hf.png");
                    await FirebaseFirestore.instance.collection("users").doc(userId).set(user_info.toFirestore());


                  },
                )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
               const Text('Already have an account?'),
                TextButton(
                  child: const Text(
                    'Login ',
                    style: TextStyle(fontSize: 20),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                  },
                )
              ],
            ),
          ],
        ));
  }
}