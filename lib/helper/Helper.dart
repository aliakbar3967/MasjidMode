import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/constant.dart';

class Helper {
  static TimeOfDay fromStringToTimeOfDay(String time) {
    int hh = 0;
    if (time.endsWith('PM')) hh = 12;
    time = time.split(' ')[0];
    return TimeOfDay(
      hour: hh +
          int.parse(time.split(":")[0]) %
              24, // in case of a bad time format entered manually by the user
      minute: int.parse(time.split(":")[1]) % 60,
    );
  }

  static TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  static TimeOfDay from24StringToTimeOfDay(String tod) {
    TimeOfDay _currentTime = Helper.stringToTimeOfDay(tod);
    // _currentTime.format(context)
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  static bool isTimeBetween(String startTime, String endTime) {
    DateFormat dateFormat = new DateFormat.Hm();
    DateTime now = dateFormat.parse(DateFormat.Hm().format(DateTime.now()));
    DateTime start = dateFormat.parse(startTime).subtract(Duration(minutes: 1));
    DateTime end = dateFormat.parse(endTime);

    if (now.isAfter(start) && now.isBefore(end)) {
      // print('between true');
      return true;
    } else {
      return false;
    }
  }

  static bool isTimeAfterThisEndTime(String startTime, String endTime) {
    DateFormat dateFormat = new DateFormat.Hm();
    DateTime start = dateFormat.parse(startTime);
    DateTime end = dateFormat.parse(endTime);

    if (end.isAfter(start)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isToday(Schedule schedule) {
    String todayName;

    DateTime date = DateTime.now();
    todayName = Constant.dayNames[date.weekday];

    if (schedule.saturday == true && todayName == 'saturday')
      return true;
    else if (schedule.sunday == true && todayName == 'sunday')
      return true;
    else if (schedule.monday == true && todayName == 'monday')
      return true;
    else if (schedule.tuesday == true && todayName == 'tuesday')
      return true;
    else if (schedule.wednesday == true && todayName == 'wednesday')
      return true;
    else if (schedule.thursday == true && todayName == 'thursday')
      return true;
    else if (schedule.friday == true && todayName == 'friday')
      return true;
    else
      return false;
  }
}
