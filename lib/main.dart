import 'package:flutter/material.dart';
import 'package:peace_time/controller/settings_controller.dart';
import 'package:peace_time/screens/home_screen.dart';


void main() {runApp(RootScreen());}
// void main() => runApp(MyApp());

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

