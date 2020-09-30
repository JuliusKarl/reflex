import 'package:flutter/material.dart';
import 'random.dart';
import 'lap.dart';
import 'round.dart';

import 'info/lapInfo.dart';
import 'info/randomInfo.dart';
import 'info/roundInfo.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  List<Tab> myTabs = <Tab>[
    Tab(text: "Fixed"),
    Tab(text: "Random"),
    Tab(text: "Interval"),
  ];

  TabController _tabController;
  int index;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Builder(builder: (BuildContext context) {
          return Scaffold(
              appBar: AppBar(
                actions: <Widget>[
                  IconButton(
                    iconSize: 20,
                    icon: Icon(
                      Icons.info_outline,
                      color: Color(0xFF555555),
                    ),
                    onPressed: () {
                      switch (DefaultTabController.of(context).index) {
                        case 0:
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LapInfo()));
                          }
                          break;

                        case 1:
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RandomInfo()));
                          }
                          break;

                        case 2:
                          {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RoundInfo()));
                          }
                          break;
                      }
                    },
                  )
                ],
                elevation: 0.0,
                backgroundColor: Color(0xFFf0f0f0),
                title:
                    Text("Reflex", style: TextStyle(color: Color(0xFF555555))),
                centerTitle: true,
              ),
              bottomNavigationBar: Container(
                  color: Color(0xFFf0f0f0),
                  child: TabBar(
                    labelColor: Color(0xFF555555),
                    indicatorColor: Color(0xFF555555),
                    unselectedLabelColor: Colors.grey[400],
                    tabs: [
                      Tab(text: 'Lap'),
                      Tab(text: 'Random'),
                      Tab(text: 'Sets')
                    ],
                  )),
              body: TabBarView(
                children: [Lap(), RandomBeep(), Sets()],
              ));
        }));
  }
}
