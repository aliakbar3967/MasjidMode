
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleController with ChangeNotifier {

  List<Schedule> schedules = List<Schedule>.empty(growable: true);
  bool selectedMode = false;
  bool isAllSelectedMode = false;
  bool isLoading = true;
  bool isDoNotDisturbPermissionStatus;

  Future<void> doNotDisturbPermissionStatus() async {
    // bool isForgroundServiceOn = await SettingsController.isRunningForgroundService();
    // print(await SettingsController.isRunningForgroundService());
    // bool isForgroundServiceRunning = await FlutterForegroundServicePlugin.isForegroundServiceRunning();
    // bool isForgroundServiceRunning = await SettingsController.isRunningForgroundService();
    isDoNotDisturbPermissionStatus = await SettingsController.getPermissionStatus();
    notifyListeners();
  }

  // String get name => schedule;
  ScheduleController() {
    doNotDisturbPermissionStatus();
    getSchedulesData();
  }

  void toggleSelectedMode() {
    selectedMode = !selectedMode;
    notifyListeners();
  }

  void toggleAllSelectedMode() {
    selectedMode = false;
    isAllSelectedMode = false;
    schedules.forEach((element) => element.isselected = false);
    notifyListeners();
  }

  void toggleScheduleSelected(index) {
    schedules[index].isselected = !schedules[index].isselected;
    notifyListeners();
  }

  void toggleAllScheduleSelectedMode() {
    if(isAllSelectedMode) schedules.forEach((element) => element.isselected = false);
    else schedules.forEach((element) => element.isselected = true);
    isAllSelectedMode = !isAllSelectedMode;
    notifyListeners();
  }

  void toggleIsloading() {
    isLoading = !isLoading;
    getSchedulesData();
    notifyListeners();
  }
  
  Future<void> getSchedulesData() async {
    // SharedPreferences prefs;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String schedulesFromPrefs = prefs.getString('__schedules');

    if(schedulesFromPrefs != null) schedules = Schedule.decode(schedulesFromPrefs);
    isLoading = false;
    notifyListeners();
  }

  Future<void> removeSchedule(index) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    schedules.removeAt(index);
    if(schedules == null || schedules.length == 0) {
      await prefs.setString('__schedules', Schedule.encode(schedules));
    }
    else {
      String encodedSchedulesList = Schedule.encode(schedules);
      await prefs.setString('__schedules', encodedSchedulesList);
    }
    final bool serviceStatus = await SettingsController.isRunningForgroundService();
    if(serviceStatus) {
      await SettingsController.stopTask();
      await SettingsController.startTask();
    }
    notifyListeners();
  }

  Future<void> removeSelectedSchedules() async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    schedules.removeWhere((element) => element.isselected == true);
    if(schedules == null || schedules.length == 0) {
      await prefs.setString('__schedules', Schedule.encode(schedules));
    }
    else {
      String encodedSchedulesList = Schedule.encode(schedules);
      await prefs.setString('__schedules', encodedSchedulesList);
    }
    isAllSelectedMode = false;
    selectedMode = false;
    final bool serviceStatus = await SettingsController.isRunningForgroundService();
    if(serviceStatus) {
      await SettingsController.stopTask();
      await SettingsController.startTask();
    }
    notifyListeners();
  }

  void toggleScheduleStatus(index) async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
        
    // String schedules = prefs.getString('__schedules');
    schedules[index].status = !schedules[index].status;
    if(schedules != null)
    {
      String encodedSchedulesList = Schedule.encode(schedules);
      await prefs.setString('__schedules', encodedSchedulesList);
    }

    final bool serviceStatus = await SettingsController.isRunningForgroundService();
    if(serviceStatus) {
      await SettingsController.stopTask();
      await SettingsController.startTask();
    }
    notifyListeners();
  }

    Future<void> store(Schedule _schedule) async
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      schedules.add(_schedule);

      String encodedSchedulesList = Schedule.encode(schedules);
      await prefs.setString('__schedules', encodedSchedulesList);

      schedules = Schedule.decode(encodedSchedulesList);
      notifyListeners();
    }
    
    Future<void> quick(int _min) async {
      
      DateTime start = DateTime.now();
      DateTime end = DateTime.now().add(Duration(minutes: 30));

      Schedule schedule = Schedule(
        name: "Quick $_min",
        start: DateFormat.jm().format(start),
        end: DateFormat.jm().format(end),
        saturday: true,
        sunday: true,
        monday: true,
        thursday: true,
        tuesday: true,
        wednesday: true,
        friday: true,
        silent: true,
        airplane: false,
        vibrate: false,
        notify: false,
        isselected: false,
        status: true,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      schedules.add(schedule);

      String encodedSchedulesList = Schedule.encode(schedules);
      await prefs.setString('__schedules', encodedSchedulesList);

      schedules = Schedule.decode(encodedSchedulesList);
      notifyListeners();
    }

    Future<void> update(schedule, index) async
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      
      if(schedules != null)
      {
        schedules[index] = schedule;

        String encodedSchedulesList = Schedule.encode(schedules);
        await prefs.setString('__schedules', encodedSchedulesList);
        schedules = Schedule.decode(encodedSchedulesList);
      }

      notifyListeners();
    }

    static Future<List<Schedule>> getSchedules() async
    {
        // SharedPreferences prefs;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        
        String schedules = prefs.getString('__schedules');
        // print(schedules);
        if(schedules == null) return null;
        else {
          List<Schedule> results = Schedule.decode(schedules);
          return results;
        }
    }

    static remove(List<Schedule> schedules, int index) async
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
        
      // String schedules = prefs.getString('__schedules');
      // List<Schedule> results = Schedule.decode(schedules);
      schedules.removeAt(index);
      print('schedules = $schedules');
      if(schedules == null || schedules.length == 0) {
        print('schedules');
        await prefs.setString('__schedules', null);
      }
      else {
        String encodedSchedulesList = Schedule.encode(schedules);
        await prefs.setString('__schedules', encodedSchedulesList);
      }
    }

    static String getDaysNames(Schedule schedule) {
      String output = '';

      if(schedule.saturday) output += 'sat, ';
      if(schedule.sunday) output += 'sun, ';
      if(schedule.monday) output += 'mon, ';
      if(schedule.thursday) output += 'thu, ';
      if(schedule.wednesday) output += 'wed, ';
      if(schedule.tuesday) output += 'tue, ';
      if(schedule.friday) output += 'fri';

      return output;
    }
}