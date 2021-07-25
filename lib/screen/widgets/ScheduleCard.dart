import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/RemoveScheduleScreen.dart';
import 'package:peace_time/screen/schedule/EditDateScheduleScreen.dart';
import 'package:peace_time/screen/schedule/EditScreen.dart';
import 'package:peace_time/screen/widgets/HelperWidgets.dart';
import 'package:provider/provider.dart';

class ScheduleCard extends StatelessWidget {
  ScheduleCard(this.schedule, this.index);

  final Schedule schedule;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(top: 12),
      elevation: 3,
      // color: Colors.grey[900],
      child: Dismissible(
        direction: DismissDirection.startToEnd,
        background: Container(
          padding: EdgeInsets.only(left: 12),
          color: Colors.red,
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
          alignment: Alignment.centerLeft,
        ),
        key: UniqueKey(),
        onDismissed: (direction) =>
            context.read<ScheduleProvider>().remove(index),
        child: ListTile(
          // focusColor: Colors.grey[850],
          onTap: () {
            if (schedule.type == 'datetime') {
              Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (context) => EditDateScheduleScreen(index)),
              ).then((response) => null);
            } else {
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => EditScreen(index)),
              ).then((response) => null);
            }
          },
          onLongPress: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => RemoveScheduleScreen()),
          ).then((response) =>
              Provider.of<ScheduleProvider>(context, listen: false)
                  .setIsAllSelectedMode(false)),
          contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 8),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        schedule.type == 'datetime'
                            ? Icons.calendar_today
                            : Icons.schedule,
                        size: 18,
                        // color: Theme.of(context).primaryColor,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(schedule.name),
                    ],
                  ),
                  Row(
                    children: [
                      dayChip("S", schedule.saturday, context),
                      dayChip("S", schedule.sunday, context),
                      dayChip("M", schedule.monday, context),
                      dayChip("T", schedule.tuesday, context),
                      dayChip("W", schedule.wednesday, context),
                      dayChip("T", schedule.thursday, context),
                      dayChip("F", schedule.friday, context),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: 4,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 8,
                    child: scheduleCardTimeText(schedule, context),
                  ),
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Transform.scale(
                        alignment: Alignment.centerRight,
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: schedule.status,
                          onChanged: (bool value) =>
                              Provider.of<ScheduleProvider>(context,
                                      listen: false)
                                  .toggleScheduleStatus(index),
                          activeColor: Colors.blue,
                          // trackColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // trailing: CupertinoSwitch(
          //   value: true,
          //   onChanged: (bool value) {},
          //   activeColor: Colors.grey[700],
          // ),
        ),
      ),
    );
  }
}
