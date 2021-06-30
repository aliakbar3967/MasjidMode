import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/ScheduleController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/model/ScheduleModel.dart';

class ForgroundService {
  static refresh() async {
    final bool serviceStatus = await isRunningForgroundService();
    if (serviceStatus) {
      await stopTask();
      await startTask();
    }
  }

  static startForgroundService() async {
    await FlutterForegroundServicePlugin.startForegroundService(
      notificationContent: NotificationContent(
        iconName: 'ic_launcher',
        titleText: 'App is running on background.',
        color: Colors.blue,
        priority: NotificationPriority.low,
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
    bool isRunning =
        await FlutterForegroundServicePlugin.isForegroundServiceRunning();
    return isRunning;
  }

  static startTask() async {
    await FlutterForegroundServicePlugin.startPeriodicTask(
      periodicTaskFun: periodicTaskFun,
      period: const Duration(seconds: 20),
    );
  }

  static stopTask() async {
    await FlutterForegroundServicePlugin.stopPeriodicTask();
  }

  static Future<void> startForgroundServiceAndTask() async {
    if (await isRunningForgroundService() == false) {
      await startForgroundService();
      await startTask();
    }
  }

  static Future<void> stopForgroundServiceAndTask() async {
    if (await isRunningForgroundService()) {
      await stopTask();
      await stopForgroundService();
    }
  }
}

Future<void> refreshForegroundServiceNotification(
    {String message = 'App is running...'}) async {
  await FlutterForegroundServicePlugin.refreshForegroundServiceContent(
    notificationContent: NotificationContent(
      // iconName: 'ic_launcher',
      // titleText: 'Title Text',
      // bodyText: '${DateTime.now()}',
      // subText: 'subText',
      // color: Colors.red,
      iconName: 'ic_launcher',
      titleText: message,
      color: Colors.green,
    ),
  );
}

Future<void> periodicTaskFun() async {
  FlutterForegroundServicePlugin.executeTask(() async {
    // this will refresh the notification content each time the task is fire
    // if you want to refresh the notification content too each time
    // so don't set a low period duretion because android isn't handling it very well
    // print(DateTime.now());
    await soundModeChangeBySchedule();
  });
}

Future<void> soundModeChangeBySchedule() async {
  List<Schedule> schedules = await ScheduleController.getSchedules();

  // print("job running on background");
  // print(schedules);
  // print(Helper.isTimeBetween('12:00 PM', '12:47 PM'));

  // SettingsController.getCurrentSoundMode();
  // "Silent Mode"
  // "Normal Mode"
  // "Vibrate Mode"
  if (schedules == null) {
    return;
  } else {
    // await ForgroundService.refresh();

    final index = schedules.indexWhere((schedule) =>
        (schedule.status == true &&
            Helper.isToday(schedule) == true &&
            Helper.isTimeBetween(schedule.start, schedule.end)) ==
        true);

    if (index != -1 && index >= 0) {
      String currentSoundMode = await SettingsController.getCurrentSoundMode();
      if (currentSoundMode == 'Normal Mode') {
        await refreshForegroundServiceNotification(
            message:
                '"${schedules[index].name.toString().toUpperCase()}" is active (${schedules[index].start.toString()} - ${schedules[index].end.toString()})');
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
            message: 'No schedule is active now');
        await DBController.setNormalPeriod(false);
        await SettingsController.setNormalMode();
      }
    }
  }
}
