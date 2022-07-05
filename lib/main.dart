import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          elevation: 2,
          // titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20)
        ),
        primarySwatch: Colors.indigo,
        backgroundColor: Colors.indigo.shade100,
        scaffoldBackgroundColor: Colors.grey.shade100,
        chipTheme: ChipThemeData(
          selectedColor: Colors.indigo,
        ),
        progressIndicatorTheme:
            const ProgressIndicatorThemeData(color: Colors.indigo),
        cardTheme: CardTheme(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: const Radius.circular(15.0),topRight: const Radius.circular(15.0)),
          ),
        ),
        dividerColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        appBarTheme: AppBarTheme(elevation: 2),
        brightness: Brightness.dark,
        chipTheme: ChipThemeData(
          selectedColor: Colors.cyanAccent,
        ),
        cardTheme: CardTheme(
          elevation: 0,
          margin: const EdgeInsets.symmetric(vertical: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        listTileTheme: ListTileThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: const Radius.circular(15.0),topRight: const Radius.circular(15.0)),
          ),
        ),
        dividerColor: Colors.transparent,
      ),
      themeMode: Provider.of<SettingsProvider>(context).settings.darkMode
          ? ThemeMode.dark
          : ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
