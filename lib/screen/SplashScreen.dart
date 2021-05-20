import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/NavigationScreen.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/screen/AppIntroductionScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void navigating() async {
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

  @override
  void initState() {
    navigating();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CupertinoActivityIndicator(
        radius: 20.0,
      ),
    ));
  }
}
