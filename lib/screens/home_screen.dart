import 'package:flutter/material.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:peace_time/screens/create_schedule_screen.dart';
import 'package:peace_time/widgets/checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Map<String> options = {'1','2','3','4','5','6','7','8','9','0'};
  List options = [1,2,3,4,5,6,7,8,9,0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          // elevation: 0.0,
          child: new Icon(Icons.add, size: 48.0,),
          backgroundColor: Colors.blue,
          onPressed: () => Navigator.push(context,MaterialPageRoute(builder: (context) => CreateSchduleScreen()),)
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
      );
  }
}

