import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/ScheduleController.dart';
import 'package:peace_time/job/ForgroundService.dart';
import 'package:peace_time/model/ScheduleModel.dart';

class ScheduleProvider with ChangeNotifier {
  List<Schedule> schedules = List<Schedule>.empty(growable: true);
  bool selectedMode = false;
  bool isLoading = true;
  bool isAllSelectedMode = false;
  int count = 0;

  // String get name => schedule;
  ScheduleProvider() {
    initialize();
  }

  Future<void> initialize() async {
    // final format = DateFormat.jm();

    // bool setdefaultdata = await DBController.getDefaultSchedulesStatus();
    // if (setdefaultdata == null) {
    //   Schedule fajr = Schedule(
    //     name: 'Fajr',
    //     start: DateFormat.jm().format(format.parse('4:40 AM')),
    //     end: DateFormat.jm().format(format.parse('5:20 AM')),
    //     silent: true,
    //     vibrate: false,
    //     airplane: false,
    //     notify: false,
    //     saturday: true,
    //     sunday: true,
    //     monday: true,
    //     tuesday: true,
    //     wednesday: true,
    //     thursday: true,
    //     friday: true,
    //     status: true,
    //     isSelected: false,
    //   );
    //   Schedule dhuhr = Schedule(
    //     name: 'Dhuhr',
    //     start: DateFormat.jm().format(format.parse('1:00 PM')),
    //     end: DateFormat.jm().format(format.parse('1:40 PM')),
    //     silent: true,
    //     vibrate: false,
    //     airplane: false,
    //     notify: false,
    //     saturday: true,
    //     sunday: true,
    //     monday: true,
    //     tuesday: true,
    //     wednesday: true,
    //     thursday: true,
    //     friday: true,
    //     status: true,
    //     isSelected: false,
    //   );
    //   Schedule asr = Schedule(
    //     name: 'Asr',
    //     start: DateFormat.jm().format(format.parse('4:30 PM')),
    //     end: DateFormat.jm().format(format.parse('5:10 PM')),
    //     silent: true,
    //     vibrate: false,
    //     airplane: false,
    //     notify: false,
    //     saturday: true,
    //     sunday: true,
    //     monday: true,
    //     tuesday: true,
    //     wednesday: true,
    //     thursday: true,
    //     friday: true,
    //     status: true,
    //     isSelected: false,
    //   );
    //   Schedule maghrib = Schedule(
    //     name: 'Maghrib',
    //     start: DateFormat.jm().format(format.parse('6:20 PM')),
    //     end: DateFormat.jm().format(format.parse('7:00 PM')),
    //     silent: true,
    //     vibrate: false,
    //     airplane: false,
    //     notify: false,
    //     saturday: true,
    //     sunday: true,
    //     monday: true,
    //     tuesday: true,
    //     wednesday: true,
    //     thursday: true,
    //     friday: true,
    //     status: true,
    //     isSelected: false,
    //   );
    //   Schedule isa = Schedule(
    //     name: 'Isha',
    //     start: DateFormat.jm().format(format.parse('7:50 PM')),
    //     end: DateFormat.jm().format(format.parse('8:30 PM')),
    //     silent: true,
    //     vibrate: false,
    //     airplane: false,
    //     notify: false,
    //     saturday: true,
    //     sunday: true,
    //     monday: true,
    //     tuesday: true,
    //     wednesday: true,
    //     thursday: true,
    //     friday: true,
    //     status: true,
    //     isSelected: false,
    //   );
    //   schedules.add(fajr);
    //   schedules.add(dhuhr);
    //   schedules.add(asr);
    //   schedules.add(maghrib);
    //   schedules.add(isa);
    //
    //   String encodedSchedulesList = Schedule.encode(schedules);
    //   await DBController.setSchedules(encodedSchedulesList);
    //
    //   schedules = Schedule.decode(encodedSchedulesList);
    //   await DBController.setDefaultSchedulesStatus(true);
    // }

    String schedulesFromPrefs = await DBController.getSchedules();
    if (schedulesFromPrefs != null) {
      schedules = Schedule.decode(schedulesFromPrefs);
    }

    isLoading = false;
    notifyListeners();
  }

  Future<void> toggleScheduleStatus(index) async {
    if (schedules != null) {
      schedules[index].status = !schedules[index].status;
      String encodedSchedulesList = Schedule.encode(schedules);
      await DBController.setSchedules(encodedSchedulesList);

      await ForgroundService.refresh();
      notifyListeners();
    }
  }

  Future<void> add(Schedule _schedule) async {
    schedules.add(_schedule);

    String encodedSchedulesList = Schedule.encode(schedules);
    await DBController.setSchedules(encodedSchedulesList);

    schedules = Schedule.decode(encodedSchedulesList);
    notifyListeners();
  }

  Future<void> update(schedule, index) async {
    if (schedules != null) {
      schedules[index] = schedule;
      String encodedSchedulesList = Schedule.encode(schedules);
      await DBController.setSchedules(encodedSchedulesList);

      await ForgroundService.refresh();
      schedules = Schedule.decode(encodedSchedulesList);
      notifyListeners();
    }
  }

  Future<void> remove(index) async {
    schedules.removeAt(index);
    if (schedules == null || schedules.length == 0) {
      await DBController.setSchedules(Schedule.encode(schedules));
    } else {
      String encodedSchedulesList = Schedule.encode(schedules);
      await DBController.setSchedules(encodedSchedulesList);
    }

    await ForgroundService.refresh();
    notifyListeners();
  }

  Future<void> toggleScheduleSelection(index) async {
    schedules[index].isSelected = !schedules[index].isSelected;
    selectedScheduleItems();
    notifyListeners();
  }

  Future<void> toggleAllScheduleSelection() async {
    if (isAllSelectedMode)
      schedules.forEach((element) => element.isSelected = false);
    else
      schedules.forEach((element) => element.isSelected = true);
    isAllSelectedMode = !isAllSelectedMode;
    selectedScheduleItems();
    notifyListeners();
  }

  Future<void> selectedScheduleItems() async {
    count = 0;
    schedules.forEach((element) {
      if (element.isSelected == true) {
        count++;
      }
    });
    notifyListeners();
  }

  Future<void> removeMultiple() async {
    schedules.removeWhere((element) => element.isSelected == true);
    if (schedules == null || schedules.length == 0) {
      await DBController.setSchedules(Schedule.encode(schedules));
    } else {
      String encodedSchedulesList = Schedule.encode(schedules);
      await DBController.setSchedules(encodedSchedulesList);
    }
    isAllSelectedMode = false;
    selectedMode = false;

    await ForgroundService.refresh();
    notifyListeners();
  }

  Future<void> setIsAllSelectedMode(bool bool) async {
    isAllSelectedMode = bool;
    notifyListeners();
  }

  Future<void> quick(int _min) async {
    // DateTime start = DateTime.now();
    // DateTime end = DateTime.now().add(Duration(minutes: 30));

    // print(DateFormat.jm().format(start));
    DateTime start =
        DateFormat.jm().parse(DateFormat.jm().format(DateTime.now()));
    DateTime end = DateFormat.jm().parse(
        DateFormat.jm().format(DateTime.now().add(Duration(minutes: 30))));
    // print(DateFormat("HH:mm").format(date));
    // final dd = DateFormat("HH:mm").format(date);
    // print("start $start and end $end");
    // return;
    Schedule schedule = Schedule(
      name: "Quick $_min" + "m",
      start: DateFormat("HH:mm").format(start),
      end: DateFormat("HH:mm").format(end),
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
      isSelected: false,
      status: true,
    );
    schedules.add(schedule);

    String encodedSchedulesList = Schedule.encode(schedules);
    await DBController.setSchedules(encodedSchedulesList);

    // this line should place before set provider schedules list, otherwise app will crash
    await ForgroundService.refresh();

    schedules = Schedule.decode(encodedSchedulesList);

    notifyListeners();
  }

  Future<void> restoreDB() async {
    await DBController.restore();
    schedules = List<Schedule>.empty(growable: true);
    await ForgroundService.refresh();
    notifyListeners();
  }
}
