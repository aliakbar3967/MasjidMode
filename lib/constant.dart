import 'package:flutter/material.dart';

class Constant {
  static const Map<int, String> dayNames = {
    1: 'monday',
    2: 'tuesday',
    3: 'wednesday',
    4: 'thursday',
    5: 'friday',
    6: 'saturday',
    7: 'sunday',
  };

  static const String SP_SCHEDULES = "__schedules";
  static const String SP_DEFAULT_SCHEDULE = "__default_schedule";
  static const String SP_NORMAL_PERIOD = "__normal__period";
  static const String SP_INTRODUCTION = "__intro";
  static const String SP_DARKMODE = "__dark_mode";
  static const String SP_RESET = "__reset_v8";
  static const String SP_DEFAULT_SILENT_MINUTE = "__default_silent_minute";

  static const int ARC_REACTOR_ID = 10000000;
  static const int NORMAL_MODE_ID = 99999999;

  static const EMPTY_SVG = 'assets/empty.svg';

  static const APPICON = 'assets/ic_launcher.png';
  static const APPICON_SVG = 'assets/ic_launcher.svg';

  static ThemeData lightMode = ThemeData(
    // appBarTheme: AppBarTheme(
    //   elevation: 2,
    //   // titleTextStyle: TextStyle(color: Colors.black87, fontSize: 20)
    // ),
    primarySwatch: Colors.indigo,
    backgroundColor: Colors.indigo.shade100,
    scaffoldBackgroundColor: Colors.grey.shade100,
    chipTheme: ChipThemeData(
      selectedColor: Colors.indigoAccent,
      // backgroundColor: Colors.indigo
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
  );

  static ThemeData darkMode = ThemeData(
    // primarySwatch: Colors.cyan,
    primaryColor: Colors.cyan,
    // backgroundColor: Colors.indigo.shade100,
    // scaffoldBackgroundColor: Colors.grey.shade100,
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
  );
}
