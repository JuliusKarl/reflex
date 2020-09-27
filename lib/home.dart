import 'package:flutter/material.dart';
import 'random.dart';
import 'lap.dart';
import 'round.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: Colors.grey,
              title: Text("Reflex"),
              centerTitle: true),
          bottomNavigationBar: BottomAppBar(
            child: TabBar(
              labelColor: Colors.grey,
              indicatorColor: Colors.grey,
              tabs: [
                Tab(icon: Icon(Icons.access_alarm), text: "Lap"),
                Tab(icon: Icon(Icons.help_outline), text: "Random"),
                Tab(icon: Icon(Icons.notifications_none), text: "Interval"),
              ],
            ),
          ),
          body: TabBarView(
            children: [Lap(), Random(), Round()],
          ),
        ));
  }
}
