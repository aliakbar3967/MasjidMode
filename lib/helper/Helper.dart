import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/constant.dart';

class Helper {
  static TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  static bool isTimeBetween(String start, String end) {
    TimeOfDay startTime = Helper.stringToTimeOfDay(start);
    TimeOfDay endTime = Helper.stringToTimeOfDay(end);
    // print("start $startTime and end $endTime");
    // TimeOfDay currentTime = fromString("12:40 PM");
    TimeOfDay currentTime = TimeOfDay.now();
    // print(currentTime);

    double _doubleCurrentTime =
        currentTime.hour.toDouble() + (currentTime.minute.toDouble() / 60);
    double _doubleStartTime =
        startTime.hour.toDouble() + (startTime.minute.toDouble() / 60);
    double _doubleEndTime =
        endTime.hour.toDouble() + (endTime.minute.toDouble() / 60);

    double _timeDiffAfter = _doubleCurrentTime - _doubleStartTime;
    double _timeDiffBefore = _doubleEndTime - _doubleCurrentTime;

    // double _hrDiffAfter = _timeDiffAfter.truncate() * 1.0;
    double _minuteIsAfter = (_timeDiffAfter - _timeDiffAfter.truncate()) * 60;
    // double _hrDiffBefore = _timeDiffBefore.truncate() * 1.0;
    // print("_minute");
    // print("After");
    // print(_minuteIsAfter.toString());
    double _minuteIsBefore =
        (_timeDiffBefore - _timeDiffBefore.truncate()) * 60;
    // print("Before");
    // print(_minuteIsBefore.toString());
    if (_minuteIsAfter >= 0 && _minuteIsBefore >= 1)
      return true;
    else
      return false;
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
