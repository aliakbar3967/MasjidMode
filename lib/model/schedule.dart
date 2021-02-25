import 'dart:convert';

class Schedule {
  final int id;
  final String name;
  bool favorite;

  Schedule({
    this.id,
    this.name,
    this.favorite,
  });

  factory Schedule.fromJson(Map<String, dynamic> jsonData) {
    return Schedule(
      id: jsonData['id'],
      name: jsonData['name'],
      favorite: false,
    );
  }

  static Map<String, dynamic> toMap(Schedule schedule) => {
    'id': schedule.id,
    'name': schedule.name,
    'favorite': schedule.favorite,
  };

  static String encode(List<Schedule> schedules) => json.encode(schedules.map<Map<String, dynamic>>((schedule) => Schedule.toMap(schedule)).toList(),);

  static List<Schedule> decode(String schedules) => (json.decode(schedules) as List<dynamic>).map<Schedule>((item) => Schedule.fromJson(item)).toList();
}