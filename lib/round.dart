import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Round extends StatefulWidget {
  @override
  _RoundState createState() => _RoundState();
}

class _RoundState extends State<Round> {
  final _isHours = true;
  final secondsController = TextEditingController();
  final minutesController = TextEditingController();
  bool isRunning = false;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
      isLapHours: true, onChange: (value) => {print('onChange $value')});

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) {
      if (StopWatchTimer.getRawSecond(value * 10) == 0) {
        setState(() {
          isRunning = false;
        });
      }
    });
    super.initState();
  }

  void dispose() async {
    super.dispose();
    // turn off sounds as well
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
                                  fontSize: 60,
                                  fontFamily: 'Digital',
                                  color: Color(0xFF555555))),
                        ),
                      ],
                    ));
              },
            ),
          ),

          // /// Button
          // Padding(
          //   padding: const EdgeInsets.all(2),
          //   child: Column(
          //     children: <Widget>[
          //       Padding(
          //         padding: const EdgeInsets.only(bottom: 0),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: <Widget>[
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 4),
          //               child: RaisedButton(
          //                 padding: const EdgeInsets.all(4),
          //                 color: Colors.lightBlue,
          //                 shape: const StadiumBorder(),
          //                 onPressed: () async {
          //                   _stopWatchTimer.onExecute
          //                       .add(StopWatchExecute.start);
          //                 },
          //                 child: const Text(
          //                   'Start',
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 4),
          //               child: RaisedButton(
          //                 padding: const EdgeInsets.all(4),
          //                 color: Colors.green,
          //                 shape: const StadiumBorder(),
          //                 onPressed: () async {
          //                   _stopWatchTimer.onExecute
          //                       .add(StopWatchExecute.stop);
          //                 },
          //                 child: const Text(
          //                   'Stop',
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //               padding: const EdgeInsets.symmetric(horizontal: 4),
          //               child: RaisedButton(
          //                 padding: const EdgeInsets.all(4),
          //                 color: Colors.red,
          //                 shape: const StadiumBorder(),
          //                 onPressed: () async {
          //                   _stopWatchTimer.onExecute
          //                       .add(StopWatchExecute.reset);
          //                 },
          //                 child: const Text(
          //                   'Reset',
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //       ),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 4),
          //         child: Row(
          //           mainAxisAlignment: MainAxisAlignment.center,
          //           children: <Widget>[
          //             Padding(
          //               padding: const EdgeInsets.all(0).copyWith(right: 8),
          //               child: RaisedButton(
          //                 padding: const EdgeInsets.all(4),
          //                 color: Colors.deepPurpleAccent,
          //                 shape: const StadiumBorder(),
          //                 onPressed: () async {
          //                   _stopWatchTimer.onExecute.add(StopWatchExecute.lap);
          //                 },
          //                 child: const Text(
          //                   'Lap',
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //               ),
          //             ),
          //             Padding(
          //                 padding: const EdgeInsets.symmetric(horizontal: 4),
          //                 child: RaisedButton(
          //                   padding: const EdgeInsets.all(4),
          //                   color: Colors.pinkAccent,
          //                   shape: const StadiumBorder(),
          //                   onPressed: () async {
          //                     _stopWatchTimer.setPresetSecondTime(59);
          //                   },
          //                   child: const Text(
          //                     'Set Second',
          //                     style: TextStyle(color: Colors.white),
          //                   ),
          //                 )),
          //           ],
          //         ),
          //       ),
          Container(
              margin: EdgeInsets.fromLTRB(30, 5, 30, 25),
              child: Row(children: [
                Flexible(
                    child: Container(
                        width: 140,
                        height: 40,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          onChanged: (text) {
                            _stopWatchTimer
                                .setPresetSecondTime(int.parse(text));
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: const BorderRadius.all(
                              const Radius.circular(20.0),
                            )),
                            labelText: 'Total Sets',
                          ),
                        )))
              ])),
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
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                if (int.parse(text) < 0) {
                                  minutesController.text = 0.toString();
                                  _stopWatchTimer.setPresetSecondTime(0);
                                } else {
                                  _stopWatchTimer
                                      .setPresetMinuteTime(int.parse(text));
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                )),
                                labelText: 'Set Minutes',
                              ),
                            ))),
                    Flexible(
                        child: Container(
                            height: 40,
                            width: 140,
                            child: TextField(
                              controller: secondsController,
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                if (int.parse(text) > 59 ||
                                    int.parse(text) < 0) {
                                  secondsController.text = 0.toString();
                                  _stopWatchTimer.setPresetSecondTime(0);
                                } else {
                                  _stopWatchTimer
                                      .setPresetSecondTime(int.parse(text));
                                }
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                )),
                                labelText: 'Set Seconds',
                              ),
                            ))),
                  ])),
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
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                _stopWatchTimer
                                    .setPresetSecondTime(int.parse(text));
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                )),
                                labelText: 'Rest Minutes',
                              ),
                            ))),
                    Flexible(
                        child: Container(
                            height: 40,
                            width: 140,
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                _stopWatchTimer
                                    .setPresetSecondTime(int.parse(text));
                              },
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                  const Radius.circular(20.0),
                                )),
                                labelText: 'Rest Seconds',
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
                  color: isRunning ? Color(0xFFd41e1e) : Colors.lightGreen,
                  shape: const StadiumBorder(),
                  onPressed: () async {
                    isRunning
                        ? _stopWatchTimer.onExecute.add(StopWatchExecute.stop)
                        : _stopWatchTimer.onExecute.add(StopWatchExecute.start);
                    setState(() {
                      isRunning = !isRunning;
                    });
                  },
                  child: Text(
                    isRunning ? 'Stop' : 'Start',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )),
          Container(
              margin: EdgeInsets.only(top: 20),
              height: 40,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: RaisedButton(
                  padding: const EdgeInsets.all(4),
                  color: Colors.white,
                  shape: const StadiumBorder(),
                  onPressed: () async {
                    _stopWatchTimer.onExecute.add(StopWatchExecute.reset);
                  },
                  child: Text(
                    'Reset',
                    style: TextStyle(color: Color(0xFF555555)),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
