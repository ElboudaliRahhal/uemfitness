
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/User_info.dart';

import 'package:fitness/Tofirebase.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddRDV extends StatefulWidget {
  const AddRDV({Key? key}) : super(key: key);

  @override
  State<AddRDV> createState() => _AddRDVState();
}

class _AddRDVState extends State<AddRDV> {




  bool isPassed4 = false;
  bool pass12 = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth userCredential =  FirebaseAuth.instance;


  Map <String,dynamic> mymap = Map();
  Map<String, dynamic> map12 = Map();



  late var d = DateTime.now();
  late var weekDay = d.weekday;
  late var firstDayOfWeek = d.subtract(Duration(days: weekDay));

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  late String monday = formatter.format(firstDayOfWeek.add(Duration(days: 1)));
  late String tuesday = formatter.format(firstDayOfWeek.add(Duration(days: 2)));
  late String wednesday = formatter.format(firstDayOfWeek.add(Duration(days: 3)));
  late String thursday = formatter.format(firstDayOfWeek.add(Duration(days: 4)));
  late String friday = formatter.format(firstDayOfWeek.add(Duration(days: 5)));
  late String saturday = formatter.format(firstDayOfWeek.add(Duration(days: 6)));

 late var today = formatter.format(d);




    

    int hour_rdv = 0;
   bool isClicked = true;

   enable(int s,String day)  {

      hour_rdv = s;
    print(hour_rdv);
  }

void _upload(BuildContext context,String day)  {
    FirebaseAuth userCredential =  FirebaseAuth.instance;
    String currentUser = userCredential.currentUser!.uid;
      final docRef =  db.collection("users").doc(currentUser);
      docRef.get().then(
            (DocumentSnapshot doc)  {
          final data = doc.data() as Map<String, dynamic>;


          final rdv = Tofirebase(data["full name"],data["email"],data["matricule"], day, hour_rdv.toString(), currentUser);
           FirebaseFirestore.instance.collection("Reservation").doc("$day").collection(hour_rdv.toString()).doc(currentUser).set(rdv.toFirestore());

        },
        onError: (e) => print("Error getting document: $e"),
      );
      setState(() {

      });

}

  Widget days(String s,String day, bool isPassed) {
    return  Expanded(
      child: ElevatedButton(
        child:  Text(s+" "+day),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.purple)))),
        onPressed: (mymap.containsKey(day)  || isPassed4) ? null : () {

          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(50.0),
              ),
            ),
            context: context,
            builder: (context) => Container(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text("choose an hour for this day : $day"),
                      SizedBox(height: 30,),
                      Row(
                        children: [
                          hour(4,day),
                          SizedBox(width: 20,),
                          hour(5,day),
                          SizedBox(width: 20,),
                          hour(6,day),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          hour(7,day),
                          SizedBox(width: 20,),
                          hour(8,day),
                          SizedBox(width: 20,),
                          hour(9,day),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(hour_rdv.toString()),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all<OutlinedBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(18.0),
                                          side: BorderSide(color: Colors.purple)
                                      )
                                  ),
                                  backgroundColor: MaterialStateProperty.all(Colors.pink)
                              ),

                              onPressed: () => _upload(context, day),


                              child: const Text('upload'),
                            ),
                          ),
                        ],
                      ),
                    ],

                  ),
                )
            ),

          );
          

        },

      ),
    );
  }
  Widget hour(int s,String day) {
    return Expanded(
        child: ElevatedButton(

          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            padding: MaterialStateProperty.all(EdgeInsets.all(30)),
            backgroundColor: MaterialStateProperty.all(Colors.blue), // <-- Button color
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) return Colors.red; // <-- Splash color
            }),
          ),

          onPressed: (map12[day]==s.toString())? null : () => enable(s,day),

          child:  Text(s.toString()),
        ),

    );
  }

  Future<void> _futureTask() async {


    String currentUser = userCredential.currentUser!.uid;

      for(int i=1;i<=5;i++){
        for(int j=4;j<=9;j++){


          var  _querySnapshot =   db
              .collection("Reservation")
              .doc(formatter.format(firstDayOfWeek.add(Duration(days: i))))
              .collection(j.toString())
              .get();


          _querySnapshot.then((snapshot) {
            if (snapshot.docs.length >= 2) {
              map12[formatter.format(firstDayOfWeek.add(Duration(days: i)))] = j.toString();
            }
          });

          print("pass12 $pass12");
          print("map12");
          print(map12);



          //--------------------- for list days and hours ----------------
        await  db.collection('Reservation')
              .doc(formatter.format(firstDayOfWeek.add(Duration(days: i))))
              .collection(j.toString())
              .doc(currentUser)
              .get()
              .then((DocumentSnapshot documentSnapshot)  {

            if (documentSnapshot.exists) {


              if (!mymap.containsKey(formatter.format(firstDayOfWeek.add(Duration(days: i))))) {
                mymap[formatter.format(firstDayOfWeek.add(Duration(days: i)))] = j.toString();
              }

              print(mymap.length);

              print(mymap);
              if(mymap.length >= 4){
                isPassed4 = true;
                print(isPassed4);
              }

            } else {
              print(documentSnapshot.toString());
              print('Document does not exist on the database');

            }
          });
        }
      }

    await Future.delayed(Duration(seconds: 5));

  }


  @override
  Widget build(BuildContext context) {



    //----------------------------------------------------------   ila daz nhar -------------------------------------------------
    var mondayPass = d.compareTo(firstDayOfWeek.add(Duration(days: 1)));
    var tuesdayPass = d.compareTo(firstDayOfWeek.add(Duration(days: 2)));
    var wednesdayPass = d.compareTo(firstDayOfWeek.add(Duration(days: 3)));
    var thursdayPass = d.compareTo(firstDayOfWeek.add(Duration(days: 4)));
    var fridayPass = d.compareTo(firstDayOfWeek.add(Duration(days: 5)));
    var saturdayPass = d.compareTo(firstDayOfWeek.add(Duration(days: 6)));
    bool ismondayPass = false;
    bool istuesdayPass = false;
    bool iswednesdayPass = false;
    bool isthursdayPass = false;
    bool isfridayPass = false;
    bool issaturdayPass = false;

    if(mondayPass>0) ismondayPass = true;
    if(tuesdayPass>0) istuesdayPass = true;
    if(wednesdayPass>0) iswednesdayPass = true;
    if(thursdayPass>0) isthursdayPass = true;
    if(fridayPass>0) isfridayPass = true;
    if(saturdayPass>0) issaturdayPass = true;


    return Scaffold(
      appBar: AppBar(
        title: Text("AddRDV"),
        centerTitle: true,
      ),
      body: FutureBuilder(
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

                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        days("Monday", monday,ismondayPass)
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        days("Tuesday",tuesday,istuesdayPass),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        days("Wednesday",wednesday, iswednesdayPass),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        days("Thursday",thursday,isthursdayPass),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        days("Friday",friday,isfridayPass),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        days("Saturday",saturday,issaturdayPass),
                      ],
                    ),
                  ],
                ),
              ),
            );
          } else {
            return  Center(
              child: Text("An error occurred"),
            );
          }
        },
      ),
    );



  }
}
