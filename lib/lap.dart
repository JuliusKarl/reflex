import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:async/async.dart';
import 'dart:async';

class Lap extends StatefulWidget {
  @override
  _LapState createState() => _LapState();
}

class _LapState extends State<Lap> {
  final _isHours = false;
  final minutesController = TextEditingController();
  final minutesController2 = TextEditingController();
  final secondsController = TextEditingController();
  final secondsController2 = TextEditingController();
  final player = AudioCache();
  bool isRunning = false;
  bool reset = false;
  bool enabledText = true;
  int setMinutes = 0;
  int setSeconds = 0;
  int intervalMinutes = 0;
  int intervalSeconds = 0;
  int intervalTotal = 0;
  Timer activeTimer;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    // onChange: (value) => {
    //       // print('onChange $value')
    //     }
  );

  @override
  void initState() {
    player.disableLog();
    super.initState();
    _stopWatchTimer.rawTime.listen((value) {
      if (StopWatchTimer.getRawSecond(value * 10) == 0) {
        if (intervalTotal != 0) {
          player.play('sounds/boxing-bell.mp3');
          activeTimer.cancel();
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
    activeTimer.cancel();
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

          //  Time Options
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
                              enabled: enabledText ? true : false,
                              enableInteractiveSelection: false,
                              controller: minutesController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                if (activeTimer != null) {
                                  activeTimer.cancel();
                                }
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.stop);
                                minutesController2.text = '';
                                secondsController2.text = '';
                                intervalMinutes = 0;
                                intervalSeconds = 0;
                                intervalTotal = 0;
                                setState(() {
                                  setMinutes = 0;
                                  isRunning = false;
                                  reset = false;
                                });
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
                              enabled: enabledText ? true : false,
                              enableInteractiveSelection: false,
                              controller: secondsController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                if (activeTimer != null) {
                                  activeTimer.cancel();
                                }
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.stop);
                                minutesController2.text = '';
                                secondsController2.text = '';
                                intervalMinutes = 0;
                                intervalSeconds = 0;
                                intervalTotal = 0;
                                setState(() {
                                  setSeconds = 0;
                                  isRunning = false;
                                  reset = false;
                                });
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
              child: Text("Interval")),
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
                              enabled: enabledText ? true : false,
                              controller: minutesController2,
                              enableInteractiveSelection: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                if (activeTimer != null) {
                                  activeTimer.cancel();
                                }
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.stop);
                                setState(() {
                                  intervalMinutes = 0;
                                  isRunning = false;
                                  reset = false;
                                });

                                if (int.parse(text) > 59) {
                                  intervalMinutes = 0;
                                  minutesController2.text = '';
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Value too high')));
                                } else {
                                  if (((int.parse(text) * 60) +
                                          intervalSeconds) >
                                      ((setMinutes * 60) + setSeconds)) {
                                    intervalMinutes = 0;
                                    minutesController2.text = '';
                                    Scaffold.of(context)
                                        .removeCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Interval must be less than workout')));
                                  } else {
                                    intervalMinutes = int.parse(text);
                                    intervalTotal =
                                        intervalMinutes + intervalSeconds;
                                  }
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(
                                    const Radius.circular(5),
                                  ),
                                ),
                                labelText: 'Min',
                              ),
                            ))),
                    Flexible(
                        child: Container(
                            height: 40,
                            width: 140,
                            child: TextField(
                              enabled: enabledText ? true : false,
                              controller: secondsController2,
                              enableInteractiveSelection: false,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                if (activeTimer != null) {
                                  activeTimer.cancel();
                                }
                                _stopWatchTimer.onExecute
                                    .add(StopWatchExecute.stop);
                                setState(() {
                                  intervalSeconds = 0;
                                  isRunning = false;
                                  reset = false;
                                });

                                if (int.parse(text) > 59) {
                                  intervalSeconds = 0;
                                  secondsController2.text = '';
                                  Scaffold.of(context).removeCurrentSnackBar();
                                  Scaffold.of(context).showSnackBar(SnackBar(
                                      duration: Duration(seconds: 1),
                                      content: Text('Value too high')));
                                } else {
                                  if (((intervalMinutes * 60) +
                                          int.parse(text)) >
                                      ((setMinutes * 60) + setSeconds)) {
                                    intervalSeconds = 0;
                                    secondsController2.text = '';
                                    Scaffold.of(context)
                                        .removeCurrentSnackBar();
                                    Scaffold.of(context).showSnackBar(SnackBar(
                                        duration: Duration(seconds: 1),
                                        content: Text(
                                            'Interval must be less than workout')));
                                  } else {
                                    intervalSeconds = int.parse(text);
                                    intervalTotal =
                                        intervalMinutes + intervalSeconds;
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
                    if (activeTimer != null) {
                      activeTimer.cancel();
                    }
                    if (setMinutes == 0 && setSeconds == 0) {
                      DoNothingAction();
                    } else {
                      reset = true;
                      isRunning
                          ? _stopWatchTimer.onExecute.add(StopWatchExecute.stop)
                          : _stopWatchTimer.onExecute
                              .add(StopWatchExecute.start);
                      if (intervalTotal != 0) {
                        if (!isRunning) {
                          Timer.periodic(
                              new Duration(
                                  seconds: intervalSeconds,
                                  minutes: intervalMinutes), (timer) {
                            activeTimer = timer;
                            player.play('sounds/censor-beep-1.mp3');
                          });
                        }
                      }
                      setState(() {
                        isRunning = !isRunning;
                        enabledText = !enabledText;
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
                            enabledText = true;
                          });
                          if (activeTimer != null) {
                            activeTimer.cancel();
                          }
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
