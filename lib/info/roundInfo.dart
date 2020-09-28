import 'package:flutter/material.dart';

class RoundInfo extends StatefulWidget {
  @override
  _RoundInfoState createState() => _RoundInfoState();
}

class _RoundInfoState extends State<RoundInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF555555)),
            centerTitle: true,
            backgroundColor: Color(0xFFf0f0f0),
            title:
                Text("Set Timer", style: TextStyle(color: Color(0xFF555555)))));
  }
}
