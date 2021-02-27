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
}