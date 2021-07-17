import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/helper/Helper.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/AppInfoScreen.dart';
import 'package:peace_time/screen/schedule/CreateDateScheduleScreen.dart';
import 'package:peace_time/screen/schedule/CreateScreen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:peace_time/screen/HelpScreen.dart';
import 'package:peace_time/screen/SettingsScreen.dart';

Widget dayChip(name, isActive, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Text(
      name,
      style: TextStyle(
        fontSize: 0.03 * MediaQuery.of(context).size.width,
        color:
            isActive ? Colors.blue : Theme.of(context).chipTheme.disabledColor,
      ),
    ),
  );
}

Widget dropDownMenus() {
  return Padding(
    padding: EdgeInsets.only(right: 10.0),
    child: PopupMenuButton(
      // color: Colors.grey[850],
      tooltip: 'Menu',
      child: Icon(
        Icons.more_vert,
        size: 28.0,
        // color: Colors.grey[400],
      ),
      itemBuilder: (context) => [
        PopupMenuItem(
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => SettingsScreen()),
            ).then((response) => null),
            // onTap: () => _incrementTab(1),
            child: Row(
              children: [
                Icon(
                  Icons.settings,
                  color: Theme.of(context).iconTheme.color,
                  size: 22.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "Settings",
                    style: TextStyle(
                      // color: Colors.grey[400],
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: GestureDetector(
            onTap: () => Share.share(
                "Peace Time - A Silent Scheduler App. Please visit https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time and download this awesome app.",
                subject: 'Peace Time - A Silent Scheduler App.'),
            child: Row(
              children: [
                Icon(
                  Icons.share,
                  color: Theme.of(context).iconTheme.color,
                  size: 22.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "Share",
                    style: TextStyle(
                      // color: Colors.grey[400],
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: GestureDetector(
            onTap: () async => await canLaunch(
                    "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
                ? await launch(
                    "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
                : throw 'Could not launch',
            child: Row(
              children: [
                Icon(
                  Icons.star,
                  color: Theme.of(context).iconTheme.color,
                  size: 22.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "Rate this app",
                    style: TextStyle(
                      // color: Colors.grey[400],
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: GestureDetector(
            onTap: () async => await canLaunch(
                    "https://fivepeacetime.blogspot.com/p/privacy-policy.html")
                ? await launch(
                    "https://fivepeacetime.blogspot.com/p/privacy-policy.html")
                : throw 'Could not launch',
            child: Row(
              children: [
                Icon(
                  Icons.privacy_tip,
                  color: Theme.of(context).iconTheme.color,
                  size: 22.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "Privacy policy",
                    style: TextStyle(
                      // color: Colors.grey[400],
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => HelpScreen()),
            ).then((response) => null),
            child: Row(
              children: [
                Icon(
                  Icons.help,
                  color: Theme.of(context).iconTheme.color,
                  size: 22.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "Help",
                    style: TextStyle(
                      // color: Colors.grey[400],
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: GestureDetector(
            onTap: () => Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => AppInfoScreen()),
            ).then((response) => null),
            child: Row(
              children: [
                Icon(
                  Icons.info,
                  color: Theme.of(context).iconTheme.color,
                  size: 22.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "App Info",
                    style: TextStyle(
                      // color: Colors.grey[400],
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuItem(
          child: GestureDetector(
            onTap: () async => await canLaunch(
                    "https://play.google.com/store/apps/developer?id=Peace+Time")
                ? await launch(
                    "https://play.google.com/store/apps/developer?id=Peace+Time")
                : throw 'Could not launch',
            child: Row(
              children: [
                Icon(
                  Icons.apps,
                  color: Theme.of(context).iconTheme.color,
                  size: 22.0,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                  ),
                  child: Text(
                    "More apps",
                    style: TextStyle(
                      // color: Colors.grey[400],
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget speedDialFloatingAction(BuildContext context) {
  return SpeedDial(
    // marginEnd: 18,
    // marginBottom: 20,
    icon: Icons.add,
    // icon: Icons.menu,
    activeIcon: Icons.close,
    // buttonSize: 56.0,
    visible: true,
    closeManually: false,
    renderOverlay: false,
    curve: Curves.bounceIn,
    overlayColor: Theme.of(context).primaryColor,
    overlayOpacity: 0.8,
    onOpen: () => {},
    onClose: () => {},
    tooltip: 'Speed Dial',
    heroTag: 'speed-dial-hero-tag',
    // backgroundColor: Colors.blue,
    foregroundColor: Colors.white,
    // elevation: 0.2,
    shape: CircleBorder(),
    gradientBoxShape: BoxShape.circle,
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Colors.blue[400], Colors.blue[700]],
    ),
    children: [
      SpeedDialChild(
        child: Icon(Icons.schedule),
        // backgroundColor: Colors.blue,
        // labelBackgroundColor: Colors.blue,
        // foregroundColor: Colors.white,
        label: 'Daily Schedule',
        // elevation: 0.3,
        labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => CreateScreen()),
        ).then((response) => null),
      ),
      SpeedDialChild(
        child: Icon(Icons.calendar_today_sharp),
        // backgroundColor: Colors.blue,
        // labelBackgroundColor: Colors.blue,
        // foregroundColor: Colors.white,
        label: 'Calender Schedule',
        // elevation: 0.3,
        labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => CreateDateScheduleScreen()),
        ).then((response) => null),
      ),
      SpeedDialChild(
        child: Icon(Icons.volume_off_sharp),
        // backgroundColor: Colors.blue,
        // labelBackgroundColor: Colors.blue,
        // foregroundColor: Colors.white,
        label: '30m Quick Silent',
        labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
        onTap: () =>
            Provider.of<ScheduleProvider>(context, listen: false).quick(30),
      ),
    ],
  );
}

Widget timeView(Schedule schedule, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.Hm().format(DateTime.parse(schedule.start)).toString(),
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
      Row(
        children: [
          Text(
            "~",
            style: TextStyle(fontSize: 32),
          ),
        ],
      ),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            DateFormat.Hm().format(DateTime.parse(schedule.end)).toString(),
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    ],
  );
}

Widget dayChipButton(String name, bool status, BuildContext context) {
  return Chip(
    label: Text(name.toUpperCase()),
    backgroundColor:
        status ? Colors.blue : Theme.of(context).chipTheme.selectedColor,
  );
}

Widget scheduleCardTimeText(Schedule schedule, BuildContext context) {
  bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;

  String startTime = '';
  String endTime = '';
  if (is24HoursFormat) {
    if (schedule.type == 'datetime') {
      startTime = DateFormat('KK:MM a, dd-MM-yyyy')
          .format(DateTime.parse(schedule.start));
      endTime = DateFormat('KK:MM a, dd-MM-yyyy')
          .format(DateTime.parse(schedule.end));
    } else {
      startTime = DateFormat.Hm().format(DateTime.parse(schedule.start));
      endTime = Helper.isNextDay(schedule.start, schedule.end)
          ? DateFormat.Hm().format(DateTime.parse(schedule.end)) + ', next day'
          : DateFormat.Hm().format(DateTime.parse(schedule.end));
    }
  } else {
    if (schedule.type == 'datetime') {
      startTime = DateFormat('KK:MM a, dd-MM-yyyy')
          .format(DateTime.parse(schedule.start));
      endTime = DateFormat('KK:MM a, dd-MM-yyyy')
          .format(DateTime.parse(schedule.end));
    } else {
      startTime = DateFormat.jm().format(DateTime.parse(schedule.start));
      endTime = Helper.isNextDay(schedule.start, schedule.end)
          ? DateFormat.jm().format(DateTime.parse(schedule.end)) + ', next day'
          : DateFormat.jm().format(DateTime.parse(schedule.end));
    }
  }

  if (schedule.type == 'datetime') {
    return Text(
      ("Start ~ " + startTime + "\nEnd ~ " + endTime).toLowerCase().toString(),
      style: TextStyle(color: Colors.blue),
    );
  } else {
    return Text(
      (startTime + " ~ " + endTime).toLowerCase().toString(),
      style: TextStyle(
          fontSize: 0.04 * MediaQuery.of(context).size.width,
          color: Colors.blue),
    );
  }
}

Widget timeText(String timeString, BuildContext context) {
  bool is24HoursFormat = MediaQuery.of(context).alwaysUse24HourFormat;
  String time = '';
  if (is24HoursFormat) {
    time = DateFormat.Hm().format(DateTime.parse(timeString));
  } else {
    time = DateFormat.jm().format(DateTime.parse(timeString));
  }
  return Text(time.toLowerCase().toString());
}
