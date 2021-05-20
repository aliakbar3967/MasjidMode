
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
  bool isIntroductionDone = false;


  // String get name => schedule;
  ScheduleController() {
    // SettingsController.startForgroundServiceAndTask();
    // getIntroduction();
    doNotDisturbPermissionStatus();
    getSchedulesData();
  }
  
  Future<void> doNotDisturbPermissionStatus() async {
    // bool isForgroundServiceOn = await SettingsController.isRunningForgroundService();
    // print(await SettingsController.isRunningForgroundService());
    // bool isForgroundServiceRunning = await FlutterForegroundServicePlugin.isForegroundServiceRunning();
    // bool isForgroundServiceRunning = await SettingsController.isRunningForgroundService();
    isDoNotDisturbPermissionStatus = await SettingsController.getPermissionStatus();
    notifyListeners();
  }

  Future<void> setIntroductionDone({bool value}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('__intro', value);
    isIntroductionDone = value;
    notifyListeners();
  }

  Future<void> toggleIntroductionDone() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool('__intro', !isIntroductionDone);
    isIntroductionDone = !isIntroductionDone;
    notifyListeners();
  }

  static Future<bool> getIntroductionScreenStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    bool output = prefs.getBool('__intro');
    return output;
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

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }
  
  Future<void> getSchedulesData() async {
    // SharedPreferences prefs;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    final format = DateFormat.jm();
    
    bool setdefaultdata = prefs.getBool('__default_schedule');
    if(setdefaultdata == null) {
      Schedule fajr = Schedule(
        name: 'Fajr',
        start: DateFormat.jm().format(format.parse('4:40 AM')),
        end: DateFormat.jm().format(format.parse('5:20 AM')),
        silent: true,
        vibrate: false,
        airplane: false,
        notify: false,
        saturday: true,
        sunday: true,
        monday: true,
        tuesday: true,
        wednesday: true,
        thursday: true,
        friday: true,
        status: true,
        isselected: false,
      );
      Schedule dhuhr = Schedule(
        name: 'Dhuhr',
        start: DateFormat.jm().format(format.parse('1:00 PM')),
        end: DateFormat.jm().format(format.parse('1:40 PM')),
        silent: true,
        vibrate: false,
        airplane: false,
        notify: false,
        saturday: true,
        sunday: true,
        monday: true,
        tuesday: true,
        wednesday: true,
        thursday: true,
        friday: true,
        status: true,
        isselected: false,
      );
      Schedule asr = Schedule(
        name: 'Asr',
        start: DateFormat.jm().format(format.parse('4:30 PM')),
        end: DateFormat.jm().format(format.parse('5:10 PM')),
        silent: true,
        vibrate: false,
        airplane: false,
        notify: false,
        saturday: true,
        sunday: true,
        monday: true,
        tuesday: true,
        wednesday: true,
        thursday: true,
        friday: true,
        status: true,
        isselected: false,
      );
      Schedule maghrib = Schedule(
        name: 'Maghrib',
        start: DateFormat.jm().format(format.parse('6:20 PM')),
        end: DateFormat.jm().format(format.parse('7:00 PM')),
        silent: true,
        vibrate: false,
        airplane: false,
        notify: false,
        saturday: true,
        sunday: true,
        monday: true,
        tuesday: true,
        wednesday: true,
        thursday: true,
        friday: true,
        status: true,
        isselected: false,
      );
      Schedule isa = Schedule(
        name: 'Isha',
        start: DateFormat.jm().format(format.parse('7:50 PM')),
        end: DateFormat.jm().format(format.parse('8:30 PM')),
        silent: true,
        vibrate: false,
        airplane: false,
        notify: false,
        saturday: true,
        sunday: true,
        monday: true,
        tuesday: true,
        wednesday: true,
        thursday: true,
        friday: true,
        status: true,
        isselected: false,
      );
      schedules.add(fajr);
      schedules.add(dhuhr);
      schedules.add(asr);
      schedules.add(maghrib);
      schedules.add(isa);

      String encodedSchedulesList = Schedule.encode(schedules);
      await prefs.setString('__schedules', encodedSchedulesList);

      schedules = Schedule.decode(encodedSchedulesList);

      await prefs.setBool('__default_schedule', true);
    }

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
        name: "Quick $_min"+"m",
        start: DateFormat.jm().format(start),
        end: DateFormat.jm().format(end),
        saturday: true,
        sunday: true,
        monday: true,
        tuesday: true,
        wednesday: true,
        thursday: true,
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
	  
		final bool serviceStatus = await SettingsController.isRunningForgroundService();
		if(serviceStatus) {
		  await SettingsController.stopTask();
		  await SettingsController.startTask();
		}
	
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
      if(schedule.tuesday) output += 'tue, ';
      if(schedule.wednesday) output += 'wed, ';
      if(schedule.thursday) output += 'thu, ';
      if(schedule.friday) output += 'fri';

      return output;
    }
}