import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppInfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: Theme.of(context).primaryColor,
      ),
      child: Scaffold(
        // backgroundColor: Colors.black,
        // backgroundColor: Colors.grey[900],
        // appBar: AppBar(
        //   backgroundColor: Colors.grey[900],
        //   elevation: 0,
        //   title: Text('Help', style: TextStyle(color: Colors.grey[400])),
        //   actions: [
        //     Padding(
        //       padding: const EdgeInsets.all(8.0),
        //       child: Icon(
        //         Icons.help_outline_rounded,
        //         color: Colors.grey[700],
        //       ),
        //     ),
        //   ],
        // ),
        body: SafeArea(
          child: CustomScrollView(
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 350.0,
                // backgroundColor: Colors.black,
                // backgroundColor: Theme.of(context).cardColor,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_outlined),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                title: Text(
                  "Info",
                  // style: TextStyle(color: Colors.grey[400]),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.info_outline_rounded,
                      // color: Colors.grey[700],
                    ),
                  ),
                ],
                flexibleSpace: FlexibleSpaceBar(
                  // centerTitle: true,
                  // title: Text(
                  //   'How to use?',
                  //   style: TextStyle(color: Colors.white),
                  // ),
                  background: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/circle.png',
                          width: MediaQuery.of(context).size.width / 4,
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Peace Time",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 24,
                            // color: Colors.grey[400]
                          ),
                        ),
                        Text(
                          "Version: 7.0.0",
                          style: TextStyle(
                              // fontWeight: FontWeight.w700,
                              color: Theme.of(context).disabledColor),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              // SliverToBoxAdapter(
              //   child: Padding(
              //     padding: const EdgeInsets.all(8.0),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Text('Auto Silent'),
              //         dropDownMenus(),
              //       ],
              //     ),
              //   ),
              // ),
              // SliverFixedExtentList(
              //   itemExtent: 760,
              //   delegate: SliverChildListDelegate([
              //   ]),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
