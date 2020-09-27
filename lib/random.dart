import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class Random extends StatefulWidget {
  @override
  _RandomState createState() => _RandomState();
}

class _RandomState extends State<Random> {
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
    return Center(child: Container(child: Text('Random')));
  }
}
