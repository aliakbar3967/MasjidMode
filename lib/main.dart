import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:peace_time/job/ForgroundService.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/provider/SettingsProvider.dart';
import 'package:peace_time/screen/SplashScreen.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    // systemNavigationBarColor: Colors.transparent,
    // systemNavigationBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  initializeService();
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
}

class App extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Peace Time',
      theme: ThemeData(
        appBarTheme: AppBarTheme(elevation: 2),
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
