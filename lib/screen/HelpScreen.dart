import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      // backgroundColor: Colors.grey[900],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Navigator.of(context).pop(),
        ),
        // backgroundColor: Theme.of(context).cardColor,
        // elevation: 0,
        title: Text('Help'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.help_outline_rounded,
              // color: Colors.grey[700],
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(
                  "How to use?",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 24,
                    // color: Colors.grey[400],
                  ),
                ),
                SizedBox(height: 15),
                Text(
                  "Create Quick Schedule",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    // color: Colors.grey[400]
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Tap floating plus (+) button then tap \'30m Quick Silent'\. It will create current 30 minute quick schedule silent for you.",
                  // style: TextStyle(color: Colors.grey[700])
                ),
                SizedBox(height: 15),
                Text(
                  "Create Schedule",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    // color: Colors.grey[400]
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Tap floating plus (+) button then tap \'New Schedule'\ and create new schedule by giving schedule name and select start and end time and select days and select silent and vibrate options.",
                  // style: TextStyle(color: Colors.grey[700])
                ),
                SizedBox(height: 15),
                Text(
                  "Update Schedule",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    // color: Colors.grey[400]
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Tap any schedule from schedule list in home screen and update schedule by giving schedule name and select start and end time and select days and select silent and vibrate options.",
                  // style: TextStyle(color: Colors.grey[700])
                ),
                SizedBox(height: 15),
                Text(
                  "Remove Schedule One by One",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    // color: Colors.grey[400]
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Hold and Swipe Right which schedule you want to remove and it will remove.",
                  // style: TextStyle(color: Colors.grey[700])
                ),
                SizedBox(height: 15),
                Text(
                  "Remove Multiple Schedule At A Time",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    // color: Colors.grey[400]
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  "Long press any of schedule from schedule list and select schedule and remove schedule by taping floating trash button.",
                  // style: TextStyle(color: Colors.grey[700])
                ),
                SizedBox(height: 25),
                Text(
                  "Note:",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: Colors.red,
                  ),
                ),
                Text(
                  "Why app is not working?",
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: Colors.red,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                    "Realme, Oneplus, Samsung, Xiaomi, Huawei and a few other manufacturers have their own layer of 'Battery Saver' or 'Security' that kills or restricts background running apps. That's why app is not working properly. You have to enable battery uses restictions, or other security restrictions so that app can work properly.",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                    )),

                // Text("It is easy to use this app. This app has only auto silent or vibrate feature. To use this features you have to allow permission of \'Do Not Distub'\. Then create new schedule and give this schedule start and end time and select days. By your selected time and days, auto silent or vibrate will work repeatedly. You can also create a quick schedule by clicking \'Quick 30m\'."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
