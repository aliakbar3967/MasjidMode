import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:peace_time/widgets/checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Global [SharedPreferences] object.
SharedPreferences prefs;

void main() {
  runApp(CreateSchdule());
}

class CreateSchdule extends StatefulWidget {
  @override
  _CreateSchduleState createState() => _CreateSchduleState();
}

class _CreateSchduleState extends State<CreateSchdule> {

  final Map<String, String> daysName = {
    'sat':'satarday',
    'sun':'sunday',
    'mon':'monday',
    'thu':'thusday',
    'wed':'wednesday',
    'tue':'tuesday',
    'fri':'friday'
  };
  Map<String, bool> days = {
    'sat': true,
    'sun': false,
    'mon': false,
    'tue': false,
    'wed': false,
    'thu': false,
    'fri': false,
  };
  Map<String, bool> options = {
    'silent': true,
    'airplane': false,
    'vibrate': false,
    'notifyme':false
  };

  TimeOfDay time;
  TimeOfDay picked;
  String start = "5:30 am";
  String end = "5:30 am";
  String name;

  Future<Null> selectStartTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if(picked != null)
    {
      setState(() {
        start = picked.format(context);
      });
    }
  }

  Future<Null> selectEndTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: TimeOfDay.now());

    if(picked != null)
    {
      setState(() {
        end = picked.format(context);
      });
    }
  }

  TimeOfDay fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]) % 24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  void saveData() {
    // TimeOfDay test = TimeOfDay.now();
    // String dd = test.toString();
    // print(dd);

    Schedule hold = Schedule(
      name: name,
      start: start,
      end: end,
      days: jsonEncode(days),
      options: jsonEncode(options),
      status: true
    );

    print(Schedule.encode([hold]));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _setData();
    // _getDataL();
    // start = TimeOfDay.now();
    // end = TimeOfDay.now();
    // print(time);
    // selectEndTime(context);
    // selectStartTime(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: (context) {
            return Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Schedule name',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ],
                  // alignment: Alignment.center,
                  // child: Text('Schedule name'),
                ),
                SizedBox(height: 8,),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          spreadRadius: 2,
                          offset: Offset(4, 4),
                        ),
                      ], 
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: TextField(
                    onChanged: (String value) {
                      name = value;
                      print(name);
                    },
                    decoration: InputDecoration(
                      // icon: Icon(Icons.favorite),
                      labelText: 'Name',
                      // labelStyle: TextStyle(
                      //   color: Color(0xFF6200EE),
                      // ),
                      // helperText: 'Helper text',
                      // suffixIcon: Icon(
                      //   Icons.check_circle,
                      // ),
                      // enabledBorder: UnderlineInputBorder(
                      //   borderSide: BorderSide(color: Color(0xFF6200EE)),
                      // ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,//this has no effect
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black12,
                  //         blurRadius: 8,
                  //         spreadRadius: 2,
                  //         offset: Offset(4, 4),
                  //       ),
                  //     ], 
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Start:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$start",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.alarm_add),
                        onPressed: () {
                          selectStartTime(context);
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  padding:  EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  // decoration: BoxDecoration(
                  //   color: Colors.white,
                  //   boxShadow: [
                  //       BoxShadow(
                  //         color: Colors.black12,
                  //         blurRadius: 8,
                  //         spreadRadius: 2,
                  //         offset: Offset(4, 4),
                  //       ),
                  //     ], 
                  //     borderRadius: BorderRadius.all(Radius.circular(10)),
                  // ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "End:",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "$end",
                        style: TextStyle(
                          fontSize: 32,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.alarm_add),
                        onPressed: () {
                          selectEndTime(context);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(height: 8,),
                // Expanded(
                //   child: TextButton(
                //     child: Text('Select Time'),
                //     onPressed: () {
                //       selectStartTime(context);
                //       print("Selected time = ${time.format(context)}");

                //       TimeOfDay _formated = fromString(time.format(context));

                //       print("Selected time = $_formated");
                //     },
                //   ),
                // ),
                // Text("Selected time = ${time.format(context)}"),
                SizedBox(height: 8,),
                Text(
                  'Select Days',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: days.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: days[key],
                        onChanged: (bool value) {
                          setState(() {
                            print(key);
                            days[key] = value;
                          });
                        }
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 8,),
                Text(
                  'Select Options',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                Flexible(
                  child: ListView(
                    children: options.keys.map((String key) {
                      return CheckboxListTile(
                        title: Text(key),
                        value: options[key],
                        onChanged: (bool value) {
                          setState(() {
                            print(key);
                            options[key] = value;
                          });
                        }
                      );
                    }).toList(),
                  ),
                ),
                // Flexible(
                //   child: ListView.builder(
                //     itemCount: options.length,
                //     itemBuilder: (BuildContext context, int index) {
                //       return Container (
                //         child: Text('item'),
                //       );
                //     },
                //   ),
                // ),
                SizedBox(height: 8,),
                Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: [
                    Chip(
                      label: Text('Sat'),
                    ),
                    Chip(
                      label: Text('Sun'),
                    ),
                    Chip(
                      label: Text('Mon'),
                    ),
                    Chip(
                      label: Text('Thu'),
                    ),
                    Chip(
                      label: Text('Wed'),
                    ),
                    Chip(
                      label: Text('Tue'),
                    ),
                    Chip(
                      label: Text('Fri'),
                    ),
                  ],
                ),
                SizedBox(height: 8,),
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    OutlinedButton (
                      onPressed: () {},
                      child: Text('Cancel'),
                      style: OutlinedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: StadiumBorder(),
                        side: BorderSide(width: 2, color: Colors.redAccent),
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16)
                      ),
                    ),
                    OutlinedButton (
                      onPressed: () async {
                        await saveData();
                      },
                      child: Text('Save'),
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(width: 2, color: Colors.blue),
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16)
                      ),
                    ),
                  ]
                )
              ],
            );
          },
        ),
      )
      )
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Map<String> options = {'1','2','3','4','5','6','7','8','9','0'};
  List options = [1,2,3,4,5,6,7,8,9,0];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          // elevation: 0.0,
          child: new Icon(Icons.add, size: 48.0,),
          backgroundColor: Colors.blue,
          onPressed: (){}
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Schedule',
                      style: TextStyle(
                          fontFamily: 'avenir',
                          fontWeight: FontWeight.w100,
                          fontSize: 20),
                    ),
                    Row(
                      children: [
                        Icon(Icons.settings, color: Colors.black45,)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 8.0,),
                Expanded(
                  child: ListView.builder(
                    // padding: const EdgeInsets.all(8),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 32),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.blueAccent],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                              ),
                            ], 
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("Juma Time"),
                                Switch(value: true, onChanged: (bool value) {},activeColor: Colors.white,)
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "9:30 am - 10:30 am",
                                  style: TextStyle(
                                    fontFamily: 'avenir',
                                    fontWeight: FontWeight.w100,
                                    fontSize: 32,
                                    color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 32),
                                  padding: const EdgeInsets.all(4),
                                  child: Text('sat'),
                                ),
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 32),
                                  padding: const EdgeInsets.all(4),
                                  child: Text('sun'),
                                ),
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 32),
                                  padding: const EdgeInsets.all(4),
                                  child: Text('mon'),
                                ),
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 32),
                                  padding: const EdgeInsets.all(4),
                                  child: Text('thu'),
                                ),
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 32),
                                  padding: const EdgeInsets.all(4),
                                  child: Text('wed'),
                                ),
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 32),
                                  padding: const EdgeInsets.all(4),
                                  child: Text('tue'),
                                ),
                                Container(
                                  // margin: const EdgeInsets.only(bottom: 32),
                                  padding: const EdgeInsets.all(4),
                                  child: Text('fri'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  List<Schedule> __schedules;

  TimeOfDay time;
  TimeOfDay picked;

  TimeOfDay start;
  TimeOfDay end;
  bool status = true;
  final Map<String, String> daysName = {
    'sat':'satarday',
    'sun':'sunday',
    'mon':'monday',
    'thu':'thusday',
    'wed':'wednesday',
    'tue':'tuesday',
    'fri':'friday'
  };
  Map<String, bool> days = {
    'sat': true,
    'sun': false,
    'mon': false,
    'tue': false,
    'wed': false,
    'thu': false,
    'fri': false,
  };
  Map<String, bool> options = {
    'silent': true,
    'airplane': false,
    'vibrate': false,
    'notifyme':false
  };

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
    // _getDataL();
    time = TimeOfDay.now();
    print(time);
  }

  
  Future<Null> selectTime(BuildContext context) async {
    picked = await showTimePicker(context: context, initialTime: time);

    if(picked != null)
    {
      setState(() {
        time = picked;
      });
    }
  }

  TimeOfDay fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh + int.parse(time.split(":")[0]) % 24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Peace Time'),
        ),
        body: true ? 
        ListView(
          children: options.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: options[key],
              onChanged: (bool value) {
                setState(() {
                  print(key);
                  options[key] = value;
                });
              }
            );
          }).toList(),
        )
        // ListView(
        //   children: days.keys.map((String key) {
        //     return CheckboxListTile(
        //       title: Text(daysName[key].toString().toUpperCase()),
        //       value: days[key],
        //       onChanged: (bool value) {
        //         setState(() {
        //           print(key);
        //           days[key] = value;
        //         });
        //       }
        //     );
        //   }).toList(),
        // )
        : Builder(
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
                  TextButton(
                    child: Text('Select Time'),
                    onPressed: () {
                      selectTime(context);
                      print("Selected time = ${time.format(context)}");

                      TimeOfDay _formated = fromString(time.format(context));

                      print("Selected time = $_formated");
                    },
                  ),
                  Text("Selected time = ${time.format(context)}"),
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
