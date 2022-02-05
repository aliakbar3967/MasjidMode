import 'package:flutter/material.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/widgets/HelperWidgets.dart';
import 'package:peace_time/screen/widgets/HomeBottomSheet.dart';
import 'package:peace_time/screen/widgets/MenuItemBottomSheet.dart';
import 'package:peace_time/screen/widgets/ScheduleCard.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var scheduleProvider = Provider.of<ScheduleProvider>(context);
    return Scaffold(
      // backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: const Text("Auto Silent"),
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
      body: RefreshIndicator(
        onRefresh: scheduleProvider.initialize,
        child: (scheduleProvider.schedules == null ||
                scheduleProvider.schedules.isEmpty)
            ? emptyWidget(context)
            : ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                // shrinkWrap: false,
                itemCount: scheduleProvider.schedules.length,
                itemBuilder: (context, index) {
                  return ScheduleCard(scheduleProvider.schedules[index], index);
                }),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () async => showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return HomeBottomSheet();
          },
        ),
      ),
    );
  }
}
