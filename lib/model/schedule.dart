import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:peace_time/model/day.dart';

class Schedule {
    String name;
    String start;
    String end;
    String days;
    String options;
    bool selected;
    // Map days = {'sat':false, 'sun':false,'mon':false,'tue':false,'wed':false,'thu':false,'fri':false};
    bool status;

    Schedule({
        this.name,
        this.start,
        this.end,
        this.days,
        this.options,
        this.status,
        this.selected,
    });

    factory Schedule.fromJson(Map<String, dynamic> jsonData) {
        return Schedule(
          name: jsonData['name'],
          start: jsonData['start'],
          end: jsonData['end'],
          days: jsonData['days'],
          options: jsonData['options'],
          status: jsonData['status'],
          selected: false,
        );
    }

    static Map<String, dynamic> toMap(Schedule schedule) => {
        'name': schedule.name,
        'start': schedule.start,
        'end': schedule.end,
        'days': schedule.days,
        'options': schedule.options,
        'status': schedule.status,
        'selected': schedule.selected,
    };

    static String encode(List<Schedule> schedules) => json.encode(schedules.map<Map<String, dynamic>>((schedule) => Schedule.toMap(schedule)).toList(),);

    static List<Schedule> decode(String schedules) => (json.decode(schedules) as List<dynamic>).map<Schedule>((item) => Schedule.fromJson(item)).toList();
}