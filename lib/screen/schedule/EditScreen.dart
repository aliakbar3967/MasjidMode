import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:provider/provider.dart';

class EditScreen extends StatefulWidget {
  final int index;
  const EditScreen(this.index);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  Schedule schedule;
  TimeOfDay time;
  TimeOfDay picked;
  TextEditingController name;

  Map<String, bool> errors = {'name': false};

  Future<Null> selectStartTime(BuildContext context) async {
    picked = await showTimePicker(
        context: context,
        initialTime: Helper.stringToTimeOfDay(schedule.start));

    if (picked != null) {
      setState(() {
        schedule.start = picked.format(context);
      });
    }
  }

  Future<Null> selectEndTime(BuildContext context) async {
    picked = await showTimePicker(
        context: context, initialTime: Helper.stringToTimeOfDay(schedule.end));

    if (picked != null) {
      setState(() {
        schedule.end = picked.format(context);
      });
    }
  }

  TimeOfDay fromString(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh +
          int.parse(time.split(":")[0]) %
              24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  void saveData() async {
    schedule.name = name.text;

    Provider.of<ScheduleProvider>(context, listen: false)
        .update(schedule, widget.index);
    // if (await SettingsController.isRunningForgroundService()) {
    //   await SettingsController.stopTask();
    //   await SettingsController.startTask();
    // }
    Navigator.pop(context, true);
    // String encoded = Schedule.encode([schedule]);
    // print(encoded);
  }

  void getScheduleDetails() async {
    this.schedule = Provider.of<ScheduleProvider>(context, listen: false)
        .schedules[widget.index];
    setState(() {
      name = TextEditingController(text: schedule.name.toString());
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // name = TextEditingController();
    // name.addListener(() {
    //   setState(() {
    //     print(name.text);
    //   });
    // });
    getScheduleDetails();
    // print(name.text.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      // backgroundColor: Colors.grey[900],
      appBar: AppBar(
        // elevation: 0,
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back_ios_outlined),
        //   onPressed: () => Navigator.of(context).pop(),
        // ),
        title: Text(
          "Edit Schedule".toUpperCase(),
        ),
      ),
      body: SafeArea(
        // bottom: false,
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(children: [
                      SizedBox(height: 10.0),
                      Card(
                        // color: Colors.grey[900],
                        elevation: 30,
                        // shadowColor: Colors.grey[900],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: TextField(
                            controller: name,
                            onChanged: (String value) {
                              setState(() {
                                schedule.name = value;
                              });
                              // print(name);
                            },
                            // style: TextStyle(color: Colors.grey[400]),
                            decoration: InputDecoration(
                              // fillColor: Colors.grey[400],
                              // focusColor: Colors.grey[400],
                              // hoverColor: Colors.grey[400],
                              // filled: true,
                              border: InputBorder.none,
                              hintText: 'Give a name..',
                              // hintStyle: TextStyle(color: Colors.grey[800])
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8 * 5.0),
                      Card(
                        // color: Colors.grey[900],
                        child: GestureDetector(
                          onTap: () {
                            selectStartTime(context);
                          },
                          child: ListTile(
                            title: Text(
                              schedule.start.toString(),
                              style: TextStyle(
                                  // color: Colors.grey[400],
                                  ),
                            ),
                            subtitle: Text(
                              "Start Time",
                              // style: TextStyle(color: Colors.grey[700]),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.alarm_add,
                                // color: Colors.grey[400],
                              ),
                              onPressed: () {
                                selectStartTime(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      Card(
                        // color: Colors.grey[900],
                        child: GestureDetector(
                          onTap: () {
                            selectEndTime(context);
                          },
                          child: ListTile(
                            title: Text(
                              schedule.end.toString(),
                              style: TextStyle(
                                  // color: Colors.grey[400],
                                  ),
                            ),
                            subtitle: Text(
                              "End Time",
                              // style: TextStyle(color: Colors.grey[700]),
                            ),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.alarm_add,
                                // color: Colors.grey[400],
                              ),
                              onPressed: () {
                                selectEndTime(context);
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Row(
                          // spacing: 10.0,
                          // runSpacing: 10.0,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // print(days['sat']);
                                setState(() {
                                  schedule.saturday = !schedule.saturday;
                                });
                              },
                              child: Chip(
                                label: Text('s'.toUpperCase()),
                                labelStyle: TextStyle(color: Colors.white),
                                backgroundColor: schedule.saturday
                                    ? Colors.blue
                                    : Colors.grey[400],
                                shape: CircleBorder(
                                    side: BorderSide(color: Colors.grey[400])),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // print(days['sat']);
                                setState(() {
                                  schedule.sunday = !schedule.sunday;
                                });
                              },
                              child: Chip(
                                label: Text('S'.toUpperCase()),
                                labelStyle: TextStyle(color: Colors.white),
                                backgroundColor: schedule.sunday
                                    ? Colors.blue
                                    : Colors.grey[400],
                                shape: CircleBorder(
                                    side: BorderSide(color: Colors.grey[400])),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // print(days['sat']);
                                setState(() {
                                  schedule.monday = !schedule.monday;
                                });
                              },
                              child: Chip(
                                label: Text('m'.toUpperCase()),
                                labelStyle: TextStyle(color: Colors.white),
                                backgroundColor: schedule.monday
                                    ? Colors.blue
                                    : Colors.grey[400],
                                shape: CircleBorder(
                                    side: BorderSide(color: Colors.grey[400])),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // print(days['sat']);
                                setState(() {
                                  schedule.tuesday = !schedule.tuesday;
                                });
                              },
                              child: Chip(
                                label: Text('t'.toUpperCase()),
                                labelStyle: TextStyle(color: Colors.white),
                                backgroundColor: schedule.tuesday
                                    ? Colors.blue
                                    : Colors.grey[400],
                                shape: CircleBorder(
                                    side: BorderSide(color: Colors.grey[400])),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // print(days['sat']);
                                setState(() {
                                  schedule.wednesday = !schedule.wednesday;
                                });
                              },
                              child: Chip(
                                label: Text('w'.toUpperCase()),
                                labelStyle: TextStyle(color: Colors.white),
                                backgroundColor: schedule.wednesday
                                    ? Colors.blue
                                    : Colors.grey[400],
                                shape: CircleBorder(
                                    side: BorderSide(color: Colors.grey[400])),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // print(days['sat']);
                                setState(() {
                                  schedule.thursday = !schedule.thursday;
                                });
                              },
                              child: Chip(
                                label: Text('t'.toUpperCase()),
                                labelStyle: TextStyle(color: Colors.white),
                                backgroundColor: schedule.thursday
                                    ? Colors.blue
                                    : Colors.grey[400],
                                shape: CircleBorder(
                                    side: BorderSide(color: Colors.grey[400])),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                // print(days['sat']);
                                setState(() {
                                  schedule.friday = !schedule.friday;
                                });
                              },
                              child: Chip(
                                label: Text('f'.toUpperCase()),
                                labelStyle: TextStyle(color: Colors.white),
                                backgroundColor: schedule.friday
                                    ? Colors.blue
                                    : Colors.grey[400],
                                shape: CircleBorder(
                                    side: BorderSide(color: Colors.grey[400])),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Card(
                        // color: Colors.grey[900],
                        child: ListTile(
                          title: Text(
                            "Silent Mode",
                            // style: TextStyle(color: Colors.grey[400])
                          ),
                          subtitle: Text(
                            "Phone will automatically silent.",
                            // style: TextStyle(color: Colors.grey[700])
                          ),
                          trailing: CupertinoSwitch(
                            value: schedule.silent,
                            activeColor: Colors.blue,
                            // trackColor: Colors.black,
                            onChanged: (bool value) {
                              setState(() {
                                schedule.silent = !schedule.silent;
                              });
                            },
                          ),
                        ),
                      ),
                      Card(
                        // color: Colors.grey[900],
                        child: ListTile(
                          title: Text(
                            "Vibrate Mode",
                            // style: TextStyle(color: Colors.grey[400])
                          ),
                          subtitle: Text(
                            "Phone will automatically vibrate.",
                            // style: TextStyle(color: Colors.grey[700])
                          ),
                          trailing: CupertinoSwitch(
                            value: schedule.vibrate,
                            activeColor: Colors.blue,
                            // trackColor: Colors.black,
                            onChanged: (bool value) {
                              setState(() {
                                schedule.vibrate = !schedule.vibrate;
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
                      //       activeColor: Colors.grey[700],trackColor: Colors.black,
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
                      //       activeColor: Colors.grey[700],trackColor: Colors.black,
                      //       onChanged: (bool value) {
                      //         setState(() {
                      //           notify = !notify;
                      //         });
                      //       },
                      //     ),
                      //   ),
                      // ),
                    ]),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context, true);
                        },
                        child: Icon(Icons.close),
                        autofocus: false,
                        style: OutlinedButton.styleFrom(
                            primary: Colors.redAccent,
                            shape: StadiumBorder(),
                            side: BorderSide(width: 2, color: Colors.redAccent),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16)),
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (schedule.name != null && schedule.name != '') {
                            saveData();
                          } else {
                            setState(() {
                              errors['name'] = true;
                            });
                          }
                        },
                        // child: Text(
                        //   'Save',
                        //   style: TextStyle(
                        //       color: (name != null && name != '')
                        //           ? Colors.blue
                        //           : Colors.black12),
                        // ),
                        child: Icon(Icons.done,
                            color:
                                (schedule.name != null && schedule.name != '')
                                    ? Colors.blue
                                    : Colors.black12),
                        autofocus:
                            (schedule.name != null && schedule.name != '')
                                ? true
                                : false,
                        style: OutlinedButton.styleFrom(
                            shape: StadiumBorder(),
                            side: BorderSide(
                                width: 2,
                                color: (schedule.name != null &&
                                        schedule.name != '')
                                    ? Colors.blue
                                    : Colors.black12),
                            padding: EdgeInsets.symmetric(
                                horizontal: 32, vertical: 16)),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
