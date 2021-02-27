import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Global [SharedPreferences] object.
SharedPreferences prefs;

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Schedule> __schedules;

  void _getDataL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    // final String encodedData = Schedule.encode([
    //   Schedule(id: 1, name:'sabuj',favorite:false),
    //   Schedule(id: 1, name:'sabuj',favorite:false),
    //   Schedule(id: 1, name:'sabuj',favorite:false),
    // ]);
    // // String counter = _map.toString();
    // // final List<Map<String, dynamic>> counter = jsonDecode(prefs.getString('_map'));
    // // print(counter);
    // await prefs.setString('__schedule', null);
    String _getSchedule = prefs.getString('__schedule');

    // return _getSchedule;
    if(_getSchedule != null)
    {
      // List<Schedule> decodedData;
      setState(() {
        print('if==');
        __schedules = Schedule.decode(_getSchedule);
      });
      // print(decodedData[0].name);
      // return _getSchedule;
    } else {
      print('else');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _setData();
    _getDataL();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Peace Time'),
        ),
        body: __schedules != null ? ListView.builder(
          itemCount: __schedules.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('${__schedules[index].name}'),
            );
          },
        ) : Builder(
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
                        period: const Duration(minutes: 20),
                      );
                    },
                  ),
                  TextButton(
                    child: Text('Stop task'),
                    onPressed: () async {
                      await FlutterForegroundServicePlugin.stopPeriodicTask();
                    },
                  ),
                  TextButton(
                    child: Text('Check'),
                    onPressed: _getData,
                  ),
                  TextButton(
                    child: Text('Set'),
                    onPressed: _setData,
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

_setData() async {
  final String encodedData = Schedule.encode([
    Schedule(id: 1, name:'sabuj',status:false),
    Schedule(id: 1, name:'sabuj',status:false),
    Schedule(id: 1, name:'sabuj',status:false),
  ]);

  SharedPreferences prefs = await SharedPreferences.getInstance();
  // String counter = _map.toString();
  // final List<Map<String, dynamic>> counter = jsonDecode(prefs.getString('_map'));
  // print(counter);
  await prefs.setString('__schedule', encodedData);
}

_getData() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  
  String _getSchedule = prefs.getString('__schedule');

  // return _getSchedule;
  if(_getSchedule != null)
  {
    List<Schedule> decodedData;
    decodedData = Schedule.decode(_getSchedule);
    print(decodedData[0].name);
    // return _getSchedule;
  } else {
    print(_getSchedule);
    // return null;
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
  });
}
