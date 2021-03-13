import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/model/schedule.dart';
import 'package:peace_time/screens/create_schedule_screen.dart';
import 'package:peace_time/screens/edit_schedule_screen.dart';
import 'package:peace_time/screens/home_screen.dart';

// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
import 'package:peace_time/screens/settings_screen.dart';
import 'package:provider/provider.dart';


// void main() {runApp(RootScreen());}
// void main() => runApp(MyApp());

/// This is a reimplementation of the default Flutter application using provider + [ChangeNotifier].

void main() {
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ScheduleController()),
        // Provider<ScheduleController>(create: (context) => ScheduleController())
      ],
      child: Root(),
      // child: RootScreen(),
    ),
  );
}

class Root extends StatelessWidget {
  // const Root({Key key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    if(context.watch<ScheduleController>().schedules == null || context.watch<ScheduleController>().schedules.isEmpty) {
      context.read<ScheduleController>().getScheduesData();
      // print('${context.watch<ScheduleController>().schedules}');
    }
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

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
        title: Text("Peace Time - Auto silent scheduler"),
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
      floatingActionButton: FloatingActionButton(
        // elevation: 0.0,
        child: new Icon(Icons.add, size: 48.0,),
        backgroundColor: Colors.blue,
        onPressed: () => Navigator.push(context,CupertinoPageRoute(builder: (context) => CreateSchduleScreen()),).then((response)=>null)
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
                    child: Dismissible(
                        direction: DismissDirection.startToEnd,
                        background: Container(
                          padding: EdgeInsets.only(left: 12),
                          color: Colors.red,
                          child: Icon(Icons.delete, color: Colors.white,),
                          alignment: Alignment.centerLeft,
                        ),
                        key: Key(index.toString()),
                        onDismissed: (direction) => context.read<ScheduleController>().removeSchedule(index),
                        child: ListTile(
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
                        selected: schedulesController.schedules[index].selected,
                        title: Text(
                          "${schedulesController.schedules[index].start} - ${schedulesController.schedules[index].end}",
                          style: TextStyle(
                            // fontFamily: 'avenir',
                            fontWeight: FontWeight.w300,
                            fontSize: 16,
                            color: Colors.black54
                          ),
                        ),
                        subtitle: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              schedulesController.schedules[index].name.toString().toUpperCase(),
                              style: TextStyle(
                                // fontFamily: 'avenir',
                                // fontWeight: FontWeight.w100,
                                fontSize: 24,
                                color: Colors.black87
                              ),
                            ),
                            Text(
                              "${schedulesController.schedules[index].dayNames.toString().toUpperCase()}",
                              style: TextStyle(
                                // fontFamily: 'avenir',
                                fontWeight: FontWeight.w300,
                                fontSize: 14,
                                color: Colors.blue
                              ),
                            ),
                          ],
                        ),
                        trailing: (schedulesController.selectedMode)
                        ? ((schedulesController.schedules[index].selected)
                        ? Icon(Icons.check_box)
                        : Icon(Icons.check_box_outline_blank))
                        : Switch(
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


class RootScreen extends StatefulWidget {
  @override
  _RootScreenState createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SettingsController.startForgroundServiceAndTask();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Peace Time',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}



class MyApp extends StatefulWidget {
  @override

  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool selectingmode = false;
  List<Paint> paints = <Paint>[
    Paint(1, 'Red', Colors.red),
    Paint(2, 'Blue', Colors.blue),
    Paint(3, 'Green', Colors.green),
    Paint(4, 'Lime', Colors.lime),
    Paint(5, 'Indigo', Colors.indigo),
    Paint(6, 'Yellow', Colors.yellow)
  ];
  @override

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          leading: selectingmode
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      selectingmode = false;
                      paints.forEach((p) => p.selected = false);
                    });
                  },
                )
              : null,
          title: Text("Selectable ListView Example"),
        ),
        body: ListView(
          children: List.generate(paints.length, (index) {
            return Card(
              child: ListTile(
                onLongPress: () {
                  setState(() {
                    selectingmode = true;
                  });
                },
                onTap: () {
                  setState(() {
                    if (selectingmode) {
                      paints[index].selected = !paints[index].selected;
                      print(paints[index].selected.toString());
                    }
                  });
                },
                selected: paints[index].selected,
                leading: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {},
                  child: Container(
                    width: 48,
                    height: 48,
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: paints[index].colorpicture,
                    ),
                  ),
                ),
                title: Text('ID: ' + paints[index].id.toString()),
                subtitle: Text(paints[index].title),
                trailing: (selectingmode)
                    ? ((paints[index].selected)
                        ? Icon(Icons.check_box)
                        : Icon(Icons.check_box_outline_blank))
                    : Icon(Icons.keyboard_arrow_right),
              ),
            );
          }),
        ),
      ),
    );
  }
}

class Paint {
  final int id;
  final String title;
  final Color colorpicture;
  bool selected = false;
  Paint(this.id, this.title, this.colorpicture);
}

