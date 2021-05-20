import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Help'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "How to use",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 24,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Create Quick Schedule",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text("Tap floating plus (+) button then tap \'30m Quick Silent'\. It will create current 30 minute quick schedule silent for you."),
            SizedBox(height: 10),
            Text(
              "Create Schedule",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text("Tap floating plus (+) button then tap \'New Schedule'\ and create new schedule by giving schedule name and select start and end time and select days and select silent and vibrate options."),
            SizedBox(height: 10),
            Text(
              "Update Schedule",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text("Tap any schedule from schedule list in home screen and update schedule by giving schedule name and select start and end time and select days and select silent and vibrate options."),
            SizedBox(height: 10),
            Text(
              "Remove Schedule One by One",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text("Hold and Swipe Right which schedule you want to remove and it will remove."),
            SizedBox(height: 10),
            Text(
              "Remove Multiple Schedule At A Time",
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 5),
            Text("Long press any of schedule from schedule list and select schedule and remove schedule by taping floating trash button."),

            // Text("It is easy to use this app. This app has only auto silent or vibrate feature. To use this features you have to allow permission of \'Do Not Distub'\. Then create new schedule and give this schedule start and end time and select days. By your selected time and days, auto silent or vibrate will work repeatedly. You can also create a quick schedule by clicking \'Quick 30m\'."),
          ],
        ),
      ),
    );
  }
}