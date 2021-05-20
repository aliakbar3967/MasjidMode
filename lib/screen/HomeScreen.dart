import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/HelpScreen.dart';
import 'package:peace_time/screen/widgets/HelperWidgets.dart';
import 'package:peace_time/screen/widgets/ScheduleCard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("run=====");
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
      ),
      child: Scaffold(
        // backgroundColor: Theme.of(context).primaryColor,
        // backgroundColor: Colors.black,
        // backgroundColor: Colors.grey[200],
        // appBar: AppBar(
        //   backgroundColor: Colors.blue,
        //   title: Text("Auto Silent"),
        //   actions: [
        //     dropDownMenus(),
        //   ],
        // ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: speedDialFloatingAction(context),
        body: SafeArea(
          // child: ScheduleList(),
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 350.0,
                // backgroundColor: Theme.of(context).cardColor,
                // backgroundColor: Colors.grey[900],
                // leading: Text("lead"),
                title: Text(
                  "Auto Silent",
                  style: TextStyle(
                      // color: Colors.grey[400]
                      ),
                ),
                actions: [
                  IconButton(
                      icon: Icon(Icons.help_outline_rounded),
                      onPressed: () => Navigator.push(
                            context,
                            CupertinoPageRoute(
                                builder: (context) => HelpScreen()),
                          ).then((response) => null)),
                  dropDownMenus(),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  // centerTitle: true,
                  // title: Text(''),
                  background: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // SizedBox(height: 1,),
                        Column(
                          children: [
                            StreamBuilder(
                              stream:
                                  Stream.periodic(const Duration(seconds: 1)),
                              builder: (context, snapshot) {
                                return Center(
                                  child: Text(
                                    DateFormat('hh:mm a')
                                        .format(DateTime.now()),
                                    style: TextStyle(fontSize: 48),
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
                        // OutlineButton.icon(
                        //     onPressed: (){},
                        //     icon: Icon(Icons.add),
                        //     label: Text("Create 30m quick silent")
                        // )
                      ],
                    ),
                  ),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Auto Silent'),
              //         dropDownMenus(),
              //       ],
              //     ),
              //   ),
              // ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: ScheduleCard(
                          Provider.of<ScheduleProvider>(context)
                              .schedules[index],
                          index),
                    );
                  },
                  childCount:
                      Provider.of<ScheduleProvider>(context).schedules.length,
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (Provider.of<ScheduleProvider>(context, listen: false)
                            .schedules
                            .length >
                        0) {
                      return SizedBox(
                        height: 100,
                      );
                    } else {
                      return Container(
                        // color: Colors.red,
                        height: MediaQuery.of(context).size.height / 2,
                        child: Center(
                          child: Text(
                            "No Schedules",
                            style: TextStyle(
                              fontSize: 20,
                              // color: Colors.grey[400]
                            ),
                          ),
                        ),
                      );
                    }
                  },
                  childCount: 1,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class ScheduleList extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<ScheduleProvider>(
//       builder: (context, scheduleProvider, child) {
//         return scheduleProvider.schedules.isNotEmpty
//             ? ListView.builder(
//                 itemCount: scheduleProvider.schedules.length * 1,
//                 itemBuilder: (context, index) {
//                   return ScheduleCard(scheduleProvider.schedules[index], index);
//                 },
//               )
//             : Center(
//                 child: Text('No items'),
//               );
//       },
//     );
//   }
// }
