import 'package:flutter/material.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/provider/SettingsProvider.dart';
import 'package:peace_time/screen/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() {
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
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Peace Time',
      theme: ThemeData.light(),
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   primaryColor: Colors.white,
      //   brightness: Brightness.light,
      //   accentColor: Colors.black,
      //   accentIconTheme: IconThemeData(color: Colors.white),
      //   dividerColor: Colors.white54,
      //   scaffoldBackgroundColor: Colors.grey[200],
      //   backgroundColor: Colors.white,
      // ),
      darkTheme: ThemeData.dark(),
      // darkTheme: ThemeData(
      //   primarySwatch: Colors.blue,
      //   primaryColor: Colors.black,
      //   brightness: Brightness.dark,
      //   accentColor: Colors.white,
      //   accentIconTheme: IconThemeData(color: Colors.black),
      //   dividerColor: Colors.black12,
      //   scaffoldBackgroundColor: Colors.black,
      //   backgroundColor: Colors.grey.shade900,
      //   cardColor: Colors.grey[850],
      // ),
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      // home: NavigationScreen(),
      home: SplashScreen(),
    );
  }
}
