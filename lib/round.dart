import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class Round extends StatefulWidget {
  @override
  _RoundState createState() => _RoundState();
}

class _RoundState extends State<Round> {
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
    return Center(child: Container(child: Text('Interval')));
  }
}
