import 'package:flutter/material.dart';
import 'package:peace_time/screen/components/ScheduleList.dart';
import 'package:peace_time/screen/widgets/HelperWidgets.dart';
import 'package:peace_time/screen/widgets/FloatingActionBottomSheet.dart';
import 'package:peace_time/screen/widgets/MenuItemBottomSheet.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async => showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return FloatingActionBottomSheet();
          },
        ),
      ),
      bottomNavigationBar: bottomNavigationBar(context),
      appBar: AppBar(
        title: Text("Schedule".toUpperCase()),
        actions: [
          IconButton(
              icon: Icon(Icons.share),
              onPressed: () => Share.share(
                  "Peace Time - A Silent Scheduler App. Please visit https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time and download this awesome app.",
                  subject: 'Peace Time - A Silent Scheduler App.')),
          IconButton(
              onPressed: () async => await canLaunch(
                      "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
                  ? await launch(
                      "https://play.google.com/store/apps/details?id=com.fivepeacetime.peace_time")
                  : throw 'Could not launch',
              icon: Icon(Icons.star)),
          IconButton(
              onPressed: () async => showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return MenuItemBottomSheet();
                    },
                  ),
              icon: Icon(Icons.more_vert)),
        ],
      ),
      body: SafeArea(
        child: ScheduleList(),
      ),
    );
  }
}
