import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
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

  static bool _timeBetween(String start, String end) {
    print("start $start and end $end");
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
    double _minuteIsBefore = (_timeDiffBefore - _timeDiffBefore.truncate()) * 60;

    if(_minuteIsAfter >= 0 && _minuteIsBefore >= 0) return true;
    else return false;
  }

  static startForgroundService() async {
    await FlutterForegroundServicePlugin.startForegroundService(
      notificationContent: NotificationContent(
        iconName: 'ic_launcher',
        titleText: 'Title Text',
        color: Colors.red,
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
      period: const Duration(seconds: 5),
    );
  }

  static stopTask() async {
    await FlutterForegroundServicePlugin.stopPeriodicTask();
  }

  static startForgroundServiceAndTask() async {
    if(await SettingsController.isRunningForgroundService() == false) {
      await SettingsController.startForgroundService();
      await SettingsController.startTask();
    }
  }

  static stopForgroundServiceAndTask() async {
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
    // print("v$ringerStatus v");
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   _soundMode = ringerStatus;
    // });
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

    // setState(() {
    //   _permissionStatus =
    //   permissionStatus ? "Permissions Enabled" : "Permissions not granted";
    // });
  }

  static Future<void> setSilentMode() async {
    String message;

    try {
      message = await SoundMode.setSoundMode(Profiles.SILENT);

      // setState(() {
      //   _soundMode = message;
      // });
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  static Future<void> setNormalMode() async {
    String message;

    try {
      message = await SoundMode.setSoundMode(Profiles.NORMAL);
      // setState(() {
      //   _soundMode = message;
      // });
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  static Future<void> setVibrateMode() async {
    String message;

    try {
      message = await SoundMode.setSoundMode(Profiles.VIBRATE);

      // setState(() {
      //   _soundMode = message;
      // });
    } on PlatformException {
      print('Do Not Disturb access permissions required!');
    }
  }

  static Future<void> openDoNotDisturbSettings() async {
    await PermissionHandler.openDoNotDisturbSetting();
  }
}

void periodicTaskFun() {
  FlutterForegroundServicePlugin.executeTask(() async {
    // this will refresh the notification content each time the task is fire
    // if you want to refresh the notification content too each time
    // so don't set a low period duretion because android isn't handling it very well
    // await FlutterForegroundServicePlugin.refreshForegroundServiceContent(
    //   notificationContent: NotificationContent(
    //     iconName: 'ic_launcher',
    //     titleText: 'Title Text',
    //     bodyText: '${DateTime.now()}',
    //     subText: 'subText',
    //     color: Colors.red,
    //   ),
    // );

    // print(DateTime.now());
    // print('=====');

    List<Schedule> schedules = await ScheduleController.getSchedules();

          SettingsController.getCurrentSoundMode();
          // "Silent Mode"
          // "Normal Mode"
          // "Vibrate Mode"
    if(schedules == null) return;
    else {
      // schedules.forEach((element) => print(element.name)); 
      schedules.forEach((schedule) {
        if(schedule.status == true && SettingsController._timeBetween(schedule.start, schedule.end))
        {
          // timeDifference(schedule.start, schedule.end);
          // print('Schedule ${schedule.start} status true');
          SettingsController.setSilentMode();
        } else {
          SettingsController.setNormalMode();
          // bool diff = Settings._timeBetween(schedule.start, schedule.end);
          // if(diff) print('true');
          // else print('false');
          // isBefore(schedule.start);
          // isAfter(schedule.start);
          // print('Schedule ${schedule.start} status false');
        }
      }); 
    }
  });
}
