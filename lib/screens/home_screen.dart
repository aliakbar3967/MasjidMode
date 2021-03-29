
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/screens/create_schedule_screen.dart';
import 'package:peace_time/screens/edit_schedule_screen.dart';
import 'package:peace_time/screens/settings_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  // const HomeScreen({Key key}) : super(key: key);

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
        title: context.watch<ScheduleController>().selectedMode ? Text('Select All') : Text("Peace Time"),
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
      : SpeedDial(
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
        overlayColor: Colors.white,
        overlayOpacity: 0.8,
        onOpen: () => print('OPENING DIAL'),
        onClose: () => print('DIAL CLOSED'),
        tooltip: 'Speed Dial',
        heroTag: 'speed-dial-hero-tag',
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        // elevation: 8.0,
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
            backgroundColor: Colors.blue,
            label: 'New Schedule',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => CreateSchduleScreen()),).then((response)=>null),
            onLongPress: () => print('New Schedule LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.volume_off_sharp),
            backgroundColor: Colors.blue,
            label: '30m Quick Silent',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => context.read<ScheduleController>().quick(30),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
        ],
      ),
      // : FloatingActionButton(
      //   // elevation: 10.0,
      //   focusElevation: 0.0,
      //   child: Icon(Icons.add, size: 48.0,),
      //   backgroundColor: Colors.blue,
      //   // foregroundColor: Colors.black12,
      //   onPressed: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => CreateSchduleScreen()),).then((response)=>null),
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: context.watch<ScheduleController>().isLoading
      ? Center(child: CupertinoActivityIndicator(),)
      : context.watch<ScheduleController>().schedules == null
      ? Center(child: Text('No items'),)
      : context.watch<ScheduleController>().isDoNotDisturbPermissionStatus
      ? Column(
        children: [
          Expanded(
            child: ScheduleList(),
          ),
        ],
      )
      : Column(
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => SettingsController.openDoNotDisturbSettings(),
              child: Card(
                elevation: 0,
                color: Colors.red[200],
                child: ListTile(
                  minVerticalPadding: 12,
                  title: Text("Permission Required"),
                  subtitle: Text("App need \"Do Not Disturb\" Mode Permission. Otherwise your phone volume mode can't be changed. This permission is responsible for changing sound / volume mode."),
                  trailing: IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: () => context.read<ScheduleController>().doNotDisturbPermissionStatus(),
                  )
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ScheduleList(),
          ),
        ],
      ),
    );
  }
}


class ScheduleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleController>(
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
                        onChanged: (bool value) => context.read<ScheduleController>().toggleScheduleStatus(index),
                        activeColor: Colors.blue,
                      ),
                    ),
                  ),
                );
              },
            )
            : Center(child: Text('No items'),);
        }
      );
  }
}
