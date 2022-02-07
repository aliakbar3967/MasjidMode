import 'package:peace_time/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DBController {
  static Future<bool> getIntroductionScreenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    return prefs.getBool(Constant.SP_INTRODUCTION) == true ? true : false;
  }

  static Future<void> toggleIntroductionScreenStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    await prefs.setBool(Constant.SP_INTRODUCTION, value);
  }

  static Future<bool> getDarkModeStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    bool value = prefs.containsKey(Constant.SP_DARKMODE);
    if (value == false) {
      await toggleDarkModeStatus(false);
      return false;
    } else {
      return prefs.getBool(Constant.SP_DARKMODE) == true ? true : false;
    }
  }

  static Future<void> toggleDarkModeStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    await prefs.setBool(Constant.SP_DARKMODE, value);
  }

  static Future<bool> getDefaultSchedulesStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    return prefs.getBool(Constant.SP_INTRODUCTION) == true ? true : false;
  }

  static Future<bool> setDefaultSchedulesStatus(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    return prefs.setBool(Constant.SP_DEFAULT_SCHEDULE, value);
  }

  static Future<String?> getSchedules() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    return prefs.getString(Constant.SP_SCHEDULES);
  }

  static Future<void> setSchedules(String string) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    await prefs.setString(Constant.SP_SCHEDULES, string);
  }

  static Future<bool> getNormalPeriod() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    return prefs.getBool(Constant.SP_NORMAL_PERIOD) == true ? true : false;
  }

  static Future<void> setNormalPeriod(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    await prefs.setBool(Constant.SP_NORMAL_PERIOD, value);
  }

  static Future<int> getDefaultSilentMinute() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    int? minute = prefs.getInt(Constant.SP_DEFAULT_SILENT_MINUTE);
    return minute == null ? 0 : minute;
  }

  static Future<void> setDefaultSilentMinute(int value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
    await prefs.setInt(Constant.SP_DEFAULT_SILENT_MINUTE, value);
  }

  static Future<void> reset() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.reload();
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
    prefs.reload();
    // final reset = prefs.getBool(Constant.SP_RESET);
    await prefs.clear();
    await prefs.setBool(Constant.SP_RESET, true);
  }
}
