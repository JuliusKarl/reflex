import 'package:flutter/material.dart';
import 'random.dart';
import 'lap.dart';
import 'round.dart';

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
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Color(0xFFf0f0f0),
              title: Text("Reflex", style: TextStyle(color: Color(0xFF555555))),
              centerTitle: true,
            ),
            bottomNavigationBar: TabBar(
              labelColor: Color(0xFF555555),
              indicatorColor: Color(0xFF555555),
              tabs: [
                Tab(text: 'Fixed'),
                Tab(text: 'Random'),
                Tab(text: 'Interval')
              ],
            ),
            body: TabBarView(
              children: [Lap(), Random(), Round()],
            )));
  }
}
