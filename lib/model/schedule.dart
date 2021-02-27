import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:peace_time/model/day.dart';

class Schedule {
    final int id;
    final String name;
    final TimeOfDay start;
    final TimeOfDay end;
    final Day days;
    // Map days = {'sat':false, 'sun':false,'mon':false,'tue':false,'wed':false,'thu':false,'fri':false};
    bool status;

    Schedule({
        this.id,
        this.name,
        this.start,
        this.end,
        this.days,
        this.status,
    });

    factory Schedule.fromJson(Map<String, dynamic> jsonData) {
        return Schedule(
          id: jsonData['id'],
          name: jsonData['name'],
          status: false,
        );
    }

    static Map<String, dynamic> toMap(Schedule schedule) => {
        'id': schedule.id,
        'name': schedule.name,
        'status': schedule.status,
    };

    static String encode(List<Schedule> schedules) => json.encode(schedules.map<Map<String, dynamic>>((schedule) => Schedule.toMap(schedule)).toList(),);

    static List<Schedule> decode(String schedules) => (json.decode(schedules) as List<dynamic>).map<Schedule>((item) => Schedule.fromJson(item)).toList();
}