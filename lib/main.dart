import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:peace_time/controller/schedule_controller.dart';
import 'package:peace_time/screens/home_screen.dart';

// ignore_for_file: public_member_api_docs, lines_longer_than_80_chars
import 'package:flutter/foundation.dart';
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
      child: RootScreen(),
    ),
  );
}

class RootScreen extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
