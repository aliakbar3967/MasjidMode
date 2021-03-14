
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleController with ChangeNotifier {

  List<Schedule> schedules = List<Schedule>.empty(growable: true);
  bool selectedMode = false;
  bool isAllSelectedMode = false;
  bool isLoading = true;

  // String get name => schedule;
  ScheduleController() {
    getScheduesData();
  }

  void toggleSelectedMode() {
    selectedMode = !selectedMode;
    notifyListeners();
  }

  void toggleAllSelectedMode() {
    selectedMode = false;
    isAllSelectedMode = false;
    schedules.forEach((element) => element.selected = false);
    notifyListeners();
  }

  void toggleScheduleSelected(index) {
    schedules[index].selected = !schedules[index].selected;
    notifyListeners();
  }

  void toggleAllScheduleSelectedMode() {
    schedules.forEach((element) => element.selected = !element.selected);
    isAllSelectedMode = !isAllSelectedMode;
    notifyListeners();
  }

  void toggleIsloading() {
    isLoading = !isLoading;
    getScheduesData();
    notifyListeners();
  }
  
  void getScheduesData() async {
    // SharedPreferences prefs;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    String schedulesFromPrefs = prefs.getString('__schedules');

    schedules = Schedule.decode(schedulesFromPrefs);
    isLoading = false;
    notifyListeners();
  }

  Future<void> removeSchedule(index) async {
    SettingsController.stopTask();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    schedules.removeAt(index);
    if(schedules == null || schedules.length == 0) {
      await prefs.setString('__schedules', Schedule.encode(schedules));
    }
    else {
      String encodedSchedulesList = Schedule.encode(schedules);
      await prefs.setString('__schedules', encodedSchedulesList);
    }
    SettingsController.startTask();
    notifyListeners();
  }

  void updateScheduleSelected(index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
        
    // String schedules = prefs.getString('__schedules');
    schedules[index].status = !schedules[index].status;
    if(schedules != null)
    {
      String encodedSchedulesList = Schedule.encode(schedules);
      await prefs.setString('__schedules', encodedSchedulesList);
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
      // print('no data fount. data store failed.');
      // print('Data remove done');
      // print(results);
    }
}