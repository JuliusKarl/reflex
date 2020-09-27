import 'package:flutter/material.dart';
import 'random.dart';
import 'lap.dart';
import 'round.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int _activeTabIndex;
  List<Tab> myTabs = <Tab>[
    Tab(text: "Lap"),
    Tab(text: "Random"),
    Tab(text: "Interval"),
  ];
  TabController _tabController;

  void _setActiveTabIndex() {
    _activeTabIndex = _tabController.index;
    print(_activeTabIndex);
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(_setActiveTabIndex);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Reflex"),
          centerTitle: true,
        ),
        bottomNavigationBar: TabBar(
          indicatorColor: Colors.lightBlue,
          labelColor: Colors.lightBlue,
          unselectedLabelColor: Colors.grey,
          controller: _tabController,
          tabs: myTabs,
        ),
        body: TabBarView(
          controller: _tabController,
          children: myTabs.map((Tab tab) {
            final String label = tab.text.toLowerCase();
            return Center(
              child: Text('$label'),
            );
          }).toList(),
        ));
  }
}
