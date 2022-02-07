import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/screen/AppInfoScreen.dart';
import 'package:peace_time/screen/HelpScreen.dart';
import 'package:peace_time/screen/SettingsScreen.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuItemBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          leading: const Icon(Icons.settings),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('Settings'),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => SettingsScreen()),
          ).then((response) => null),
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          leading: const Icon(Icons.share),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('Share'),
          onTap: () => Share.share(
              "Peace Time - A Silent Scheduler App. Please visit https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time and download this awesome app.",
              subject: 'Peace Time - A Silent Scheduler App.'),
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          leading: const Icon(Icons.star),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('Rate this app'),
          onTap: () async => await canLaunch(
                  "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
              ? await launch(
                  "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
              : throw 'Could not launch',
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          leading: const Icon(Icons.privacy_tip),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('Privacy policy'),
          onTap: () async => await canLaunch(
                  "https://fivepeacetime.blogspot.com/p/privacy-policy.html")
              ? await launch(
                  "https://fivepeacetime.blogspot.com/p/privacy-policy.html")
              : throw 'Could not launch',
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          leading: const Icon(Icons.help),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('Help'),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => HelpScreen()),
          ).then((response) => null),
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          leading: const Icon(Icons.info),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('App Info'),
          onTap: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => AppInfoScreen()),
          ).then((response) => null),
        ),
        ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          leading: const Icon(Icons.apps),
          trailing: const Icon(Icons.arrow_forward_ios),
          title: const Text('More apps'),
          onTap: () async => await canLaunch(
                  "https://play.google.com/store/apps/developer?id=Peace+Time")
              ? await launch(
                  "https://play.google.com/store/apps/developer?id=Peace+Time")
              : throw 'Could not launch',
        ),
      ],
    );
  }
}
