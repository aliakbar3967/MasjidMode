
import 'dart:convert';

import 'package:peace_time/model/schedule.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScheduleController {

    static store(Schedule _schedule) async
    {
        print(_schedule);
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
          print('Data stored done');
        } else {
          Map<String, dynamic> jsonSchedule = Schedule.toMap(_schedule);
          String encodedStringSchedule = json.encode(jsonSchedule);
          print(encodedStringSchedule); // single schedule string

          String encodedSchedulesList = Schedule.encode([_schedule]);
          await prefs.setString('__schedules', encodedSchedulesList);
          // print('no data fount. data store failed.');
          print('Data stored done');
        }
    }

    static Future<List<Schedule>> getSchedules() async
    {
        // SharedPreferences prefs;
        SharedPreferences prefs = await SharedPreferences.getInstance();
        
        String schedules = prefs.getString('__schedules');
        List<Schedule> results = Schedule.decode(schedules);
        // print(schedules);
        // String counter = _map.toString();
        // final List<Map<String, dynamic>> counter = jsonDecode(prefs.getString('_schedules'));
        // print(counter);
        // await prefs.setString('__schedule', encodedData);
        return results;
    }

    static remove(int index) async
    {
      SharedPreferences prefs = await SharedPreferences.getInstance();
        
      String schedules = prefs.getString('__schedules');
      List<Schedule> results = Schedule.decode(schedules);

      results.removeAt(index);

      String encodedSchedulesList = Schedule.encode(results);
      await prefs.setString('__schedules', encodedSchedulesList);
      // print('no data fount. data store failed.');
      print('Data remove done');
      // print(results);
    }
}