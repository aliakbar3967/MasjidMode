import 'dart:async';
import 'dart:ui';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/ScheduleController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/helper/MyNotification.dart';
import 'package:peace_time/job/MyAlarmManager.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';


class ForgroundService {
  static refresh() async {}

  static startForgroundService() async {
    FlutterBackgroundService().startService();
    FlutterBackgroundService().invoke("stopService");

    print("Forground Service Started");
  }

  static stopForgroundService() async {
    FlutterBackgroundService().invoke("stopService");

    print("Forground Service Stopped");
  }

  static Future<bool> isRunningForgroundService() async {
    final service = FlutterBackgroundService();
    bool isRunning = await service.isRunning();
    print("Is Running Forground Service: " + isRunning.toString());
    return isRunning;
  }
}

Future<void> refreshForegroundServiceNotification(
    {String message = 'App is running...'}) async {
}

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      // this will be executed when app is in foreground or background in separated isolate
      onStart: onStart,

      // auto start service
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      // auto start service
      autoStart: true,

      // this will be executed when app is in foreground in separated isolate
      onForeground: onStart,

      // you have to enable background fetch capability on xcode project
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
bool onIosBackground(ServiceInstance service) {
  WidgetsFlutterBinding.ensureInitialized();
  print('FLUTTER BACKGROUND FETCH');

  return true;
}

void onStart(ServiceInstance service) async {

  // Only available for flutter 3.0.0 and later
  DartPluginRegistrant.ensureInitialized();

  // For flutter prior to version 3.0.0
  // We have to register the plugin manually

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: "Schedule Active",
        content: "Updated at ${DateTime.now()}",
      );
    }

    /// you can see this log in logcat
    print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    // test using external plugin
    await soundModeChangeBySchedule();
  });
}

Future<void> soundModeChangeBySchedule() async {
  List<Schedule>? schedules = await ScheduleController.getSchedules();

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
      bool? __normalPeriod = await DBController.getNormalPeriod();
      if (__normalPeriod == true) {
        await refreshForegroundServiceNotification(
            message: 'All schedules are off');
        await DBController.setNormalPeriod(false);
        await SettingsController.setNormalMode();
      }
    }
  }
}
