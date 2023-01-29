import 'package:firebase_auth/firebase_auth.dart';


import 'package:flutter/material.dart';

import 'Bottom.dart';
import 'Regestration.dart';







FirebaseAuth auth = FirebaseAuth.instance;



class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {


  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(10),

          child: ListView(

            children: <Widget>[

              Container(

                width: 100.0,
                height: 150.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://th.bing.com/th/id/OIP.5zMhAtTDQFyos9sB_-Ho9AHaDm?w=314&h=170&c=7&r=0&o=5&dpr=1.3&pid=1.7",
                      ), )
                ),

              ),
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
                    'Sign in',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
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
              TextButton(
                onPressed: () {
                  //forgot password screen
                },
                child: const Text('Forgot Password',),
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Login'),
                    onPressed: () async{

                                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: nameController.text, password: passwordController.text);
                                      String userId = userCredential.user!.uid;
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Bottom()));
                                      print('User signed in with ID: $userId');

                    },
                  )
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Does not have account?'),
                  TextButton(
                    child: const Text(
                      'Sign up',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Registration()));
                    },
                  )
                ],
              ),
            ],
          )),
    );
  }
}

String validatePassword(String value) {
  if (!(value.length > 5)) {
    return "Password should contain more than 5 characters";
  }
  return '';
}
