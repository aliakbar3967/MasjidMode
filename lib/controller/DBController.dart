import 'package:peace_time/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBController {
  static Future<bool> getIntroductionScreenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constant.SP_INTRODUCTION);
  }

  static Future<void> toggleIntroductionScreenStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constant.SP_INTRODUCTION, value);
  }

  static Future<bool> getDarkModeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool value = prefs.containsKey(Constant.SP_DARKMODE);
    if (value == null || value == false) {
      await toggleDarkModeStatus(false);
      return false;
    } else {
      return prefs.getBool(Constant.SP_DARKMODE);
    }
  }

  static Future<void> toggleDarkModeStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constant.SP_DARKMODE, value);
  }

  static Future<bool> getDefaultSchedulesStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constant.SP_INTRODUCTION);
  }

  static Future<bool> setDefaultSchedulesStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(Constant.SP_DEFAULT_SCHEDULE, value);
  }

  static Future<String> getSchedules() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(Constant.SP_SCHEDULES);
  }

  static Future<void> setSchedules(String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constant.SP_SCHEDULES, string);
  }

  static Future<bool> getNormalPeriod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(Constant.SP_NORMAL_PERIOD);
  }

  static Future<void> setNormalPeriod(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(Constant.SP_NORMAL_PERIOD, value);
  }

  static Future<void> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final reset = prefs.getBool(Constant.SP_RESET);
    if (reset == null || reset == false) {
      // await prefs.clear();
      await prefs.remove(Constant.SP_SCHEDULES);
      // await prefs.setString(Constant.SP_SCHEDULES, '');
      await prefs.setBool(Constant.SP_RESET, true);
    } else {
      await prefs.setBool(Constant.SP_RESET, true);
    }
  }

  static Future<void> restore() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // final reset = prefs.getBool(Constant.SP_RESET);
    await prefs.clear();
    await prefs.setBool(Constant.SP_RESET, true);
  }
}
