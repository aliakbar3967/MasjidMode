import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:peace_time/NavigationScreen.dart';
import 'package:peace_time/constant.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/job/ForgroundService.dart';

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
        await ForgroundService.startForgroundService();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) => NavigationScreen()));
    }
  }

  Widget _buildImage({String assetName, double width = 100.0}) {
    return Align(
      child: Image.asset(assetName, width: width),
      alignment: Alignment.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(
      fontSize: 19.0,
      // color: Colors.deepPurple,
    );
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w700,
        // color: Colors.deepPurple.shade100
      ),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      // pageColor: Colors.deepPurple,
      imagePadding: EdgeInsets.zero,
      fullScreen: false,
    );

    var introductionScreen = IntroductionScreen(
      key: introKey,
      globalBackgroundColor: Colors.grey.shade100,
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
          image: _buildImage(assetName: Constant.APPICON),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Quick Silent",
          body:
              "One tap to silent your phone from now to next 30 or custom minutes.",
          image: _buildImage(assetName: Constant.APPICON),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Only Permission",
          body:
              "Please allow do not disturb mode.\n Otherwise, your phone will not turn on silent or vibrate mode according to your schedule.",
          image: _buildImage(assetName: 'assets/donotdisturb.png', width: 300),
          footer: OutlinedButton(
            onPressed: () async =>
                await SettingsController.openDoNotDisturbSettings(),
            child: Text('Open Settings'),
            autofocus: true,
            style: OutlinedButton.styleFrom(
                shape: StadiumBorder(),
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
    // print(Theme.of(context).brightness);

    return introductionScreen;
  }
}
