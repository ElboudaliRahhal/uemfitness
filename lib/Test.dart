import 'package:flutter/material.dart';





class Test extends StatefulWidget {
  const Test( {Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {



  int currentIndex = 0;
  int selectedItem = 0;

  void onIteamTap(int index){
    setState((){
      selectedItem = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("hi"),
      ),
      /*
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 2.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: kBottomNavigationBarHeight,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Colors.grey,
                  width: 0.5,
                ),
              ),
            ),
            child: BottomNavigationBar(
                currentIndex: selectedItem,
                backgroundColor: Colors.blue,
                selectedItemColor: Colors.white,
                onTap: onIteamTap,
                items: [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.category), label: 'Category'),
                  BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.account_circle), label: 'Account')
                ]),
          ),
        ),
      ),
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FloatingActionButton(
          backgroundColor: selectedItem == 1 ? Colors.blue : Colors.blueGrey,
          child: Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(


              isScrollControlled: true,
                context: context,
                builder: (BuildContext context){
                  return Container(
                    child: SingleChildScrollView(
                      child: Stepper(
                        physics: ScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
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
                            this.currentIndex = index;
                          });
                        },
                        steps: [
                          Step(title: Text("choose a day") ,
                              content: Container(

                              )
                          ),
                          Step(
                              title: Text("choose time"),
                              content: Container(),
                          )
                        ],
                      ),
                    ),
                  );
            }
            );
          }
        ),
      ),

       */
    );

  }
}
