import 'package:flutter/material.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:peace_time/widgets/checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
      id: 1,
      name: name,
      start: start,
      end: end,
      days: jsonEncode(days),
      options: jsonEncode(options),
      status: true
    );
    String encoded = Schedule.encode([hold]);
    print(encoded);
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
      );
  }
}
