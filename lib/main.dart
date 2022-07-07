import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peace_time/NavigationScreen.dart';
import 'package:peace_time/constant.dart';
import 'package:peace_time/job/Algorithm.dart';
import 'package:peace_time/job/MyAlarmManager.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/provider/SettingsProvider.dart';
import 'package:peace_time/screen/SplashScreen.dart';
import 'package:provider/provider.dart';

void arcReactor() async => await algorithm();

void main() async {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    // systemNavigationBarColor: Colors.transparent,
    // systemNavigationBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  // initializeService();
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
        // Provider<ScheduleController>(create: (context) => ScheduleController())
      ],
      child: App(),
    ),
  );
  await AndroidAlarmManager.periodic(
      const Duration(minutes: 1), Constant.ARC_REACTOR_ID, arcReactor);
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Peace Time',
      theme: Constant.lightMode,
      darkTheme: Constant.darkMode,
      themeMode: Provider.of<SettingsProvider>(context).settings.darkMode
          ? ThemeMode.dark
          : ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: NavigationScreen(),
    );
  }
}
