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

  static bool isTimeBetween(String startTimeString, String endTimeString) {
    // DateFormat dateFormat = new DateFormat.Hm();
    DateTime nowTime = DateTime.now();
    DateTime startTime = DateTime.parse(startTimeString);
    DateTime endTime = DateTime.parse(endTimeString);
    // .subtract(Duration(minutes: 1));
    DateTime now = DateTime(2021, 04, 12, nowTime.hour, nowTime.minute);
    DateTime start = DateTime(2021, 04, 12, startTime.hour, startTime.minute);
    DateTime end = DateTime(2021, 04, 12, endTime.hour, endTime.minute);
    if (startTime.day != endTime.day) {
      if (now.isBefore(end)) {
        // end = DateTime(
        //     2021, 04, now.day, endTime.hour, endTime.minute);
        start = DateTime(2021, 04, 12 - 1, startTime.hour, startTime.minute);
      } else if (now.isAfter(start)) {
        end = DateTime(2021, 04, 12 + 1, endTime.hour, endTime.minute);
      }
    }
    // print('now = ' + now.toString());
    // print('start = ' + start.toString());
    // print('end = ' + end.toString());
    // print('-------------');
    // var format = DateFormat("HH:mm");
    // var one = format.parse("10:40");
    // var two = format.parse("18:20");
    // print("${now.difference(startTime).inDays}");
    // print("${now.isBefore(end)}");

    // if (endTime.difference(startTime) > 0) {
    // if (endTime.isAfter(startTime)) {
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

  static bool isEndTimeBeforeStartTime(String startTime, String endTime) {
    DateTime start = DateTime.parse(startTime);
    DateTime end = DateTime.parse(endTime);

    if (end.isBefore(start)) {
      return true;
    } else {
      return false;
    }
  }

  static bool isNextDay(String startTime, String endTime) {
    DateTime start = DateTime.parse(startTime);
    DateTime end = DateTime.parse(endTime);
    // DateTime now = DateTime.now();
    if (DateTime(end.year, end.month, end.day)
            .difference(DateTime(start.year, start.month, start.day))
            .inDays ==
        1) {
      return true;
    } else {
      return false;
    }
  }

  static String timeText(String timeString, BuildContext context) {
    bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
    String time = '';
    if (is24HoursFormat) {
      time = DateFormat.Hm().format(DateTime.parse(timeString));
    } else {
      time = DateFormat.jm().format(DateTime.parse(timeString));
    }
    return time;
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
