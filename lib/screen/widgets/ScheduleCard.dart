import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/model/ScheduleModel.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/RemoveScheduleScreen.dart';
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
            Navigator.push(
              context,
              CupertinoPageRoute(builder: (context) => EditScreen(index)),
            ).then((response) => null);
          },
          onLongPress: () => Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => RemoveScheduleScreen()),
          ).then((response) =>
              Provider.of<ScheduleProvider>(context, listen: false)
                  .setIsAllSelectedMode(false)),
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          // horizontalTitleGap: 16,
          subtitle: Container(
            // color: Colors.grey[850],
            padding: EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                dayChip("SAT", schedule.saturday, context),
                dayChip("SUN", schedule.sunday, context),
                dayChip("SUN", schedule.monday, context),
                dayChip("TUE", schedule.tuesday, context),
                dayChip("WED", schedule.wednesday, context),
                dayChip("THU", schedule.thursday, context),
                dayChip("FRI", schedule.friday, context),
              ],
            ),
          ),
          // leading: Text("Name Of"),
          title: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    schedule.name.toUpperCase(),
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).textTheme.headline1.color,
                    ),
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
                    flex: 7,
                    child: timeView(schedule, context),
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
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
