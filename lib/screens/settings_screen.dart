import 'package:flutter/material.dart';
import 'package:flutter_foreground_service_plugin/flutter_foreground_service_plugin.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:flutter/cupertino.dart';
import 'package:peace_time/model/settings.dart';


class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  Settings settings = Settings(isForgroundServiceRunning:false, isDoNotDisturbPermissionStatus: false);
  bool isLoading = true;

  Future<void> getSettingsData() async {
    // bool isForgroundServiceOn = await SettingsController.isRunningForgroundService();
    // print(await SettingsController.isRunningForgroundService());
    // bool isForgroundServiceRunning = await FlutterForegroundServicePlugin.isForegroundServiceRunning();
    bool isForgroundServiceRunning = await SettingsController.isRunningForgroundService();
    bool isDoNotDisturbPermissionStatus = await SettingsController.getPermissionStatus();
    setState(() {
      settings = Settings(isForgroundServiceRunning:isForgroundServiceRunning,isDoNotDisturbPermissionStatus:isDoNotDisturbPermissionStatus);
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getSettingsData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Settings'),
        elevation: 0,
        actions: [
          IconButton(onPressed: getSettingsData, icon: Icon(Icons.refresh))
        ],
      ),
      body: isLoading 
    ? Center(child: CircularProgressIndicator(),) 
    : SafeArea(
    child: Column(
      children: [
        Card(
          borderOnForeground: false,
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2,vertical:8),
            child: ListTile(
              title: Text("Application"),
              subtitle: Text("Auto silent will not working if it is off."),
              trailing: CupertinoSwitch(
                value: settings.isForgroundServiceRunning,
                activeColor: Colors.blue,
                onChanged: (bool value) async {
                    settings.isForgroundServiceRunning
                    ? await SettingsController.stopForgroundService()
                    : await SettingsController.startForgroundServiceAndTask();
                    setState(() {
                      settings.isForgroundServiceRunning = !settings.isForgroundServiceRunning;
                    });
                },
              ),
            ),
          ),
        ),
        Card(
          borderOnForeground: false,
          elevation: 3,
          child: GestureDetector(
            onTap: () => SettingsController.openDoNotDisturbSettings(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2,vertical:8),
              child: ListTile(
                title: Text("Do Not Disturb"),
                subtitle: Text("Auto silent will not working if it is off."),
                trailing: CupertinoSwitch(
                  value: settings.isDoNotDisturbPermissionStatus,
                  activeColor: Colors.blue,
                  onChanged: (bool value) {},
                ),
              ),
            ),
          ),
        ),
      ],
    ),
        ),
    );
  }
}