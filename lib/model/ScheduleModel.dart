import 'dart:convert';

class Schedule {
  String name;
  String type;
  String start;
  String end;
  bool silent;
  bool vibrate;
  bool airplane;
  bool notify;
  bool saturday;
  bool sunday;
  bool monday;
  bool tuesday;
  bool wednesday;
  bool thursday;
  bool friday;
  bool status;
  bool isSelected;

  Schedule({
    this.name,
    this.type,
    this.start,
    this.end,
    this.silent,
    this.vibrate,
    this.airplane,
    this.notify,
    this.saturday,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
    this.status,
    this.isSelected,
  });

  // json to schedule object
  factory Schedule.fromJson(Map<String, dynamic> jsonData) {
    return Schedule(
      name: jsonData['name'],
      type: jsonData['type'],
      start: jsonData['start'],
      end: jsonData['end'],
      silent: jsonData['silent'],
      vibrate: jsonData['vibrate'],
      airplane: jsonData['airplane'],
      notify: jsonData['notify'],
      saturday: jsonData['saturday'],
      sunday: jsonData['sunday'],
      monday: jsonData['monday'],
      tuesday: jsonData['tuesday'],
      wednesday: jsonData['wednesday'],
      thursday: jsonData['thursday'],
      friday: jsonData['friday'],
      status: jsonData['status'],
      isSelected: false,
    );
  }

  // schedule to json map
  static Map<String, dynamic> toMap(Schedule schedule) => {
        'name': schedule.name,
        'type': schedule.type,
        'start': schedule.start,
        'end': schedule.end,
        'silent': schedule.silent,
        'vibrate': schedule.vibrate,
        'airplane': schedule.airplane,
        'notify': schedule.notify,
        'saturday': schedule.saturday,
        'sunday': schedule.sunday,
        'monday': schedule.monday,
        'tuesday': schedule.tuesday,
        'wednesday': schedule.wednesday,
        'thursday': schedule.thursday,
        'friday': schedule.friday,
        'status': schedule.status,
        'isSelected': schedule.isSelected,
      };

  // encoding list of schedule
  // converting list of schedule object to json string then encode
  static String encode(List<Schedule> schedules) => json.encode(
        schedules
            .map<Map<String, dynamic>>((schedule) => Schedule.toMap(schedule))
            .toList(),
      );

  // decoding list of schedule
  // converting json map string to list of schedule object then encode
  static List<Schedule> decode(String schedules) =>
      (json.decode(schedules) as List<dynamic>)
          .map<Schedule>((item) => Schedule.fromJson(item))
          .toList();
}
