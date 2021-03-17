
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/screens/create_schedule_screen.dart';
import 'package:peace_time/screens/edit_schedule_screen.dart';
import 'package:peace_time/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        leading: context.watch<ScheduleController>().selectedMode
        ? IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.read<ScheduleController>().toggleAllSelectedMode(),
        ) : null,
        title: context.watch<ScheduleController>().selectedMode ? Text('Select All') : Text("Peace Time - Auto Silent scheduler"),
        actions: [
          context.watch<ScheduleController>().selectedMode
          ? IconButton(
            icon: context.watch<ScheduleController>().isAllSelectedMode ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
            onPressed: () => context.read<ScheduleController>().toggleAllScheduleSelectedMode(),
          )
          : IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => SettingsScreen()),).then((response)=>null)
          ),
        ],
      ),
      floatingActionButton: context.watch<ScheduleController>().selectedMode
      ? FloatingActionButton(
        // elevation: 10.0,
        focusElevation: 0.0,
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
        // foregroundColor: Colors.black12,
        onPressed: () => context.read<ScheduleController>().removeSelectedSchedules(),
      )
      : FloatingActionButton(
        // elevation: 10.0,
        focusElevation: 0.0,
        child: Icon(Icons.add, size: 48.0,),
        backgroundColor: Colors.blue,
        // foregroundColor: Colors.black12,
        onPressed: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => CreateSchduleScreen()),).then((response)=>null),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: context.watch<ScheduleController>().isLoading
      ? Center(child: CircularProgressIndicator(),)
      : Consumer<ScheduleController>(
        builder: (context, schedulesController, child) {
          return schedulesController.schedules.isNotEmpty
            ? ListView.builder(
              itemCount: schedulesController.schedules.length,
              itemBuilder: (context, index) {
                return Card(
                  // color: Colors.white10,
                  elevation: 3,
                  child: Dismissible(
                      direction: DismissDirection.startToEnd,
                      background: Container(
                        padding: EdgeInsets.only(left: 12),
                        color: Colors.red,
                        child: Icon(Icons.delete, color: Colors.white,),
                        alignment: Alignment.centerLeft,
                      ),
                      key: UniqueKey(),
                      onDismissed: (direction) => context.read<ScheduleController>().removeSchedule(index),
                      child: ListTile(
                        minVerticalPadding: 12,
                        onLongPress: () {
                          context.read<ScheduleController>().toggleSelectedMode();
                        },
                        onTap: () {
                          if(schedulesController.selectedMode) {
                            context.read<ScheduleController>().toggleScheduleSelected(index);
                          } else {
                            Navigator.push(context,CupertinoPageRoute(builder: (context) => EditSchduleScreen(schedulesController.schedules,index)),).then((response)=>null);
                          }
                        },
                        selected: schedulesController.schedules[index].isselected,
                        title: Text(
                          schedulesController.schedules[index].name.toString().toUpperCase(),
                          style: TextStyle(
                            // fontFamily: 'avenir',
                            // fontWeight: FontWeight.w300,
                            // fontSize: 16,
                            color: Colors.black54
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${schedulesController.schedules[index].start} - ${schedulesController.schedules[index].end}",
                              style: TextStyle(
                                // fontFamily: 'avenir',
                                // fontWeight: FontWeight.w400,
                                fontSize: 24,
                                color: Colors.black54
                              ),
                            ),
                            SizedBox(height: 2.0,),
                            Text(
                              "${ScheduleController.getDaysNames(schedulesController.schedules[index]).toString().toUpperCase()}",
                              style: TextStyle(
                                // fontFamily: 'avenir',
                                // fontWeight: FontWeight.w300,
                                fontSize: 12,
                                color: Colors.blue
                              ),
                            ),
                          ],
                        ),
                        trailing: (schedulesController.selectedMode)
                        ? ((schedulesController.schedules[index].isselected)
                        ? Icon(Icons.check_box)
                        : Icon(Icons.check_box_outline_blank))
                        : CupertinoSwitch(
                          value: schedulesController.schedules[index].status, 
                          onChanged: (bool value) => context.read<ScheduleController>().updateScheduleSelected(index),
                          activeColor: Colors.blue,
                        ),
                      ),
                    ),
                  );
                },
              )
              : Center(child: Text('No items'),);
        }
      ),
    );
  }
}
