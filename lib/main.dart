import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/screens/home_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScheduleController()),
        // Provider<ScheduleController>(create: (context) => ScheduleController())
      ],
      child: App(),
    ),
  );
}

class App extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: context.watch<ScheduleController>().isIntroductionDone 
        // ? HomeScreen()
        // : OnBoardingScreen(),
      // home: OnBoardingScreen(),
      home: SplashScreen(),
      // home: HomeScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  void navigating() async {
    final bool out = await ScheduleController.getIntroductionScreenStatus();
    if(out == false) {
      setState(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      });
    } else {
      setState(() {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => OnBoardingScreen()));
      });
    }
  }

  @override
  void initState() {
    navigating();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.grey[200],body: Center(child: CupertinoActivityIndicator(),));
  }
}

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    // Navigator.of(context).push(
    //   MaterialPageRoute(builder: (_) => HomeScreen()),
    // );
    Provider.of<ScheduleController>(context,listen: false).setIntroductionDone(value: false);
    if(await SettingsController.isRunningForgroundService() == false)
    {
      await SettingsController.startForgroundServiceAndTask();
    }
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (BuildContext context) => SplashScreen()));
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/logo.png', width: 350.0),
      alignment: Alignment.bottomCenter,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Welcome to Peace Time",
          body: "An Auto Silent Scheduler",
          image: _buildImage('img1'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Settings things up",
          body: "Please allow do not disturb mode.",
          image: _buildImage('img2'),
          footer: OutlinedButton (
            onPressed: () async => await SettingsController.openDoNotDisturbSettings(),
            child: Text(
              'Open Settings', 
              style: TextStyle(
                color: Colors.blue
              ),
            ),
            autofocus: true,
            style: OutlinedButton.styleFrom(
              shape: StadiumBorder(),
              side: BorderSide(width: 2, color: Colors.blue),
              padding: EdgeInsets.symmetric(horizontal:32, vertical: 10)
            ),
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Go', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}