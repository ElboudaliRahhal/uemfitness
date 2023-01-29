import 'package:flutter/material.dart';

import 'accountInfo.dart';
import 'armsExerciseScreen.dart';
import 'chestExerciseScreen.dart';




class WorkOut extends StatelessWidget {
  final List<String> buttonTitles = [
    'Chest',
    'Arms',
    'Back',
    'Abs',
    'Legs',
    'Shoulders'
  ];

  final List<String> images = [
    'assets/images/chest.png',
    'assets/images/arms.png',
    'assets/images/back.png',
    'assets/images/abs.png',
    'assets/images/legs.png',
    'assets/images/shoulders.png'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 70),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top:15),
              child: Text('Exercises',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,

                  )),
            ),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                children: List.generate(buttonTitles.length, (index) {
                  return InkWell(
                    onTap: () {
                      switch (index) {
                        case 0:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GifScreen()),
                          );
                          break;
                        case 1:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ArmsExerciseScreen()),
                          );
                          break;
                        case 2:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GifScreen()),
                          );
                          break;
                        case 3:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ArmsExerciseScreen()),
                          );
                          break;
                        case 4:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => GifScreen()),
                          );
                          break;
                        case 5:
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ArmsExerciseScreen()),
                          );
                          break;
                      // Add cases for other buttons
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 2),
                          borderRadius: BorderRadius.circular(50)
                      ),
                      margin: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(images[index]),
                          Text(buttonTitles[index]),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}