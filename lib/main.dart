import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:peace_time/screens/create_schedule_screen.dart';
import 'package:peace_time/screens/home_screen.dart';
import 'package:peace_time/widgets/checkbox.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

/// Global [SharedPreferences] object.
SharedPreferences prefs;

void main() {
  runApp(RootScreen());
}

class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peace Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

