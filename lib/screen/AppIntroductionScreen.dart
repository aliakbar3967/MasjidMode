import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:peace_time/NavigationScreen.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/job/ForgroundService.dart';
import 'package:flutter/cupertino.dart';

class AppIntroductionScreen extends StatefulWidget {
  @override
  _AppIntroductionScreenState createState() => _AppIntroductionScreenState();
}

class _AppIntroductionScreenState extends State<AppIntroductionScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) async {
    if (await SettingsController.getPermissionStatus() == false) {
      await SettingsController.openDoNotDisturbSettings();
    } else {
      await DBController.toggleIntroductionScreenStatus(false);

      if (await ForgroundService.isRunningForgroundService() == false) {
        await ForgroundService.startForgroundServiceAndTask();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => NavigationScreen()));
    }
  }

  Widget _buildImage({String assetName, double width = 300.0}) {
    return Align(
      child: Image.asset(assetName, width: width),
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 19.0,
      // color: Colors.blue,
    );
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        // color: Colors.blue
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.blue,
      imagePadding: EdgeInsets.zero,
    );

    var introductionScreen = IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.blue,
      color: Colors.black,
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('SKIP'),
      next: const Icon(Icons.arrow_forward),
      done: const Text('START', style: TextStyle(fontWeight: FontWeight.w600)),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Colors.black45,
        activeColor: Colors.black,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      pages: [
        PageViewModel(
          title: "Welcome",
          body:
              "Keep your phone silent\n when you are busy and stay safe from embarrassing moments.",
          image: _buildImage(assetName: 'assets/circle.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "30m Quick Silent",
          body: "One tap to silent your phone from now to next 30 minutes.",
          image:
              _buildImage(assetName: 'assets/30mquicksilent.png', width: 275.0),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Only Permission",
          body:
              "Please allow do not disturb mode.\n Otherwise, your phone will not turn on silent or vibrate mode according to your schedule.",
          image: _buildImage(assetName: 'assets/donotdisturb.png'),
          footer: OutlinedButton(
            onPressed: () async =>
                await SettingsController.openDoNotDisturbSettings(),
            child: Text(
              'Open Settings',
              style: TextStyle(color: Colors.white),
            ),
            autofocus: true,
            style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
                side: BorderSide(width: 2, color: Colors.white70),
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 10)),
          ),
          decoration: pageDecoration,
        ),
      ],
    );

    // to hide only bottom bar:
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);

    // to hide only status bar:
    // SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    // to hide both:
    // SystemChrome.setEnabledSystemUIOverlays([]);

    return introductionScreen;
  }
}
