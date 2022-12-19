import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddRDV extends StatefulWidget {
  const AddRDV({Key? key}) : super(key: key);

  @override
  State<AddRDV> createState() => _AddRDVState();
}

class _AddRDVState extends State<AddRDV> {

  FirebaseFirestore db = FirebaseFirestore.instance;


  late var d = DateTime.now();
  late var weekDay = d.weekday;
  late var firstDayOfWeek = d.subtract(Duration(days: weekDay));

  final DateFormat formatter = DateFormat('yyyy-MM-dd');

  late String monday = formatter.format(firstDayOfWeek.add(Duration(days: 1)));
  late String tuesday = formatter.format(firstDayOfWeek.add(Duration(days: 2)));
  late String wednesday = formatter.format(firstDayOfWeek.add(Duration(days: 3)));
  late String thursday = formatter.format(firstDayOfWeek.add(Duration(days: 4)));
  late String friday = formatter.format(firstDayOfWeek.add(Duration(days: 5)));

   late String hour_rdv;
   bool isClicked = true;

   @override
  void initState() {
     hour_rdv="0";
    super.initState();

  }





  final info = <String, String>{
    "name": "Rahhal",
    "last name": "El boudali",
    "country": "USA",

  };



  Widget days(String s,String day) {
    return  Expanded(
      child: ElevatedButton(
        child:  Text(s+" "+day),
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.purple)))),
        onPressed: () {
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

                      SizedBox(height: 20,),
                      Row(
                        children: [
                          hour("4->5"),
                          SizedBox(width: 20,),
                          hour("5->6"),
                          SizedBox(width: 20,),
                          hour("6->7"),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        children: [
                          hour("7->8"),
                          SizedBox(width: 20,),
                          hour("8->9"),
                          SizedBox(width: 20,),
                          hour("9->10"),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Text(hour_rdv),
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

                              onPressed: () {
                                db.collection("Reservation/"+day).doc(hour_rdv).set(info);
                              },
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
  Widget hour(String s) {
    return Expanded(
      child: Expanded(
        child: ElevatedButton(

          style: ButtonStyle(
            shape: MaterialStateProperty.all(CircleBorder()),
            padding: MaterialStateProperty.all(EdgeInsets.all(30)),
            backgroundColor: MaterialStateProperty.all(Colors.blue), // <-- Button color
            overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
              if (states.contains(MaterialState.pressed)) return Colors.red; // <-- Splash color
            }),
          ),


          onPressed: (){
            setState((){
              hour_rdv = s;
            });
            print(hour_rdv);
          },

          child:  Text(s),
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddRDV"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  days("Monday", monday)
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  days("Tuesday",tuesday),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  days("Wednesday",wednesday),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                 days("Thursday",thursday),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                children: [
                  days("Friday",friday),
                ],
              ),
            ],
          ),
        ),
      ),
    );





  }
}
