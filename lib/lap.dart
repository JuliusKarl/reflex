import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Lap extends StatefulWidget {
  @override
  _LapState createState() => _LapState();
}

class _LapState extends State<Lap> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Turn off all sounds/timers here
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Container(child: Text('Fixed')));
  }
}
