import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/screen/ErrorScreen.dart';
import 'package:peace_time/screen/HelpScreen.dart';
import 'package:peace_time/screen/HomeScreen.dart';
import 'package:peace_time/screen/SettingsScreen.dart';

class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  // SpeedDialController _controller = SpeedDialController();
  int _cIndex = 0;

  void _incrementTab(index) {
    setState(() {
      _cIndex = index;
    });
  }

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return new HomeScreen();
      case 1:
        return new SettingsScreen();
      case 2:
        return new HelpScreen();
      // case 3:
      //   return new AppIntroductionScreen();
      // case 4:
      //   return new SplashScreen();

      default:
        return new ErrorScreen();
    }
  }

  void navigating() async {
    final bool out = await DBController.getIntroductionScreenStatus();
    if (out == false || out == null) {
      _incrementTab(0);
    } else {
      _incrementTab(3);
    }
  }

  @override
  void initState() {
    // navigating();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _getDrawerItemWidget(_cIndex);
    // return new Scaffold(
    // appBar: new AppBar(
    //   elevation: 0,
    //   title: new Text("Peace Time"),
    //   actions: [
    //     dropDownMenus(),
    //   ],
    // ),
    // body: new Center(
    //   child: new Column(
    //     mainAxisAlignment: MainAxisAlignment.center,
    //     children: <Widget>[],
    //   ),
    // ),
    // body: _getDrawerItemWidget(_cIndex),
    // bottomNavigationBar: BottomNavigationBar(
    //   selectedItemColor: Colors.green,
    //   currentIndex: _cIndex,
    //   type: BottomNavigationBarType.fixed,
    //   items: [
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.home),
    //       label: "Home",
    //     ),
    //     BottomNavigationBarItem(
    //       icon: Icon(Icons.settings),
    //       label: "Settings",
    //     )
    //   ],
    //   onTap: (index) {
    //     _incrementTab(index);
    //   },
    // ),
    // floatingActionButton: new FloatingActionButton(
    //   onPressed: () {
    //     _incrementTab(1);
    //   },
    //   tooltip: 'Increment',
    //   child: new Icon(Icons.add),
    // ),
    // );
  }
}
