import 'package:fitness/AccountPage.dart';
import 'package:fitness/AddRDV.dart';

import 'package:fitness/HomePage.dart';
import 'package:fitness/Test.dart';
import 'package:flutter/material.dart';





class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => _BottomState();
}

class _BottomState extends State<Bottom> {




  int selectedItem = 0;

  void onIteamTap(int index){
    setState((){
      selectedItem = index;
    });
  }

  List<Widget> _pages = <Widget>[];
  @override
  void initState() {

    _pages.add(Test());
    _pages.add(AddRDV());
    _pages.add(HomePage());
   // _pages.add(AccountPage());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedItem],
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
          onPressed: () => setState(() {
            selectedItem = 1;
          }),
        ),
      ),
    );

  }
}
