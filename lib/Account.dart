import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'Util.dart';




class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  String _username= "";
  String _email= "";
  String imageUrl = "";
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth userCredential =  FirebaseAuth.instance;

  Uint8List? _image;

  String profilUrl = "";



  selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });

   String profileUrl = await uploadImageToStorage("profile", _image!);

    String currentUser = userCredential.currentUser!.uid;

   await db.collection("users").doc(currentUser).update({"profilUrl":profileUrl});

  }


  Future<void> _futureTask() async {


    String currentUser = userCredential.currentUser!.uid;




    final docRef =  await db.collection("users").doc(currentUser);
    docRef.get().then(
          (DocumentSnapshot doc)  {
        final data = doc.data() as Map<String, dynamic>;

       profilUrl = data["profilUrl"];
       _username = data["full name"];
       _email = data["email"];


      },
      onError: (e) => print("Error getting document: $e"),
    );

    await Future.delayed(Duration(seconds: 5));


  }



  @override
  Widget build(BuildContext context) {

    String currentUser = userCredential.currentUser!.uid;


    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: _futureTask(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return  Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              // Move on to the next screen
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      SizedBox(height: 20,),
                      Stack(
                        children: [
                          _image !=null  ? CircleAvatar(
                            radius: 64,
                            backgroundImage: MemoryImage(_image!),
                          )
                              :
                              CircleAvatar(
                                radius: 64,
                                backgroundImage: NetworkImage(profilUrl),
                              ),
                          Positioned(
                              bottom: -4,
                              left: 90,
                              child: IconButton(
                            onPressed: selectImage,
                            icon: Icon(
                              Icons.add_a_photo,
                            ),
                          ))
                        ],
                      ),

                      SizedBox(height: 40,),
                      Text(_username),
                  SizedBox(height: 20,),
                   Text(_email),


                  SizedBox(height: 40,),
                      SizedBox(
                        height: 400,
                        child: CircleAvatar(
                          radius: 64,
                          backgroundImage: NetworkImage("https://firebasestorage.googleapis.com/v0/b/uemfitness.appspot.com/o/logo%2Fdownload.jpeg?alt=media&token=1d490646-f35b-4393-b51f-70880c0699ce"),
                        ),
                      )



                    ],
                  )
                ),
              );
            } else {
              return  Center(
                child: Text("An error occurred"),
              );
            }
          },
        ),
      ),

    );
  }
}

