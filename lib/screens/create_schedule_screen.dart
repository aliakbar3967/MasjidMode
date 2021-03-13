import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:peace_time/widgets/checkbox.dart';
import 'dart:convert';

class CreateSchduleScreen extends StatefulWidget {
  @override
  _CreateSchduleScreenState createState() => _CreateSchduleScreenState();
}

class _CreateSchduleScreenState extends State<CreateSchduleScreen> {

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

  String start = "12:00 am";
  String end = "12:00 am";
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

  void saveData() async {
    // TimeOfDay test = TimeOfDay.now();
    // String dd = test.toString();
    // print(dd);

    Schedule schedule = Schedule(
      name: name,
      start: start,
      end: end,
      days: jsonEncode(days),
      options: jsonEncode(options),
      status: true,
      selected: false,
    );

    ScheduleController.store(schedule);
    if(await SettingsController.isRunningForgroundService()){
      await SettingsController.stopTask();
      await SettingsController.startTask();
    }
    Navigator.pop(context, true);
    // String encoded = Schedule.encode([hold]);
    // print(encoded);
  }

  void checkSchedules() async {
    // Navigator.pop(context);
    await ScheduleController.getSchedules();
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('New Schedule'),
      ),
      body: SafeArea(
        bottom: false,
        child: Container(
          // padding: EdgeInsets.only(left: 15, right: 15),
          // height: double.infinity,
          // width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: TextField(
                            onChanged: (String value) {
                              setState(() {
                                name = value;
                              });
                              // print(name);
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              // icon: Icon(Icons.favorite),
                              // labelText: 'Name',
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
                              hintText: 'Name',
                              // border: OutlineInputBorder(
                              //   borderSide: BorderSide(
                              //     color: Colors.red,//this has no effect
                              //   ),
                              //   borderRadius: BorderRadius.circular(10.0),
                              // ),
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GestureDetector(
                          onTap: () {
                            selectStartTime(context);
                          },
                          child: ListTile(
                            title: Text("$start"),
                            subtitle: Text("Start Time"),
                            trailing: IconButton(
                              icon: Icon(Icons.alarm_add),
                              onPressed: () {
                                selectStartTime(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                        child: GestureDetector(
                          onTap: () {
                            selectEndTime(context);
                          },
                          child: ListTile(
                            title: Text("$end"),
                            subtitle: Text("End Time"),
                            trailing: IconButton(
                              icon: Icon(Icons.alarm_add),
                              onPressed: () {
                                selectEndTime(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        children: [
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                days['sat'] = !days['sat'];
                              });
                            },
                            child: Chip(
                              label: Text('s'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: days['sat'] ? Colors.white : null
                              ),
                              backgroundColor: days['sat'] ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                days['sun'] = !days['sun'];
                              });
                            },
                            child: Chip(
                              label: Text('S'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: days['sun'] ? Colors.white : null
                              ),
                              backgroundColor: days['sun'] ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                days['mon'] = !days['mon'];
                              });
                            },
                            child: Chip(
                              label: Text('m'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: days['mon'] ? Colors.white : null
                              ),
                              backgroundColor: days['mon'] ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                days['thu'] = !days['thu'];
                              });
                            },
                            child: Chip(
                              label: Text('t'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: days['thu'] ? Colors.white : null
                              ),
                              backgroundColor: days['thu'] ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                days['wed'] = !days['wed'];
                              });
                            },
                            child: Chip(
                              label: Text('w'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: days['wed'] ? Colors.white : null
                              ),
                              backgroundColor: days['wed'] ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                days['tue'] = !days['tue'];
                              });
                            },
                            child: Chip(
                              label: Text('t'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: days['tue'] ? Colors.white : null
                              ),
                              backgroundColor: days['tue'] ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                days['fri'] = !days['fri'];
                              });
                            },
                            child: Chip(
                              label: Text('f'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: days['fri'] ? Colors.white : null
                              ),
                              backgroundColor: days['fri'] ? Colors.blue : null,
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Silent Mode"),
                          subtitle: Text("Phone will automatically silent."),
                          trailing: Switch(
                            value: options['silent'],
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              setState(() {
                                options['silent'] = !options['silent'];
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Vibrate Mode"),
                          subtitle: Text("Phone will automatically vibrate."),
                          trailing: Switch(
                            value: options['vibrate'],
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              setState(() {
                                options['vibrate'] = !options['vibrate'];
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Airplane Mode"),
                          subtitle: Text("Phone will automatically airplane."),
                          trailing: Switch(
                            value: options['airplane'],
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              setState(() {
                                options['airplane'] = !options['airplane'];
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Notify Me"),
                          subtitle: Text("Phone will automatically notify you."),
                          trailing: Switch(
                            value: options['notifyme'],
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              setState(() {
                                options['notifyme'] = !options['notifyme'];
                              });
                            },
                          ),
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ButtonBar(
                  alignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    OutlinedButton (
                      onPressed: () {
                        checkSchedules();
                        Navigator.pop(context, true);
                      },
                      child: Text('Cancel'),
                      autofocus: false,
                      style: OutlinedButton.styleFrom(
                        primary: Colors.redAccent,
                        shape: StadiumBorder(),
                        side: BorderSide(width: 2, color: Colors.redAccent),
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16)
                      ),
                    ),
                    OutlinedButton (
                      onPressed: () {
                        if(name != null && name != '') {
                          saveData();
                        }
                      },
                      child: Text(
                        'Save', 
                        style: TextStyle(
                          color: (name != null && name != '') ? Colors.blue : Colors.black12
                        ),
                      ),
                      autofocus: (name != null && name != '') ? true : false,
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(width: 2, color: (name != null && name != '') ? Colors.blue : Colors.black12),
                        padding: EdgeInsets.symmetric(horizontal:32, vertical: 16)
                      ),
                    ),
                  ]
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
