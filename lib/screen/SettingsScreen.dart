import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/DBController.dart';
import 'package:peace_time/controller/SettingsController.dart';
import 'package:peace_time/provider/ScheduleProvider.dart';
import 'package:peace_time/provider/SettingsProvider.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  showAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Restore Confirmation'),
          content: Text(
              "Are you sure want to restore your all data? All data of your app will be removed permanently."),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "NO",
                style: TextStyle(color: Colors.red),
              ),
              onPressed: () {
                //Put your code here which you want to execute on No button click.
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text(
                "YES",
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () async {
                Provider.of<ScheduleProvider>(context, listen: false)
                    .restoreDB();
                Provider.of<SettingsProvider>(context, listen: false).refresh();
                final snackBar = SnackBar(
                  content: Text('App restored successfylly'),
                  action: SnackBarAction(
                    label: 'Done',
                    onPressed: () {
                      // Some code to undo the change.
                    },
                  ),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                //Put your code here which you want to execute on Yes button click.
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 1), () async {
      Provider.of<SettingsProvider>(context, listen: false).refresh();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _settingsProvider =
        Provider.of<SettingsProvider>(context, listen: false);
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('Settings'),
      ),
      body: _settingsProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: () async =>
                  await Provider.of<SettingsProvider>(context, listen: false)
                      .refresh(),
              child: ListView(
                physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics()),
                children: [
                  Card(
                    child: ListTile(
                      title: Text(
                        "Application",
                        // style: TextStyle(color: Colors.grey[400]),
                      ),
                      subtitle: Text(
                        "Running your app on background",
                        // style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing:
                          // Provider.of<SettingsProvider>(context,
                          // listen: false)
                          // .isPending
                          // ? CupertinoActivityIndicator()
                          // :
                          Transform.scale(
                        scale: 0.8,
                        alignment: Alignment.centerRight,
                        child: CupertinoSwitch(
                          value:
                              _settingsProvider.settings.forgroundServiceStatus,
                          activeColor: Theme.of(context).primaryColor,
                          // trackColor: Colors.black,
                          onChanged: (bool value) async {
                            // await Provider.of<SettingsProvider>(context,
                            //         listen: false)
                            //     .isPendingValue(true);
                            await _settingsProvider
                                .toggleForgroundServiceStatus();
                          },
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: GestureDetector(
                      onTap: () =>
                          SettingsController.openDoNotDisturbSettings(),
                      child: ListTile(
                        title: Text(
                          "Do Not Disturb Mode",
                          // style: TextStyle(color: Colors.grey[400]),
                        ),
                        subtitle: Text(
                          "Responsible for switch your phone silent or vibrate mode",
                          // style: TextStyle(color: Colors.grey[700]),
                        ),
                        trailing: Transform.scale(
                          scale: 0.8,
                          alignment: Alignment.centerRight,
                          child: CupertinoSwitch(
                            value: _settingsProvider
                                .settings.isDoNotDisturbPermissionStatus,
                            activeColor: Theme.of(context).primaryColor,
                            // trackColor: Colors.black,
                            onChanged: (bool value) {},
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        "App Introduction Screen",
                        // style: TextStyle(color: Colors.grey[400]),
                      ),
                      subtitle: Text(
                        "Get tips & guidelines on startup",
                        // style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        alignment: Alignment.centerRight,
                        child: CupertinoSwitch(
                          value: _settingsProvider
                              .settings.introductionScreenStatus,
                          activeColor: Theme.of(context).primaryColor,
                          // trackColor: Colors.black,
                          onChanged: (bool value) =>
                              Provider.of<SettingsProvider>(context,
                                      listen: false)
                                  .toggleIntroductionScreenStatus(),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        "Dark Mode",
                        // style: TextStyle(color: Colors.grey[400]),
                      ),
                      subtitle: Text(
                        "On / Off your app dark mode",
                        // style: TextStyle(color: Colors.grey[700]),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        alignment: Alignment.centerRight,
                        child: CupertinoSwitch(
                          value: _settingsProvider.settings.darkMode,
                          activeColor: Theme.of(context).primaryColor,
                          // trackColor: Colors.black,
                          onChanged: (bool value) =>
                              Provider.of<SettingsProvider>(context,
                                      listen: false)
                                  .toggleDarkMode(),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        "Reset",
                        style: TextStyle(color: Colors.red),
                      ),
                      subtitle: Text(
                        "Reset your app schedules and settings.",
                        // style: TextStyle(color: Colors.grey[700]),
                      ),
                      onTap: () => showAlert(context),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
