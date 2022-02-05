import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/schedule/CreateDateScheduleScreen.dart';
import 'package:peace_time/screen/schedule/CreateScreen.dart';
import 'package:provider/provider.dart';

class HomeBottomSheet extends StatefulWidget {
  @override
  _HomeBottomSheetState createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  int _minute = 30;

  void increment(value) {
    setState(() {
      _minute += value;
    });
  }

  void decrement(value) {
    if (_minute - value >= 30) {
      setState(() {
        _minute -= value;
      });
    } else {
      setState(() {
        _minute = 30;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          shape: StadiumBorder(),
          leading: const Icon(Icons.schedule),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('Daily Schedule'),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => CreateScreen()),
          ).then((response) => response ? Navigator.of(context).pop() : null),
        ),
        ListTile(
          shape: StadiumBorder(),
          leading: const Icon(Icons.calendar_today_sharp),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('Calender Schedule'),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => CreateDateScheduleScreen()),
          ).then((response) => response ? Navigator.of(context).pop() : null),
        ),
        ListTile(
          shape: StadiumBorder(),
          leading: const Icon(Icons.volume_off_sharp),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Quick Silent'),
              Container(
                padding: EdgeInsets.all(3),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Theme.of(context).primaryColor),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () => decrement(5),
                        child: Icon(Icons.remove, color: Colors.white)),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 3),
                      padding: EdgeInsets.symmetric(horizontal: 3, vertical: 2),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(3),
                          color: Colors.white),
                      child: Text(
                        _minute.toString(),
                        style: TextStyle(color: Colors.black, fontSize: 16),
                      ),
                    ),
                    InkWell(
                        onTap: () => increment(5),
                        child: Icon(Icons.add, color: Colors.white)),
                  ],
                ),
              ),
              // IconButton(onPressed: () {}, icon: Icon(Icons.done))
            ],
          ),
          onTap: () {
            Provider.of<ScheduleProvider>(context, listen: false)
                .quick(_minute);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
