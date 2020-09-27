import 'package:flutter/material.dart';
import 'loading.dart';
import 'home.dart';

void main() => runApp(MaterialApp(
        theme: ThemeData(fontFamily: 'Questrial'),
        initialRoute: '/home',
        routes: {
          '/loading': (context) => Loading(),
          '/home': (context) => Home()
        }));
