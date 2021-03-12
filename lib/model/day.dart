import 'dart:convert';
class Day {
    final bool sat;
    final bool sun;
    final bool mon;
    final bool tue;
    final bool wed;
    final bool thu;
    final bool fri;

    Day({
        this.sat,
        this.sun,
        this.mon,
        this.tue,
        this.wed,
        this.thu,
        this.fri,
    });

    factory Day.fromJson(Map<String, dynamic> jsonData) {
      return Day(
        sat: jsonData['sat'],
        sun: jsonData['sun'],
        mon: jsonData['mon'],
        tue: jsonData['tue'],
        wed: jsonData['wed'],
        thu: jsonData['thu'],
        fri: jsonData['fri'],
      );
    }

    static Map<String, dynamic> toMap(Day day) => {
        'sat': day.sat,
        'sun': day.sun,
        'mon': day.mon,
        'tue': day.tue,
        'wed': day.wed,
        'thu': day.thu,
        'fri': day.fri,
    };

    static Day decode(String day) {
      Map<dynamic,dynamic> _mapDay = jsonDecode(day);
      Day _jsonDay = Day.fromJson(_mapDay);
      return _jsonDay;
    }

    // static bool isDayTrue(String name)

    static String getDaysNames(String day) {
      Day _day = Day.decode(day);
      String _resultString = '';
      if(_day.sat) _resultString += 'sat, ';
      if(_day.sun) _resultString += 'sun, ';
      if(_day.mon) _resultString += 'mon, ';
      if(_day.thu) _resultString += 'thu, ';
      if(_day.wed) _resultString += 'wed, ';
      if(_day.tue) _resultString += 'tue, ';
      if(_day.fri) _resultString += 'fri' ;
      // print(_resultString);
      return _resultString;
    }
}