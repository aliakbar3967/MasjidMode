
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/ScheduleController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/helper/MyNotification.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class MyAlarmManager {
  Future<void> setOneShot(int id, RingerModeStatus mode) async {
    switch(mode) {
      case RingerModeStatus.normal:
        await AndroidAlarmManager.oneShot(const Duration(seconds: 5),id,setNormal,exact: true,wakeup: true);
        return;
      case RingerModeStatus.silent:
          await AndroidAlarmManager.oneShot(const Duration(seconds: 5),id,setSilent,exact: true,wakeup: true);
        return;
      case RingerModeStatus.vibrate:
          await AndroidAlarmManager.oneShot(const Duration(seconds: 5),id,setVibrate,exact: true,wakeup: true);
        return;
      default:
        return;
    }
  }

  Future<void> setOneShotAt(DateTime dateTime, int id, RingerModeStatus mode) async {
    switch(mode) {
      case RingerModeStatus.normal:
        await AndroidAlarmManager.oneShotAt(dateTime,id,setNormal,exact: true,wakeup: true);
        return;
      case RingerModeStatus.silent:
        await AndroidAlarmManager.oneShotAt(dateTime,id,setSilent,exact: true,wakeup: true);
        return;
      case RingerModeStatus.vibrate:
        await AndroidAlarmManager.oneShotAt(dateTime,id,setVibrate,exact: true,wakeup: true);
        return;
      default:
        return;
    }
  }
  //
  // Future<void> setSilentAt(DateTime dateTime, int id) async {
  //   await AndroidAlarmManager.oneShotAt(
  //     dateTime,
  //     // Ensure we have a unique alarm ID.
  //     id,
  //     setSilent,
  //     exact: true,
  //     wakeup: true,
  //   );
  // }
  //
  // Future<void> setVibrateAt(DateTime dateTime, int id) async {
  //   await AndroidAlarmManager.oneShotAt(
  //     dateTime,
  //     // Ensure we have a unique alarm ID.
  //     id,
  //     setVibrate,
  //     exact: true,
  //     wakeup: true,
  //   );
  // }
  //
  // Future<void> setNormalAt(DateTime dateTime, int id) async {
  //   await AndroidAlarmManager.oneShotAt(
  //     dateTime,
  //     // Ensure we have a unique alarm ID.
  //     id,
  //     setNormal,
  //     exact: true,
  //     wakeup: true,
  //   );
  // }

  static Future<void> setSilent(int id) async {
    print("Silent OneShot fired at! = [$id]");
    await MyNotification().notificationDefaultSound(title: "Silent Mode Activated!", description: "Activated at = [${DateTime.now()}]");
    await DBController.setNormalPeriod(true);
    await SettingsController.setSilentMode();
    await AndroidAlarmManager.cancel(id);
  }

  static Future<void> setVibrate(int id) async {
    print("Vibrate OneShot fired at! = [$id]");
    await MyNotification().notificationDefaultSound(title: "Vibration Mode Activated!", description: "Activated at = [${DateTime.now()}]");
    await DBController.setNormalPeriod(true);
    await SettingsController.setVibrateMode();
    await AndroidAlarmManager.cancel(id);
  }

  static Future<void> setNormal(int id) async {
    print("Normal OneShot fired at! = [$id]");
    // await MyNotification().notificationDefaultSound(title: "Silent Mode Activated!", description: "Activated at = [${DateTime.now()}]");
    await DBController.setNormalPeriod(false);
    await SettingsController.setNormalMode();
    await AndroidAlarmManager.cancel(id);
  }
}

Future<void> algorithm() async {
  print("===> Algorithm Start <===");
  // await DBController.setNormalPeriod(false);

  List<Schedule>? schedules = await ScheduleController.getSchedules();

  if (schedules == null) return ;

  final index = schedules.indexWhere((schedule) =>
  (schedule.status == true && Helper.isToday(schedule) == true && (Helper.isNowBefore(schedule.start) == true || Helper.isTimeBetween(schedule) == true)) ==
      true);

  if(index < 0) return;

  // return if found that already once activated a schedule
  bool? __normalPeriod = await DBController.getNormalPeriod();
  if(__normalPeriod == true) return;

  print("===> __normalPeriod");

  if(Helper.isNowBefore(schedules[index].start) == true) {

    RingerModeStatus currentSoundMode = await SettingsController.getCurrentSoundMode();

    if (currentSoundMode == RingerModeStatus.normal) {
      DateTime now = DateTime.now();
      DateTime start = DateTime.parse(schedules[index].start);
      DateTime end = DateTime.parse(schedules[index].end);

      DateTime startDateTime = DateTime(now.year, now.month, now.day, start.hour, start.minute);
      DateTime endDateTime = DateTime(now.year, now.month, now.day, end.hour, end.minute);
      if(Helper.isEndTimeBeforeStartTime(schedules[index].start, schedules[index].end)) {
        endDateTime = DateTime(now.year, now.month, now.day + 1, end.hour, end.minute);
      }

      print("Start = $start, End = $end, id = ${index + 5}");

      if (schedules[index].vibrate == true) {
        // await SettingsController.setVibrateMode();
        await MyAlarmManager().setOneShotAt(startDateTime, index, RingerModeStatus.vibrate);
        await MyAlarmManager().setOneShotAt(endDateTime, 99999, RingerModeStatus.normal);
      } else if (schedules[index].silent == true) {
        // await SettingsController.setSilentMode();
        await MyAlarmManager().setOneShotAt(startDateTime, index, RingerModeStatus.silent);
        await MyAlarmManager().setOneShotAt(endDateTime, 99999, RingerModeStatus.normal);
      }
    }

  } else if(Helper.isTimeBetween(schedules[index]) == true) {

    RingerModeStatus currentSoundMode = await SettingsController.getCurrentSoundMode();

    if (currentSoundMode == RingerModeStatus.normal) {
      DateTime now = DateTime.now();
      // DateTime start = DateTime.parse(schedules[index].start);
      DateTime end = DateTime.parse(schedules[index].end);

      // DateTime startDateTime = DateTime(now.year, now.month, now.day, start.hour, start.minute);
      DateTime endDateTime = DateTime(now.year, now.month, now.day, end.hour, end.minute);
      if(Helper.isEndTimeBeforeStartTime(schedules[index].start, schedules[index].end)) {
        endDateTime = DateTime(now.year, now.month, now.day + 1, end.hour, end.minute);
      }

      print("Now = $now, End = $end, id = ${index + 5}");

      if (schedules[index].vibrate == true) {
        // await SettingsController.setVibrateMode();
        await MyAlarmManager().setOneShot(index, RingerModeStatus.vibrate);
        await MyAlarmManager().setOneShotAt(endDateTime, 99999, RingerModeStatus.normal);
      } else if (schedules[index].silent == true) {
        // await SettingsController.setSilentMode();
        await MyAlarmManager().setOneShot(index, RingerModeStatus.silent);
        await MyAlarmManager().setOneShotAt(endDateTime, 99999, RingerModeStatus.normal);
      }
    }
  }
}