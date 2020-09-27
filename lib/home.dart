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
  Widget activeTab;

  List<Tab> myTabs = <Tab>[
    Tab(text: "Fixed"),
    Tab(text: "Random"),
    Tab(text: "Interval"),
  ];
  TabController _tabController;

  void _setActiveTabIndex() {
    _activeTabIndex = _tabController.index;
    print(_activeTabIndex);
    switch (_activeTabIndex) {
      case 0:
        {
          setState(() {
            activeTab = Lap();
          });
        }
        break;
      case 1:
        {
          setState(() {
            activeTab = Random();
          });
        }
        break;
      case 2:
        {
          setState(() {
            activeTab = Round();
          });
        }
        break;
    }
  }

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: myTabs.length);
    _tabController.addListener(_setActiveTabIndex);
    activeTab = Lap();
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
          elevation: 0.0,
          backgroundColor: Color(0xFFf0f0f0),
          title: Text("Reflex", style: TextStyle(color: Colors.black)),
          centerTitle: true,
        ),
        bottomNavigationBar: Container(
            color: Color(0xFFf0f0f0),
            child: TabBar(
              indicatorColor: Colors.lightBlue,
              labelColor: Colors.lightBlue,
              unselectedLabelColor: Colors.grey,
              controller: _tabController,
              tabs: myTabs,
            )),
        body: Container(child: activeTab));
  }
}
