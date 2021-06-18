import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peace_time/NavigationScreen.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/screen/AppIntroductionScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> navigating() async {
    final bool out = await DBController.getIntroductionScreenStatus();
    if (out == false) {
      setState(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => NavigationScreen()));
      });
    } else {
      setState(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => AppIntroductionScreen()));
      });
    }
  }

  Future<void> initialize() async {
    await DBController.reset();
    await navigating();
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // To make this screen full screen.
    // It will hide status bar and notch.
    // SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: CupertinoActivityIndicator(
          radius: 20.0,
        ),
      ),
    );
  }
}
