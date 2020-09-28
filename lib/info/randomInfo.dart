import 'package:flutter/material.dart';

class RandomInfo extends StatefulWidget {
  @override
  _RandomInfoState createState() => _RandomInfoState();
}

class _RandomInfoState extends State<RandomInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF555555)),
            centerTitle: true,
            backgroundColor: Color(0xFFf0f0f0),
            title: Text("Random Timer",
                style: TextStyle(color: Color(0xFF555555)))));
  }
}
