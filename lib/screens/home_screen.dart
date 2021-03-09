import 'package:flutter/cupertino.dart';
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
          title: Text('Schedules'),
          actions: [
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => SettingsScreen()),).then((response)=>response?_getSchedulesDataFromSharedPreference():null),
            ),
          ],
          elevation: 0,
        ),
        floatingActionButton: FloatingActionButton(
          // elevation: 0.0,
          child: new Icon(Icons.add, size: 48.0,),
          backgroundColor: Colors.blue,
          onPressed: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => CreateSchduleScreen()),).then((response)=>response?_getSchedulesDataFromSharedPreference():null)
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: loading ? nodata ? Center(child: Text('No Data Found!')) : Center(child: CircularProgressIndicator(),) :SafeArea(
          child: Column(
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     Text(
              //       'Schedule',
              //       style: TextStyle(
              //           fontFamily: 'avenir',
              //           fontWeight: FontWeight.w100,
              //           fontSize: 20),
              //     ),
              //     Row(
              //       children: [
              //         Icon(Icons.settings, color: Colors.black45,)
              //       ],
              //     )
              //   ],
              // ),
              // SizedBox(height: 8.0,),
              Expanded(
                child: ListView.builder(
                  // padding: const EdgeInsets.all(8),
                  itemCount: schedules.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => EditSchduleScreen()),).then((response)=>response?_getSchedulesDataFromSharedPreference():null),
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 24),
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.blueAccent],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                          // color: Colors.black12,
                          boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 8,
                                spreadRadius: 2,
                                offset: Offset(4, 4),
                              ),
                            ], 
                            // borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${schedules[index].name}"),
                                Switch(
                                  value: schedules[index].status, 
                                  onChanged: (bool value) async {
                                    await ScheduleController.remove(index);
                                    _getSchedulesDataFromSharedPreference();
                                  },
                                  activeColor: Colors.white,
                                ),
                              ],
                            ),
                            SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "${schedules[index].start} - ${schedules[index].end}",
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
                      ),
                    );
                  }
                ),
              ),
            ],
          ),
        ),
      );
  }
}

