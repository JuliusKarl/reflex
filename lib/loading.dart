import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("TensorFlow"), centerTitle: true),
        body: Center(child: Text("Loading")),
        bottomNavigationBar: BottomAppBar(
          child: Text("Bottom"),
        ));
  }
}
