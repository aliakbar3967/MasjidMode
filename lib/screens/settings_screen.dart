import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:flutter/cupertino.dart';


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
                        await Settings.startForgroundService();
                        // await FlutterForegroundServicePlugin
                        //     .startForegroundService(
                        //   notificationContent: NotificationContent(
                        //     iconName: 'ic_launcher',
                        //     titleText: 'Title Text',
                        //     color: Colors.red,
                        //     priority: NotificationPriority.high,
                        //   ),
                        //   notificationChannelContent: NotificationChannelContent(
                        //     id: 'some_id',
                        //     nameText: 'settings title',
                        //     descriptionText: 'settings description text',
                        //   ),
                        //   isStartOnBoot: true,
                        // );
                      },
                    ),
                    TextButton(
                      child: Text('Stop service'),
                      onPressed: () async {
                        await Settings.stopForgroundService();
                        // await FlutterForegroundServicePlugin
                        //     .stopForegroundService();
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
                        // await FlutterForegroundServicePlugin.startPeriodicTask(
                        //   periodicTaskFun: periodicTaskFun,
                        //   period: const Duration(seconds: 5),
                        // );
                        await Settings.startTask();
                      },
                    ),
                    TextButton(
                      child: Text('Stop task'),
                      onPressed: () async {
                        await Settings.stopTask();
                        // await FlutterForegroundServicePlugin.stopPeriodicTask();
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

// void periodicTaskFun() {
//   FlutterForegroundServicePlugin.executeTask(() async {
//     // this will refresh the notification content each time the task is fire
//     // if you want to refresh the notification content too each time
//     // so don't set a low period duretion because android isn't handling it very well
//     // await FlutterForegroundServicePlugin.refreshForegroundServiceContent(
//     //   notificationContent: NotificationContent(
//     //     iconName: 'ic_launcher',
//     //     titleText: 'Title Text',
//     //     bodyText: '${DateTime.now()}',
//     //     subText: 'subText',
//     //     color: Colors.red,
//     //   ),
//     // );

//     // print(DateTime.now());
//     // print('=====');

//     List<Schedule> schedules = await ScheduleController.getSchedules();

//     if(schedules == null) return;
//     else {
//       // schedules.forEach((element) => print(element.name)); 
//       schedules.forEach((schedule) {
//         if(schedule.status == true)
//         {
//           // timeDifference(schedule.start, schedule.end);
//           print('Schedule ${schedule.start} status true');
//         } else {
//           bool diff = _timeBetween(schedule.start, schedule.end);
//           if(diff) print('true');
//           else print('false');
//           // isBefore(schedule.start);
//           // isAfter(schedule.start);
//           // print('Schedule ${schedule.start} status false');
//         }
//       }); 
//     }
//   });
// }

TimeOfDay fromString(String time) {
  int hh = 0;
  if (time.endsWith('PM')) hh = 12;
  time = time.split(' ')[0];
  return TimeOfDay(
    hour: hh + int.parse(time.split(":")[0]) % 24, // in case of a bad time format entered manually by the user
    minute: int.parse(time.split(":")[1]) % 60,
  );
}

bool _timeBetween(String start, String end)
{
  print("start $start and end $end");
  TimeOfDay startTime = fromString(start);
  TimeOfDay endTime = fromString(end);
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
