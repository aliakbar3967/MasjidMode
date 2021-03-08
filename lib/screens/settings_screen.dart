import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:peace_time/screens/create_schedule_screen.dart';
import 'package:peace_time/screens/home_screen.dart';
import 'package:peace_time/widgets/checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0,
      ),
      body: SafeArea(
          child: Builder(
            builder: (context) {
              return Center(
                child: Column(
                  children: [
                    TextButton(
                      child: Text('Start service'),
                      onPressed: () async {
                        await FlutterForegroundServicePlugin
                            .startForegroundService(
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
                      },
                    ),
                    TextButton(
                      child: Text('Stop service'),
                      onPressed: () async {
                        await FlutterForegroundServicePlugin
                            .stopForegroundService();
                      },
                    ),
                    TextButton(
                      child: Text('Is service running'),
                      onPressed: () async {
                        var isRunning = await FlutterForegroundServicePlugin
                            .isForegroundServiceRunning();
                        print(isRunning);
                        var snackbar = SnackBar(
                          content: Text('$isRunning'),
                          duration: Duration(milliseconds: 500),
                        );
                        Scaffold.of(context).showSnackBar(snackbar);
                      },
                    ),
                    TextButton(
                      child: Text('Start task'),
                      onPressed: () async {
                        await FlutterForegroundServicePlugin.startPeriodicTask(
                          periodicTaskFun: periodicTaskFun,
                          period: const Duration(seconds: 5),
                        );
                      },
                    ),
                    TextButton(
                      child: Text('Stop task'),
                      onPressed: () async {
                        await FlutterForegroundServicePlugin.stopPeriodicTask();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
      ),
    );
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

    print(DateTime.now());
    // print('=====');

    List<Schedule> schedules = await ScheduleController.getSchedules();

    if(schedules == null) return;
    else {
      // schedules.forEach((element) => print(element.name)); 
      schedules.forEach((schedule) {
        if(schedule.status == true)
        {
          print('Schedule ${schedule.name} status true');
        } else {
          print('Schedule ${schedule.name} status false');
        }
      }); 
    }
  });
}