import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/screen/widgets/HelperWidgets.dart';
import 'package:provider/provider.dart';

class RemoveScheduleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // backgroundColor: Colors.grey[900],
        title: Text(
            "${Provider.of<ScheduleProvider>(context, listen: false).count} items selected"),
        actions: [
          IconButton(
            onPressed: () =>
                Provider.of<ScheduleProvider>(context, listen: false)
                    .toggleAllScheduleSelection(),
            padding: EdgeInsets.only(right: 24.0),
            icon: Provider.of<ScheduleProvider>(context).isAllSelectedMode
                ? Icon(
                    Icons.check_circle,
                    color: Theme.of(context).iconTheme.color,
                  )
                : Icon(Icons.radio_button_off_rounded,
                    color: Theme.of(context).iconTheme.color),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        backgroundColor: Colors.red,
        onPressed: () => Provider.of<ScheduleProvider>(context, listen: false)
            .removeMultiple(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ScheduleList(),
        ),
      ),
    );
  }
}

class ScheduleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ScheduleProvider>(
      builder: (context, scheduleProvider, child) {
        return scheduleProvider.schedules.isNotEmpty
            ? ListView.builder(
                itemCount: scheduleProvider.schedules.length * 1,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.only(top: 12),
                    elevation: 3,
                    // color: Colors.grey[900],
                    child: ListTile(
                      // focusColor: Colors.grey[850],
                      onTap: () => context
                          .read<ScheduleProvider>()
                          .toggleScheduleSelection(index),
                      contentPadding: EdgeInsets.fromLTRB(16, 12, 16, 8),
                      title: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(scheduleProvider.schedules[index].name),
                              Row(
                                children: [
                                  dayChip(
                                      "S",
                                      scheduleProvider
                                          .schedules[index].saturday,
                                      context),
                                  dayChip(
                                      "S",
                                      scheduleProvider.schedules[index].sunday,
                                      context),
                                  dayChip(
                                      "M",
                                      scheduleProvider.schedules[index].monday,
                                      context),
                                  dayChip(
                                      "T",
                                      scheduleProvider.schedules[index].tuesday,
                                      context),
                                  dayChip(
                                      "W",
                                      scheduleProvider
                                          .schedules[index].wednesday,
                                      context),
                                  dayChip(
                                      "T",
                                      scheduleProvider
                                          .schedules[index].thursday,
                                      context),
                                  dayChip(
                                      "F",
                                      scheduleProvider.schedules[index].friday,
                                      context),
                                ],
                              )
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                flex: 7,
                                child: scheduleCardTimeText(
                                    scheduleProvider.schedules[index], context),
                              ),
                              Expanded(
                                flex: 3,
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: scheduleProvider
                                          .schedules[index].isSelected
                                      ? Icon(Icons.check_circle)
                                      : Icon(
                                          Icons.radio_button_off,
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
                  );
                },
              )
            : Center(
                child: Text('No items'),
              );
      },
    );
  }
}
