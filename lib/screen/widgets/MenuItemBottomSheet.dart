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
    // return Container(
    //   child: GridView.count(
    //     primary: false,
    //     padding: const EdgeInsets.all(20),
    //     crossAxisSpacing: 10,
    //     mainAxisSpacing: 10,
    //     crossAxisCount: 3,
    //     children: <Widget>[
    //       Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(5),
    //         ),
    //         child: ListTile(
    //           // leading: const Icon(Icons.share),
    //           title: Column(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Icon(Icons.settings_sharp, size: 60,),
    //               // SizedBox(height: 10),
    //               // Text("Settings")
    //             ],
    //           ),
    //           onTap: () => Navigator.push(
    //             context,
    //             CupertinoPageRoute(builder: (context) => SettingsScreen()),
    //           ).then((response) => null),
    //         ),
    //       ),
    //       Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(5),
    //         ),
    //         child: ListTile(
    //           // leading: const Icon(Icons.share),
    //           title: Column(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Icon(Icons.share_sharp, size: 60,),
    //               // SizedBox(height: 10),
    //               // Text("Settings")
    //             ],
    //           ),
    //           onTap: () => Share.share(
    //               "Peace Time - A Silent Scheduler App. Please visit https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time and download this awesome app.",
    //               subject: 'Peace Time - A Silent Scheduler App.'),
    //         ),
    //       ),
    //       Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(5),
    //         ),
    //         child: ListTile(
    //           // leading: const Icon(Icons.share),
    //           title: Column(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Icon(Icons.star, size: 60,),
    //               // SizedBox(height: 10),
    //               // Text("Settings")
    //             ],
    //           ),
    //           onTap: () async => await canLaunch(
    //               "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
    //               ? await launch(
    //               "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
    //               : throw 'Could not launch',
    //         ),
    //       ),
    //       Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(5),
    //         ),
    //         child: ListTile(
    //           // leading: const Icon(Icons.share),
    //           title: Column(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Icon(Icons.privacy_tip_sharp, size: 60,),
    //               // SizedBox(height: 10),
    //               // Text("Settings")
    //             ],
    //           ),
    //           onTap: () async => await canLaunch(
    //               "https://fivepeacetime.blogspot.com/p/privacy-policy.html")
    //               ? await launch(
    //               "https://fivepeacetime.blogspot.com/p/privacy-policy.html")
    //               : throw 'Could not launch',
    //         ),
    //       ),
    //       Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(5),
    //         ),
    //         child: ListTile(
    //           // leading: const Icon(Icons.share),
    //           title: Column(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Icon(Icons.help_sharp, size: 60,),
    //               // SizedBox(height: 10),
    //               // Text("Settings")
    //             ],
    //           ),
    //           onTap: () => Navigator.push(
    //             context,
    //             CupertinoPageRoute(builder: (context) => HelpScreen()),
    //           ).then((response) => null),
    //         ),
    //       ),
    //       Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(5),
    //         ),
    //         child: ListTile(
    //           // leading: const Icon(Icons.share),
    //           title: Column(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Icon(Icons.info_sharp, size: 60,),
    //               // SizedBox(height: 10),
    //               // Text("Settings")
    //             ],
    //           ),
    //           onTap: () => Navigator.push(
    //             context,
    //             CupertinoPageRoute(builder: (context) => AppInfoScreen()),
    //           ).then((response) => null),
    //         ),
    //       ),
    //       Card(
    //         shape: RoundedRectangleBorder(
    //           borderRadius: BorderRadius.circular(5),
    //         ),
    //         child: ListTile(
    //           // leading: const Icon(Icons.share),
    //           title: Column(
    //             mainAxisSize: MainAxisSize.max,
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               Icon(Icons.apps_sharp, size: 60,),
    //               // SizedBox(height: 10),
    //               // Text("Settings")
    //             ],
    //           ),
    //           onTap: () async => await canLaunch(
    //               "https://play.google.com/store/apps/developer?id=Peace+Time")
    //               ? await launch(
    //               "https://play.google.com/store/apps/developer?id=Peace+Time")
    //               : throw 'Could not launch',
    //         ),
    //       ),
    //     ],
    //   ),
    // );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Card(
            shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => SettingsScreen()),
              ).then((response) => null),
            ),
          ),
          SizedBox(height: 5,),
          Card(
            shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () => Share.share(
                  "Peace Time - A Silent Scheduler App. Please visit https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time and download this awesome app.",
                  subject: 'Peace Time - A Silent Scheduler App.'),
            ),
          ),
          SizedBox(height: 5,),
          Card(
            shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.star),
              title: const Text('Rate'),
              onTap: () async => await canLaunch(
                      "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
                  ? await launch(
                      "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
                  : throw 'Could not launch',
            ),
          ),
          SizedBox(height: 5,),
          Card(
            shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.privacy_tip),
              title: const Text('Privacy Policy'),
              onTap: () async => await canLaunch(
                      "https://fivepeacetime.blogspot.com/p/privacy-policy.html")
                  ? await launch(
                      "https://fivepeacetime.blogspot.com/p/privacy-policy.html")
                  : throw 'Could not launch',
            ),
          ),
          SizedBox(height: 5,),
          Card(
            shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => HelpScreen()),
              ).then((response) => null),
            ),
          ),
          SizedBox(height: 5,),
          Card(
            shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () => Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => AppInfoScreen()),
              ).then((response) => null),
            ),
          ),
          SizedBox(height: 5,),
          Card(
            shape: StadiumBorder(),
            child: ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              leading: const Icon(Icons.apps),
              title: const Text('More Apps'),
              onTap: () async => await canLaunch(
                      "https://play.google.com/store/apps/developer?id=Peace+Time")
                  ? await launch(
                      "https://play.google.com/store/apps/developer?id=Peace+Time")
                  : throw 'Could not launch',
            ),
          ),
        ],
      ),
    );
  }
}
