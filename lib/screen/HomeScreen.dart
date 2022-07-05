import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/widgets/HelperWidgets.dart';
import 'package:peace_time/screen/widgets/HomeBottomSheet.dart';
import 'package:peace_time/screen/widgets/MenuItemBottomSheet.dart';
import 'package:peace_time/screen/widgets/ScheduleCard.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
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
      backgroundColor: Theme.of(context).primaryColor,
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
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              snap: false,
              floating: true,
              expandedHeight: MediaQuery.of(context).size.height / 2.5,
              backgroundColor: Theme.of(context).primaryColor,
              centerTitle: false,
              // stretch: true,
              // title: Text("Auto Silent"),

              flexibleSpace: FlexibleSpaceBar(
                // titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 16.0),
                // centerTitle: false,
                // title: Text("Auto Silent", style: TextStyle(fontSize: 18),),
                background: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // SizedBox(height: 1,),
                      Column(
                        children: [
                          StreamBuilder(
                            stream: Stream.periodic(const Duration(seconds: 1)),
                            builder: (context, snapshot) {
                              return Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      MediaQuery.of(context)
                                              .alwaysUse24HourFormat
                                          ? DateFormat.Hm()
                                              .format(DateTime.now())
                                          : DateFormat.jm()
                                              .format(DateTime.now()),
                                      style: TextStyle(
                                          fontSize: 0.15 *
                                              MediaQuery.of(context).size.width,
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Text(
                            DateFormat('EEE, MMM d, ' 'yyyy')
                                .format(DateTime.now()),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              bottom: AppBar(
                elevation: 0,
                title: Text("Shedule"),
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
            ),
            SliverFillRemaining(
              // hasScrollBody: false,
              child: Container(
                margin: const EdgeInsets.only(top: 3.0),
                padding: const EdgeInsets.only(top: 10.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  // color: Colors.white,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      // spreadRadius: 2,
                      blurRadius: 2,
                      // offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Quick Silent:"),
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                    onTap: () => scheduleProvider.quick(30),
                                    child: Chip(
                                      label: Text('30m'),
                                      backgroundColor:
                                          Theme.of(context).backgroundColor,
                                    )),
                                GestureDetector(
                                    onTap: () => scheduleProvider.quick(60),
                                    child: Chip(
                                      label: Text('60m'),
                                      backgroundColor:
                                          Theme.of(context).backgroundColor,
                                    )),
                                GestureDetector(
                                    onTap: () => scheduleProvider.quick(120),
                                    child: Chip(
                                      label: Text('120m'),
                                      backgroundColor:
                                          Theme.of(context).backgroundColor,
                                    )),
                                GestureDetector(
                                    onTap: () => scheduleProvider.quick(180),
                                    child: Chip(
                                      label: Text('180m'),
                                      backgroundColor:
                                          Theme.of(context).backgroundColor,
                                    )),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: scheduleProvider.initialize,
                        child: (scheduleProvider.schedules.isEmpty)
                            ? emptyWidget(context)
                            : ListView.builder(
                                // padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                                physics: const BouncingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                // shrinkWrap: false,
                                itemCount: scheduleProvider.schedules.length,
                                itemBuilder: (context, index) {
                                  return ScheduleCard(
                                      scheduleProvider.schedules[index], index);
                                }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
