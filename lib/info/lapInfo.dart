import 'package:flutter/material.dart';

class LapInfo extends StatefulWidget {
  @override
  _LapInfoState createState() => _LapInfoState();
}

class _LapInfoState extends State<LapInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            iconTheme: IconThemeData(color: Color(0xFF555555)),
            centerTitle: true,
            backgroundColor: Color(0xFFf0f0f0),
            title:
                Text("Lap Timer", style: TextStyle(color: Color(0xFF555555)))));
  }
}
