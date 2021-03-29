import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/sound_profiles.dart';

class SettingsController {
  
  static TimeOfDay fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]) % 24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  static startForgroundService() async {
    await FlutterForegroundServicePlugin.startForegroundService(
      notificationContent: NotificationContent(
        iconName: 'ic_launcher',
        titleText: 'App is running on background.',
        color: Colors.green,
        priority: NotificationPriority.high,
      ),
      notificationChannelContent: NotificationChannelContent(
        id: 'some_id',
        nameText: 'settings title',
        descriptionText: 'settings description text',
      ),
      isStartOnBoot: true,
    );
  }

  static stopForgroundService() async {
    await FlutterForegroundServicePlugin.stopForegroundService();
  }

  static Future<bool> isRunningForgroundService() async {
    bool isRunning = await FlutterForegroundServicePlugin.isForegroundServiceRunning();
    return isRunning;
  }

  static startTask() async {
    await FlutterForegroundServicePlugin.startPeriodicTask(
      periodicTaskFun: periodicTaskFun,
      period: const Duration(seconds: 29),
    );
  }

  static stopTask() async {
    await FlutterForegroundServicePlugin.stopPeriodicTask();
  }

  static Future<void> startForgroundServiceAndTask() async {
    if(await SettingsController.isRunningForgroundService() == false) {
      await SettingsController.startForgroundService();
      await SettingsController.startTask();
    }
  }

  static Future<void> stopForgroundServiceAndTask() async {
    if(await SettingsController.isRunningForgroundService()) {
      await SettingsController.stopTask();
      await SettingsController.stopForgroundService();
    }
  }

  static Future<void> getCurrentSoundMode() async {
    String ringerStatus;
    try {
      ringerStatus = await SoundMode.ringerModeStatus;
      if (Platform.isIOS) {
        //because i no push meesage form ios to flutter,so need read two times
        await Future.delayed(Duration(milliseconds: 1000), () async {
          ringerStatus = await SoundMode.ringerModeStatus;
        });
      }
    } catch (err) {
      ringerStatus = 'Failed to get device\'s ringer status.$err';
    }
  }

  static Future<bool> getPermissionStatus() async {
    bool permissionStatus = false;
    try {
      permissionStatus = await PermissionHandler.permissionsGranted;
      print(permissionStatus);
      return permissionStatus;
    } catch (err) {
      print(err);
      return false;
    }
  }

  static Future<void> setSilentMode() async {
    try {
      await SoundMode.setSoundMode(Profiles.SILENT);
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  static Future<void> setNormalMode() async {
    try {
      await SoundMode.setSoundMode(Profiles.NORMAL);
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  static Future<void> setVibrateMode() async {
    try {
      await SoundMode.setSoundMode(Profiles.VIBRATE);
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  static Future<void> openDoNotDisturbSettings() async {
    await PermissionHandler.openDoNotDisturbSetting();
  }
}

Map<int,String> _dayNames = {
  1:'monday',
  2:'tuesday',
  3:'wednesday',
  4:'thursday',
  5:'friday',
  6:'saturday',
  7:'sunday',
};

bool _timeBetween(String start, String end) {
  // print("start $start and end $end");
  TimeOfDay startTime = SettingsController.fromString(start);
  TimeOfDay endTime = SettingsController.fromString(end);
  // TimeOfDay currentTime = fromString("5:30 am");
  TimeOfDay currentTime = TimeOfDay.now();

  double _doubleCurrentTime = currentTime.hour.toDouble() + (currentTime.minute.toDouble() / 60);
  double _doubleStartTime = startTime.hour.toDouble() + (startTime.minute.toDouble() / 60);
  double _doubleEndTime = endTime.hour.toDouble() + (endTime.minute.toDouble() / 60);

  double _timeDiffAfter = _doubleCurrentTime - _doubleStartTime;
  double _timeDiffBefore = _doubleEndTime - _doubleCurrentTime;

  // double _hrDiffAfter = _timeDiffAfter.truncate() * 1.0;
  double _minuteIsAfter = (_timeDiffAfter - _timeDiffAfter.truncate()) * 60;
  // double _hrDiffBefore = _timeDiffBefore.truncate() * 1.0;
  // print("_minute");
  // print(_minuteIsAfter.toString());
  double _minuteIsBefore = (_timeDiffBefore - _timeDiffBefore.truncate()) * 60;
  // print(_minuteIsBefore.toString());
  if(_minuteIsAfter >= 0 && _minuteIsBefore >= 1) return true;
  else return false;
}

bool isToday(Schedule schedule) {
  String todayName;

  DateTime date = DateTime.now();
  todayName = _dayNames[date.weekday];

  if(schedule.saturday == true && todayName == 'saturday') return true;
  else if(schedule.sunday == true && todayName == 'sunday') return true;
  else if(schedule.monday == true && todayName == 'monday') return true;
  else if(schedule.tuesday == true && todayName == 'tuesday') return true;
  else if(schedule.wednesday == true && todayName == 'wednesday') return true;
  else if(schedule.thursday == true && todayName == 'thursday') return true;
  else if(schedule.friday == true && todayName == 'friday') return true;
  else return false;
}

Future<void> periodicTaskFun() async {
  FlutterForegroundServicePlugin.executeTask(() async {
    // this will refresh the notification content each time the task is fire
    // if you want to refresh the notification content too each time
    // so don't set a low period duretion because android isn't handling it very well
    await FlutterForegroundServicePlugin.refreshForegroundServiceContent(
      notificationContent: NotificationContent(
        // iconName: 'ic_launcher',
        // titleText: 'Title Text',
        // bodyText: '${DateTime.now()}',
        // subText: 'subText',
        // color: Colors.red,
        iconName: 'ic_launcher',
        titleText: 'App is running on background.',
        color: Colors.green,
      ),
    );

    // print(DateTime.now());
    await soundModeChangeBySchedule();
    
  });
}

Future<void> soundModeChangeBySchedule() async {
  List<Schedule> schedules = await ScheduleController.getSchedules();

  // SettingsController.getCurrentSoundMode();
  // "Silent Mode"
  // "Normal Mode"
  // "Vibrate Mode"
  if(schedules == null) return;
  else {
    final index = schedules.indexWhere((schedule) => (schedule.status == true && isToday(schedule) && _timeBetween(schedule.start, schedule.end)));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    if(index != -1) {
      await prefs.setBool("__normal__period", true);
      
      if(schedules[index].vibrate == true) {
        await SettingsController.setVibrateMode();
      }
      else if(schedules[index].silent == true) {
        await SettingsController.setSilentMode();
      }
    } else {
      bool __normalPeriod = prefs.getBool("__normal__period");
      if(__normalPeriod == true) {
        await prefs.setBool("__normal__period", false);
        await SettingsController.setNormalMode();
      }
    }
  }
}
