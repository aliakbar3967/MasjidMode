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
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Settings',
          // style: TextStyle(color: Colors.grey[400]),
        ),
        // backgroundColor: Theme.of(context).cardColor,
        // elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  Provider.of<SettingsProvider>(context, listen: false)
                      .refresh(),
              icon: Icon(Icons.refresh))
        ],
      ),
      body: Provider.of<SettingsProvider>(context).isLoading
          ? Center(
              child: CupertinoActivityIndicator(),
            )
          : SafeArea(
              child: Padding(
                padding: EdgeInsets.all(4.0),
                child: Column(
                  children: [
                    Card(
                      // color: Colors.grey[900],
                      borderOnForeground: false,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 8),
                        child: ListTile(
                          title: Text(
                            "Application",
                            // style: TextStyle(color: Colors.grey[400]),
                          ),
                          subtitle: Text(
                            "Auto silent will not work, if it is off.",
                            // style: TextStyle(color: Colors.grey[700]),
                          ),
                          trailing:
                              // Provider.of<SettingsProvider>(context,
                              // listen: false)
                              // .isPending
                              // ? CupertinoActivityIndicator()
                              // :
                              CupertinoSwitch(
                            value: Provider.of<SettingsProvider>(context,
                                    listen: false)
                                .settings
                                .forgroundServiceStatus,
                            activeColor: Colors.blue,
                            // trackColor: Colors.black,
                            onChanged: (bool value) async {
                              // await Provider.of<SettingsProvider>(context,
                              //         listen: false)
                              //     .isPendingValue(true);
                              await Provider.of<SettingsProvider>(context,
                                      listen: false)
                                  .toggleForgroundServiceStatus();
                            },
                          ),
                        ),
                      ),
                    ),
                    Card(
                      // color: Colors.grey[900],
                      borderOnForeground: false,
                      elevation: 3,
                      child: GestureDetector(
                        onTap: () =>
                            SettingsController.openDoNotDisturbSettings(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 2, vertical: 8),
                          child: ListTile(
                            title: Text(
                              "Do Not Disturb",
                              // style: TextStyle(color: Colors.grey[400]),
                            ),
                            subtitle: Text(
                              "Auto silent will not work, if it is off.",
                              // style: TextStyle(color: Colors.grey[700]),
                            ),
                            trailing: CupertinoSwitch(
                              value: Provider.of<SettingsProvider>(context)
                                  .settings
                                  .isDoNotDisturbPermissionStatus,
                              activeColor: Colors.blue,
                              // trackColor: Colors.black,
                              onChanged: (bool value) {},
                            ),
                          ),
                        ),
                      ),
                    ),
                    Card(
                      // color: Colors.grey[900],
                      borderOnForeground: false,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 8),
                        child: ListTile(
                          title: Text(
                            "Show Introduction Screen",
                            // style: TextStyle(color: Colors.grey[400]),
                          ),
                          subtitle: Text(
                            "Get back app introduction screen.",
                            // style: TextStyle(color: Colors.grey[700]),
                          ),
                          trailing: CupertinoSwitch(
                            value: Provider.of<SettingsProvider>(context,
                                    listen: false)
                                .settings
                                .introductionScreenStatus,
                            activeColor: Colors.blue,
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
                      // color: Colors.grey[900],
                      borderOnForeground: false,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 8),
                        child: ListTile(
                          title: Text(
                            "Dark Mode",
                            // style: TextStyle(color: Colors.grey[400]),
                          ),
                          trailing: CupertinoSwitch(
                            value: Provider.of<SettingsProvider>(context)
                                .settings
                                .darkMode,
                            activeColor: Colors.blue,
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
                      // color: Colors.redAccent,
                      borderOnForeground: false,
                      elevation: 3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 2, vertical: 8),
                        child: ListTile(
                          title: Center(
                            child: Text(
                              "Restore App",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                          onTap: () => showAlert(context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
