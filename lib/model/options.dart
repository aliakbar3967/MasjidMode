
import 'dart:convert';

class Option {
  final bool silent;
  final bool airplane;
  final bool vibrate;
  final bool notifyme;

  Option({this.silent,this.airplane,this.notifyme,this.vibrate});

  factory Option.fromJson(Map<String, dynamic> jsonData) {
      return Option(
        silent: jsonData['silent'],
        airplane: jsonData['airplane'],
        vibrate: jsonData['vibrate'],
        notifyme: jsonData['notifyme'],
      );
    }

    static Map<String, dynamic> toMap(Option option) => {
        'silent': option.silent,
        'airplane': option.airplane,
        'vibrate': option.vibrate,
        'notifyme': option.notifyme,
    };

    static Option decode(String option) {
      Map<dynamic,dynamic> _mapOption = jsonDecode(option);
      Option _jsonOption = Option.fromJson(_mapOption);
      return _jsonOption;
    }

    // static bool isDayTrue(String name)

    static String getOptionsNames(String option) {
      Option _option = Option.decode(option);
      String _resultString = '';
      if(_option.silent) _resultString += 'silent, ';
      if(_option.airplane) _resultString += 'airplane, ';
      if(_option.vibrate) _resultString += 'vibrate, ';
      if(_option.notifyme) _resultString += 'notifyme, ';
      // print(_resultString);
      return _resultString;
    }
}