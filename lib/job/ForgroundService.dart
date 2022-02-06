import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/ScheduleController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';

class ForgroundService {
  static refresh() async {}

  static startForgroundService() async {
    FlutterBackgroundService().sendData({"action": "setAsForeground"});
    FlutterBackgroundService().start();

    print("Forground Service Started");
  }

  static stopForgroundService() async {
    FlutterBackgroundService().sendData({"action": "stopService"});

    print("Forground Service Stopped");
  }

  static Future<bool> isRunningForgroundService() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isServiceRunning();
    print("Is Running Forground Service: " + isRunning.toString());
    return isRunning;
  }
}

Future<void> refreshForegroundServiceNotification(
    {String message = 'App is running...'}) async {
  FlutterBackgroundService().setNotificationInfo(
    title: "My App Service",
    content: message,
  );
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
}

// to ensure this executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
void onIosBackground() {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');
}

void onStart() {
  WidgetsFlutterBinding.ensureInitialized();
  final service = FlutterBackgroundService();
  service.onDataReceived.listen((event) {
    if (event["action"] == "setAsForeground") {
      service.setForegroundMode(true);
      return;
    }

    if (event["action"] == "setAsBackground") {
      service.setForegroundMode(false);
    }

    if (event["action"] == "stopService") {
      service.stopBackgroundService();
    }
  });

  // bring to foreground
  service.setForegroundMode(true);
  Timer.periodic(Duration(seconds: 1), (timer) async {
    if (!(await service.isServiceRunning())) timer.cancel();
    // service.setNotificationInfo(
    //   title: "My App Service",
    //   content: "Updated at ${DateTime.now()}",
    // );
    await soundModeChangeBySchedule();
    // service.sendData(
    //   {"current_date": DateTime.now().toIso8601String()},
    // );
  });
}

Future<void> soundModeChangeBySchedule() async {
  List<Schedule> schedules = await ScheduleController.getSchedules();

  if (schedules == null) {
    return;
  } else {
    // await ForgroundService.refresh();

    final index = schedules.indexWhere((schedule) =>
        (schedule.status == true &&
            Helper.isToday(schedule) == true &&
            Helper.isTimeBetween(schedule)) ==
        true);

    if (index != -1 && index >= 0) {
      RingerModeStatus currentSoundMode =
          await SettingsController.getCurrentSoundMode();
      if (currentSoundMode == RingerModeStatus.normal) {
        await refreshForegroundServiceNotification(
            message:
                '"${schedules[index].name.toString().toUpperCase()}" is active (${DateFormat.jm().format(DateTime.parse(schedules[index].start)).toString()} - ${DateFormat.jm().format(DateTime.parse(schedules[index].end)).toString()})');
        await DBController.setNormalPeriod(true);
        if (schedules[index].vibrate == true) {
          await SettingsController.setVibrateMode();
        } else if (schedules[index].silent == true) {
          await SettingsController.setSilentMode();
        }
      }
    } else {
      bool __normalPeriod = await DBController.getNormalPeriod();
      if (__normalPeriod == true) {
        await refreshForegroundServiceNotification(
            message: 'All schedules are off');
        await DBController.setNormalPeriod(false);
        await SettingsController.setNormalMode();
      }
    }
  }
}
