import 'package:flutter/material.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int currentIndex =0;
  int selectedItem = 0;

  void onIteamTap(int index){
    setState((){
      selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(),
      body: Stepper(

        currentStep: currentIndex,
        onStepCancel: (){
          if(currentIndex>0){
            setState((){
              currentIndex -=1;
            });
          }
        },
        onStepContinue: (){
          if(currentIndex<1){
            setState((){
              currentIndex +=1;
            });
          }
        },
        onStepTapped: (int index){
          setState((){
            currentIndex = index;
          });
        },
        steps: [
          Step(title: Text("choose a day") ,
              content: Container(
                  child: Column(
                    children: [
                      Text("you can't chose more than 3 "),


                    ],
                  ),
              )
          ),
          Step(
            title: Text("choose time"),
            content: Container(),
          )
        ],
      ),
/*
      bottomNavigationBar: BottomNavigationBar(
        onTap: onIteamTap,
        currentIndex: selectedItem,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: "fitness",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "account",
          ),
        ],
      ),

 */
    );
  }
}
