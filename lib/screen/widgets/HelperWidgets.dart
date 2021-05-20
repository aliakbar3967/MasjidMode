import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/AppInfoScreen.dart';
import 'package:peace_time/screen/schedule/CreateScreen.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../HelpScreen.dart';
import '../SettingsScreen.dart';

Widget dayChip(name, isActive, BuildContext context) {
  return Text(
    name,
    style: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      color: isActive ? Colors.blue : Theme.of(context).disabledColor,
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
                    "http://play.google.com/store/apps/dev?id=6422209637535930890")
                ? await launch(
                    "http://play.google.com/store/apps/dev?id=6422209637535930890")
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
    // overlayColor: Colors.black,
    overlayOpacity: 0.8,
    onOpen: () => print('OPENING DIAL'),
    onClose: () => print('DIAL CLOSED'),
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
        // foregroundColor: Colors.white,
        // labelBackgroundColor: Colors.white,
        label: 'New Schedule',
        // elevation: 0.3,
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () => Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => CreateScreen()),
        ).then((response) => null),
        onLongPress: () => print('New Schedule LONG PRESS'),
      ),
      SpeedDialChild(
        child: Icon(Icons.volume_off_sharp),
        // backgroundColor: Colors.blue,
        // labelBackgroundColor: Colors.white,
        // foregroundColor: Colors.white,
        label: '30m Quick Silent',
        labelStyle: TextStyle(fontSize: 18.0),
        onTap: () =>
            Provider.of<ScheduleProvider>(context, listen: false).quick(30),
        onLongPress: () => print('SECOND CHILD LONG PRESS'),
      ),
    ],
  );
}
