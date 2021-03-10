import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:peace_time/screens/create_schedule_screen.dart';
import 'package:peace_time/screens/edit_schedule_screen.dart';
import 'package:peace_time/screens/settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Schedule> schedules;

  bool loading = true;
  bool nodata = false;
  bool selectingmode = false;

  void _getSchedulesDataFromSharedPreference() async {
    setState(() {
      loading = true;
    });
    List<Schedule> results = await ScheduleController.getSchedules();
    // print(results);
    if(results == null)
    {
      setState(() {
        schedules = null;
        nodata = true;
      });
    }
    else {
      setState(() {
        schedules = results;
        loading = false;
        nodata = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getSchedulesDataFromSharedPreference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: selectingmode
          ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              setState(() {
                selectingmode = false;
                schedules.forEach((element) => element.selected = false);
              });
            },
          ) : null,
          title: Text("Schedules"),
          actions: [
            IconButton(
              icon: selectingmode ? Icon(Icons.check_box_outline_blank) : Icon(Icons.settings),
              onPressed: () {
                if(selectingmode) {
                } else {
                  Navigator.push(context,CupertinoPageRoute(builder: (context) => SettingsScreen()),).then((response)=>response?_getSchedulesDataFromSharedPreference():null);
                }

              }
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          // elevation: 0.0,
          child: new Icon(Icons.add, size: 48.0,),
          backgroundColor: Colors.blue,
          onPressed: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => CreateSchduleScreen()),).then((response)=>response?_getSchedulesDataFromSharedPreference():null)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: loading 
        ? nodata 
        ? Center(child: Text('No Data Found!')) 
        : Center(child: CircularProgressIndicator(),) 
        : SafeArea(
          child: ListView(
            children: List.generate(schedules.length, (index) {
              return ListTile(
                // tileColor:  Colors.blue,
                // selectedTileColor: Colors.blue[200],
                onLongPress: () {
                  setState(() {
                    selectingmode = true;
                  });
                },
                onTap: () {
                  if(selectingmode) {
                    setState(() {
                        schedules[index].selected = !schedules[index].selected;
                        print(schedules[index].selected.toString());
                    });
                  } else {
                    Navigator.push(context,CupertinoPageRoute(builder: (context) => EditSchduleScreen()),).then((response)=>response?_getSchedulesDataFromSharedPreference():null);
                  }
                },
                selected: schedules[index].selected,
                title: Text(
                  schedules[index].name.toString().toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'avenir',
                    // fontWeight: FontWeight.w100,
                    fontSize: 24,
                    color: Colors.black
                  ),
                ),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${schedules[index].start} - ${schedules[index].end}",
                      style: TextStyle(
                        fontFamily: 'avenir',
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                        color: Colors.black
                      ),
                    ),
                    Wrap(
                        spacing: 6.0,
                        runSpacing: 6.0,
                        children: [
                          Chip(
                            label: Text('S'),
                          ),
                          Chip(
                            label: Text('S'),
                          ),
                          Chip(
                            label: Text('M'),
                          ),
                          Chip(
                            label: Text('T'),
                          ),
                          Chip(
                            label: Text('W'),
                          ),
                          Chip(
                            label: Text('T'),
                          ),
                          Chip(
                            label: Text('F'),
                          ),
                        ],
                      ),
                  ],
                ),
                trailing: (selectingmode)
                ? ((schedules[index].selected)
                ? Icon(Icons.check_box)
                : Icon(Icons.check_box_outline_blank))
                : Switch (
                  value: schedules[index].status, 
                  onChanged: (bool value) async {
                    await ScheduleController.remove(index);
                    _getSchedulesDataFromSharedPreference();
                  },
                  activeColor: Colors.white,
                ),
              );
            }),
          ),
        ),
      );
  }
}

