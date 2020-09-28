import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class Round extends StatefulWidget {
  @override
  _RoundState createState() => _RoundState();
}

class _RoundState extends State<Round> {
  final _isHours = true;

  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    isLapHours: true,
    onChange: (value) => print('onChange $value'),
    onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
    onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
  );

  @override
  void initState() {
    super.initState();
    _stopWatchTimer.rawTime.listen((value) =>
        print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
    _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
    _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
    _stopWatchTimer.records.listen((value) => print('records $value'));
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
        // mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          /// Display stop watch time
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
                                  color: Color(0xFFd41e1e))),
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
              margin: EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("Total Sets"),
              )),
          Container(
              margin: EdgeInsets.fromLTRB(30, 5, 30, 25),
              child: Row(children: [
                Flexible(
                    child: Container(
                        height: 40,
                        width: 35,
                        margin: EdgeInsets.only(right: 10),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (text) {
                            _stopWatchTimer
                                .setPresetSecondTime(int.parse(text));
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: '0',
                          ),
                        )))
              ])),
          Container(
              margin: EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("Set Time"),
              )),
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
                                border: OutlineInputBorder(),
                                labelText: 'Minutes',
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
                                border: OutlineInputBorder(),
                                labelText: 'Seconds',
                              ),
                            ))),
                  ])),
          Container(
              margin: EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text("Rest Time"),
              )),
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
                                border: OutlineInputBorder(),
                                labelText: 'Minutes',
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
                                border: OutlineInputBorder(),
                                labelText: 'Seconds',
                              ),
                            ))),
                  ])),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: RaisedButton(
              padding: const EdgeInsets.all(4),
              color: Colors.lightGreen,
              shape: const StadiumBorder(),
              onPressed: () async {
                _stopWatchTimer.onExecute.add(StopWatchExecute.start);
              },
              child: const Text(
                'Start',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: RaisedButton(
              padding: const EdgeInsets.all(4),
              color: Color(0xFFd41e1e),
              shape: const StadiumBorder(),
              onPressed: () async {
                _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
              },
              child: const Text(
                'Stop',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
