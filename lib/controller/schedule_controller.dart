
import 'dart:convert';

import 'package:peace_time/model/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleController {

    static store(Schedule _schedule) async
    {
        // print(_schedule);
        // SharedPreferences prefs;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        
        String schedules = prefs.getString('__schedules');
        if(schedules != null)
        {
          List<Schedule> decodedSchedules = Schedule.decode(schedules);
          decodedSchedules.add(_schedule);

          String encodedSchedulesList = Schedule.encode(decodedSchedules);
          await prefs.setString('__schedules', encodedSchedulesList);
          // print(encodedSchedulesList);
          // print('Data stored done');
        } else {
          Map<String, dynamic> jsonSchedule = Schedule.toMap(_schedule);
          String encodedStringSchedule = json.encode(jsonSchedule);
          // print(encodedStringSchedule); // single schedule string

          String encodedSchedulesList = Schedule.encode([_schedule]);
          await prefs.setString('__schedules', encodedSchedulesList);
          // print('no data fount. data store failed.');
          // print('Data stored done');
        }
    }

    static update(List<Schedule> _schedules) async
    {
        // print(_schedule);
        // SharedPreferences prefs;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        
        // String schedules = prefs.getString('__schedules');
        if(_schedules != null)
        {
          // List<Schedule> decodedSchedules = Schedule.decode(_schedules);
          // decodedSchedules.add(_schedule);

          String encodedSchedulesList = Schedule.encode(_schedules);
          await prefs.setString('__schedules', encodedSchedulesList);
          // print(encodedSchedulesList);
          // print('Data stored done');
        }
        //  else {
        //   // Map<String, dynamic> jsonSchedule = Schedule.toMap(_schedule);
        //   // String encodedStringSchedule = json.encode(jsonSchedule);
        //   // print(encodedStringSchedule); // single schedule string

        //   // String encodedSchedulesList = Schedule.encode([_schedule]);
        //   await prefs.setString('__schedules', null);
        //   // print('no data fount. data store failed.');
        //   // print('Data stored done');
        // }
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
      // print('schedules = ${results.length}');
      if(schedules == null || schedules.length == 0) await prefs.setString('__schedules', null);
      else {
        String encodedSchedulesList = Schedule.encode(schedules);
        await prefs.setString('__schedules', encodedSchedulesList);
      }
      // print('no data fount. data store failed.');
      // print('Data remove done');
      // print(results);
    }
}