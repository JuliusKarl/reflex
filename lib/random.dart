import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:audioplayers/audio_cache.dart';
import 'dart:async';
import 'dart:math';

class RandomBeep extends StatefulWidget {
  @override
  _RandomBeepState createState() => _RandomBeepState();
}

class _RandomBeepState extends State<RandomBeep> {
  final _isHours = false;
  final minutesController = TextEditingController();
  final minMinutesController = TextEditingController();
  final maxMinutesController = TextEditingController();
  final secondsController = TextEditingController();
  final minSecondsController = TextEditingController();
  final maxSecondsController = TextEditingController();
  final _random = new Random();
  final player = AudioCache();
  bool isRunning = false;
  bool reset = false;
  int setMinutes = 0;
  int setSeconds = 0;
  int maxMinutes = 0;
  int maxSeconds = 0;
  int minMinutes = 0;
  int minSeconds = 0;
  int maxIntervalTotal = 0;
  int minIntervalTotal = 0;
  Timer timer;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
      isLapHours: true, onChange: (value) => {print('onChange $value')});

  @override
  void initState() {
    player.disableLog();
    super.initState();
    _stopWatchTimer.rawTime.listen((value) {
      print(minIntervalTotal +
          _random.nextInt(maxIntervalTotal - minIntervalTotal));
      if (StopWatchTimer.getRawSecond(value * 10) == 0) {
        if (maxIntervalTotal != 0) {
          player.play('sounds/boxing-bell.mp3');
          timer.cancel();
        }
        setState(() {
          isRunning = false;
        });
      }
    });
    super.initState();
  }

  void dispose() async {
    super.dispose();
    timer.cancel();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(bottom: 0),
            child: StreamBuilder<int>(
              stream: _stopWatchTimer.rawTime,
              initialData: _stopWatchTimer.rawTime.value,
              builder: (context, snap) {
                final value = snap.data;
                final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: _isHours);
                return Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: Text(displayTime,
                              style: const TextStyle(
                                  fontSize: 75,
                                  fontFamily: 'Digital',
                                  color: Color(0xFF555555))),
                        ),
                      ],
                    ));
              },
            ),
          ),

          // Time Options
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Workout")),
          Container(
              margin: EdgeInsets.fromLTRB(30, 5, 30, 25),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Container(
                            height: 40,
                            width: 140,
                            child: TextField(
                              controller: minutesController,
                              enableInteractiveSelection: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                maxMinutesController.text = '';
                                maxSecondsController.text = '';
                                minMinutesController.text = '';
                                minSecondsController.text = '';
                                maxMinutes = 0;
                                maxSeconds = 0;
                                minMinutes = 0;
                                minSeconds = 0;
                                if (int.parse(text) > 59) {
                                  minutesController.text = '';
                                  setMinutes = 0;
                                  _stopWatchTimer.setPresetMinuteTime(0);
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Value too high')));
                                } else {
                                  setMinutes = int.parse(text);
                                  _stopWatchTimer
                                      .setPresetMinuteTime(int.parse(text));
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(5),
                                )),
                                labelText: 'Min',
                              ),
                            ))),
                    Flexible(
                        child: Container(
                            height: 40,
                            width: 140,
                            child: TextField(
                              controller: secondsController,
                              enableInteractiveSelection: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                maxMinutesController.text = '';
                                maxSecondsController.text = '';
                                minMinutesController.text = '';
                                minSecondsController.text = '';
                                maxMinutes = 0;
                                maxSeconds = 0;
                                minMinutes = 0;
                                minSeconds = 0;
                                if (int.parse(text) > 59) {
                                  secondsController.text = '';
                                  setSeconds = 0;
                                  _stopWatchTimer.setPresetSecondTime(0);
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Value too high')));
                                } else {
                                  setSeconds = int.parse(text);
                                  _stopWatchTimer
                                      .setPresetSecondTime(int.parse(text));
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(5),
                                )),
                                labelText: 'Sec',
                              ),
                            ))),
                  ])),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Maximum")),
          Container(
              margin: EdgeInsets.fromLTRB(30, 5, 30, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Container(
                            height: 40,
                            width: 140,
                            child: TextField(
                              controller: maxMinutesController,
                              enableInteractiveSelection: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                minMinutesController.text = '';
                                minSecondsController.text = '';
                                minMinutes = 0;
                                minSeconds = 0;
                                if (int.parse(text) > 59) {
                                  maxMinutes = 0;
                                  maxMinutesController.text = '';
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Value too high')));
                                } else {
                                  if (((int.parse(text) * 60) + maxSeconds) >
                                      ((setMinutes * 60) + setSeconds)) {
                                    maxMinutes = 0;
                                    maxMinutesController.text = '';
                                    Scaffold.of(context)
                                        .removeCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Maximum interval must be less than workout')));
                                  } else {
                                    maxMinutes = int.parse(text) * 60;
                                    maxIntervalTotal = maxMinutes + maxSeconds;
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(5),
                                )),
                                labelText: 'Min',
                              ),
                            ))),
                    Flexible(
                        child: Container(
                            height: 40,
                            width: 140,
                            child: TextField(
                              controller: maxSecondsController,
                              enableInteractiveSelection: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                minMinutesController.text = '';
                                minSecondsController.text = '';
                                minMinutes = 0;
                                minSeconds = 0;
                                if (int.parse(text) > 59) {
                                  maxSeconds = 0;
                                  maxSecondsController.text = '';
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Value too high')));
                                } else {
                                  if (((maxMinutes * 60) + int.parse(text)) >
                                      ((setMinutes * 60) + setSeconds)) {
                                    maxSeconds = 0;
                                    maxSecondsController.text = '';
                                    Scaffold.of(context)
                                        .removeCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Maximum interval must be less than workout')));
                                  } else {
                                    maxSeconds = int.parse(text);
                                    maxIntervalTotal = maxMinutes + maxSeconds;
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(5),
                                )),
                                labelText: 'Sec',
                              ),
                            ))),
                  ])),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Text("Minimum")),
          Container(
              margin: EdgeInsets.fromLTRB(30, 5, 30, 5),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                        child: Container(
                            height: 40,
                            width: 140,
                            child: TextField(
                              controller: minMinutesController,
                              enableInteractiveSelection: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                if (int.parse(text) > 59) {
                                  minMinutes = 0;
                                  minMinutesController.text = '';
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Value too high')));
                                } else {
                                  if (((int.parse(text) * 60) + minSeconds) >
                                      ((maxMinutes * 60) + maxSeconds)) {
                                    minMinutes = 0;
                                    minMinutesController.text = '';
                                    Scaffold.of(context)
                                        .removeCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Minimum interval must be less than maximum interval')));
                                  } else {
                                    minMinutes = int.parse(text) * 60;
                                    minIntervalTotal = minMinutes + minSeconds;
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(5),
                                )),
                                labelText: 'Min',
                              ),
                            ))),
                    Flexible(
                        child: Container(
                            height: 40,
                            width: 140,
                            child: TextField(
                              controller: minSecondsController,
                              enableInteractiveSelection: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                if (int.parse(text) > 59) {
                                  minSeconds = 0;
                                  minSecondsController.text = '';
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Value too high')));
                                } else {
                                  if (((minMinutes * 60) + int.parse(text)) >
                                      ((maxMinutes * 60) + maxSeconds)) {
                                    minSeconds = 0;
                                    minSecondsController.text = '';
                                    Scaffold.of(context)
                                        .removeCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Minimum interval must be less than maximum interval')));
                                  } else {
                                    minSeconds = int.parse(text);
                                    minIntervalTotal = minMinutes + minSeconds;
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(5),
                                )),
                                labelText: 'Sec',
                              ),
                            ))),
                  ])),
          Container(
              margin: EdgeInsets.only(top: 20),
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: RaisedButton(
                  padding: const EdgeInsets.all(4),
                  color: isRunning ? Color(0xFFd41e1e) : Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(5))),
                  onPressed: () async {
                    if (setMinutes == 0 && setSeconds == 0) {
                      DoNothingAction();
                    } else {
                      if (maxIntervalTotal != 0) {
                        isRunning
                            ? timer.cancel()
                            : timer = new Timer.periodic(
                                new Duration(
                                    seconds: minIntervalTotal +
                                        _random.nextInt(maxIntervalTotal -
                                            minIntervalTotal)), (timer) {
                                player.play('sounds/censor-beep-1.mp3');
                              });
                      }
                      reset = true;
                      isRunning
                          ? _stopWatchTimer.onExecute.add(StopWatchExecute.stop)
                          : _stopWatchTimer.onExecute
                              .add(StopWatchExecute.start);
                      setState(() {
                        isRunning = !isRunning;
                      });
                    }
                  },
                  child: Text(
                    isRunning ? 'Stop' : 'Start',
                    style: TextStyle(
                        color: isRunning ? Colors.white : Color(0xFF555555)),
                  ),
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 20),
              height: 40,
              child: reset
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: RaisedButton(
                        padding: const EdgeInsets.all(4),
                        color: Colors.white,
                        shape: const RoundedRectangleBorder(
                            borderRadius: const BorderRadius.all(
                                const Radius.circular(5))),
                        onPressed: () async {
                          _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                          setState(() {
                            isRunning = false;
                            reset = false;
                          });
                        },
                        child: Text(
                          'Reset',
                          style: TextStyle(color: Color(0xFF555555)),
                        ),
                      ),
                    )
                  : null)
        ],
      ),
    );
  }
}
