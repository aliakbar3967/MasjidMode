import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/model/day.dart';
import 'package:peace_time/model/options.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:peace_time/widgets/checkbox.dart';
import 'dart:convert';

import 'package:provider/provider.dart';

class EditSchduleScreen extends StatefulWidget {
  final List<Schedule> _schedules;
  final int _index;
  const EditSchduleScreen(this._schedules,this._index);

  @override
  _EditSchduleScreenState createState() => _EditSchduleScreenState();
}

class _EditSchduleScreenState extends State<EditSchduleScreen> {

  TimeOfDay time;
  TimeOfDay picked;
  String start;
  String end;
  // String name;
  TextEditingController name;
  bool silent = false;
  bool vibrate = false;
  bool airplane = false;
  bool notify = false;
  bool saturday = false;
  bool sunday = false;
  bool monday = false;
  bool tuesday = false;
  bool wednesday = false;
  bool thursday = false;
  bool friday = false;
  bool status = false;

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
    widget._schedules[widget._index].name = name.text;
    widget._schedules[widget._index].start = start;
    widget._schedules[widget._index].end = end;
    widget._schedules[widget._index].silent = silent;
    widget._schedules[widget._index].vibrate = vibrate;
    widget._schedules[widget._index].airplane = airplane;
    widget._schedules[widget._index].notify = notify;
    widget._schedules[widget._index].saturday = saturday;
    widget._schedules[widget._index].sunday = sunday;
    widget._schedules[widget._index].monday = monday;
    widget._schedules[widget._index].thursday = thursday;
    widget._schedules[widget._index].wednesday = wednesday;
    widget._schedules[widget._index].tuesday = tuesday;
    widget._schedules[widget._index].friday = friday;

    Provider.of<ScheduleController>(context,listen: false).update(widget._schedules[widget._index], widget._index);
    if(await SettingsController.isRunningForgroundService()){
      await SettingsController.stopTask();
      await SettingsController.startTask();
    }
    Navigator.pop(context, true);
    // String encoded = Schedule.encode([hold]);
    // print(encoded);
  }

  void checkSchedules() async {
    this.name = new TextEditingController(text: widget._schedules[widget._index].name);
    this.start = widget._schedules[widget._index].start;
    this.end = widget._schedules[widget._index].end;
    this.silent = widget._schedules[widget._index].silent;
    this.vibrate = widget._schedules[widget._index].vibrate;
    this.airplane = widget._schedules[widget._index].airplane;
    this.notify = widget._schedules[widget._index].notify;
    this.saturday = widget._schedules[widget._index].saturday;
    this.sunday = widget._schedules[widget._index].sunday;
    this.monday = widget._schedules[widget._index].monday;
    this.thursday = widget._schedules[widget._index].thursday;
    this.wednesday = widget._schedules[widget._index].wednesday;
    this.tuesday = widget._schedules[widget._index].tuesday;
    this.friday = widget._schedules[widget._index].friday;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkSchedules();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        title: Text('Edit Schedule'),
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
                        elevation: 30,
                        shadowColor: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Name',
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
                                saturday = !saturday;
                              });
                            },
                            child: Chip(
                              label: Text('s'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: saturday ? Colors.white : null
                              ),
                              backgroundColor: saturday ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                sunday = !sunday;
                              });
                            },
                            child: Chip(
                              label: Text('S'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: sunday ? Colors.white : null
                              ),
                              backgroundColor: sunday ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                monday = !monday;
                              });
                            },
                            child: Chip(
                              label: Text('m'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: monday ? Colors.white : null
                              ),
                              backgroundColor: monday ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                thursday = !thursday;
                              });
                            },
                            child: Chip(
                              label: Text('t'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: thursday ? Colors.white : null
                              ),
                              backgroundColor: thursday ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                wednesday = !wednesday;
                              });
                            },
                            child: Chip(
                              label: Text('w'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: wednesday ? Colors.white : null
                              ),
                              backgroundColor: wednesday ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                tuesday = !tuesday;
                              });
                            },
                            child: Chip(
                              label: Text('t'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: tuesday ? Colors.white : null
                              ),
                              backgroundColor: tuesday ? Colors.blue : null,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // print(days['sat']);
                              setState(() {
                                friday = !friday;
                              });
                            },
                            child: Chip(
                              label: Text('f'.toUpperCase()),
                              labelStyle: TextStyle(
                                color: friday ? Colors.white : null
                              ),
                              backgroundColor: friday ? Colors.blue : null,
                            ),
                          ),
                        ],
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Silent Mode"),
                          subtitle: Text("Phone will automatically silent."),
                          trailing: CupertinoSwitch(
                            value: silent,
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              setState(() {
                                silent = !silent;
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: Text("Vibrate Mode"),
                          subtitle: Text("Phone will automatically vibrate."),
                          trailing: CupertinoSwitch(
                            value: vibrate,
                            activeColor: Colors.blue,
                            onChanged: (bool value) {
                              setState(() {
                                vibrate = !vibrate;
                              });
                            },
                          ),
                        ),
                      ),
                      // Card(
                      //   child: ListTile(
                      //     title: Text("Airplane Mode"),
                      //     subtitle: Text("Phone will automatically airplane."),
                      //     trailing: CupertinoSwitch(
                      //       value: airplane,
                      //       activeColor: Colors.blue,
                      //       onChanged: (bool value) {
                      //         setState(() {
                      //           airplane = !airplane;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                      // Card(
                      //   child: ListTile(
                      //     title: Text("Notify Me"),
                      //     subtitle: Text("Phone will automatically notify you."),
                      //     trailing: CupertinoSwitch(
                      //       value: notify,
                      //       activeColor: Colors.blue,
                      //       onChanged: (bool value) {
                      //         setState(() {
                      //           notify = !notify;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
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
                        if(name.text != null && name.text != '') {
                          saveData();
                        }
                      },
                      child: Text(
                        'Update', 
                        style: TextStyle(
                          color: (name.text != null && name.text != '') ? Colors.blue : Colors.black12
                        ),
                      ),
                      autofocus: (name.text != null && name.text != '') ? true : false,
                      style: OutlinedButton.styleFrom(
                        shape: StadiumBorder(),
                        side: BorderSide(width: 2, color: (name.text != null && name.text != '') ? Colors.blue : Colors.black12),
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

