import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gradehub/services/StudyObject.dart';
import 'package:vibration/vibration.dart';

class StudyTimer extends StatefulWidget {
  List<StudyObject> studyObj;
  StudyTimer(List<StudyObject> studyObj) {
    this.studyObj = studyObj;
  }

  @override
  _StudyTimerState createState() => _StudyTimerState(studyObj);
}

class _StudyTimerState extends State<StudyTimer> {

  Timer _timer;
  int currentTimer = 0;
  int minutes = 0;
  int seconds = 0;
  String timerString = '0';
  bool showTimer = false;

  final textController = TextEditingController();

  List<StudyObject> studyObj;
  _StudyTimerState(List<StudyObject> studyObj) {
    this.studyObj = studyObj;
  }

  void setTimer(int minutes) {
    currentTimer = minutes * 60;
    this.minutes = minutes;
    seconds = 0;
    timerString = '${this.minutes}:$seconds\0';
  }

  void runTimer(StudyObject obj) {
    if (_timer != null) _timer.cancel();

        _timer = Timer.periodic(Duration(seconds: 1), (timer) {
          setState(() {
            if (currentTimer > 0) {
              currentTimer--;
              if (seconds == 0) {
                seconds = 60;
                minutes--;
              }
              seconds--;
              String sec = seconds < 10 ? '0$seconds' : '$seconds';
              timerString = '$minutes:$sec';
            } else {
              _timer.cancel();
              obj.finnished = true;
              Vibration.vibrate(duration: 2000);
            }
          });
      });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null)_timer.cancel();
    textController.dispose();
  }

  Widget studyObjCard(StudyObject obj) {
    if (!obj.created)
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                      flex: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 40,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 18,
                            ),
                            controller: textController,
                            decoration: InputDecoration(
                              fillColor: Colors.grey[400],
                              filled: true,
                              hintText: 'Name',
                            ),
                          ),
                        ),
                      )),
                Expanded(
                  flex: 3,
                  child: DropdownButton(
                    value: '${obj.studyDuration} min',
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (String newValue) {
                      setState(() {
                        obj.studyDuration = int.parse(newValue.substring(0, 2));
                      });
                    },

                    items: <String>['60 min','45 min', '30 min', '15 min']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton(
                      child: Icon(Icons.check),
                      onPressed: () {
                        setState(() {
                          obj.created = true;
                          obj.name = textController.text;
                          if (obj.name == '') obj.name = 'New Class';
                          textController.text = '';
                        });
                      },
                    ),
                  ),
                )
              ],
            )),
      );
    else if (obj.editing) return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[350],
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        controller: textController,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[400],
                          filled: true,
                          hintText: 'Name',
                        ),
                      ),
                    ),
                  )),
              Expanded(
                flex: 3,
                child: DropdownButton(
                  value: '${obj.studyDuration} min',
                  icon: Icon(Icons.arrow_drop_down),
                  onChanged: (String newValue) {
                    setState(() {
                      obj.studyDuration = int.parse(newValue.substring(0, 2));
                    });
                  },
                  items: <String>['60 min','45 min', '30 min', '15 min']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FlatButton(
                    child: Icon(Icons.check),
                    onPressed: () {
                      setState(() {
                        obj.editing = false;
                        obj.name = textController.text;
                        if (obj.name == '') obj.name = 'New Class';
                        textController.text = '';
                        if (obj.playing) setTimer(obj.studyDuration);
                      });
                    },
                  ),
                ),
              )
            ],
          )),
    );
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left:4.0, right: 4.0, top: 4.0),
                        child: Container(
                          color: Colors.grey[400],
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              '${obj.name}',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                    flex: 2,
                    child: FlatButton(
                      child: Icon(
                        Icons.check,
                        color: (obj.finnished) ? Colors.green : Colors.black,
                      ),
                      onPressed: () {
                        setState(() {
                          studyObj.remove(obj);
                          if (obj.playing) {
                            if (_timer != null) _timer.cancel();
                            setTimer(0);
                            obj.paused = true;
                            showTimer = false;
                            obj.playing = false;
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: FlatButton(
                      child: Icon(
                        Icons.edit,
                      ),
                      onPressed: () {
                        setState(() {
                          obj.editing = true;
                          textController.text = obj.name;
                        });
                      },
                    ),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                      flex: 6,
                      child: Padding(
                        padding: const EdgeInsets.only(left:4.0, right: 4.0, bottom: 4.0),
                        child: Container(
                          color: Colors.grey[400],
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text(
                              'Duration: ${obj.studyDuration} minutes',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                        ),
                      )),
                  Expanded(
                    flex: (obj.playing) ? 2 : 4,
                    child: FlatButton(
                      child: Icon(
                        (obj.paused) ? Icons.play_arrow : Icons.pause,
                      ),
                      onPressed: () {
                        setState(() {
                          if (!obj.playing) {
                            obj.playing = true;
                            obj.paused = false;
                            setTimer(obj.studyDuration);
                            showTimer = true;
                            for (int i = 0; i < studyObj.length; i++) {
                              if (i != studyObj.indexOf(obj)) {
                                studyObj[i].playing = false;
                                studyObj[i].paused = true;
                              }
                            }
                            runTimer(obj);
                          } else if (obj.playing && obj.paused) {
                            runTimer(obj);
                            obj.paused = false;
                          } else if (obj.playing && !obj.paused) {
                            _timer.cancel();
                            obj.paused = true;
                          }
                        });
                      },
                    ),
                  ),
                  (obj.playing) ? Expanded(
                    flex: 2,
                    child: FlatButton(
                      child: Icon(
                        Icons.stop,
                      ),
                      onPressed: () {
                        setState(() {
                          _timer.cancel();
                          setTimer(0);
                          obj.paused = true;
                          showTimer = false;
                          obj.playing = false;
                        });
                      },
                    ),
                  ) : Container()
                ],
              ),
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        height: 700,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Colors.grey[200],
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                color: Colors.grey[300],
                child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('Study Timer',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    )),
              ),
              (showTimer)
                  ? Card(
                      color: Colors.grey[300],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: 200,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Colors.grey[350],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                  border: Border.all()),
                              child: Center(
                                child: Text(
                                  timerString,
                                  style: TextStyle(fontSize: 50),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ))
                  : Container(),
              Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Text(
                          'Classes',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Column(
                        children:
                            studyObj.map((obj) => studyObjCard(obj)).toList(),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4.0),
                              child: FlatButton(
                                color: Colors.grey[350],
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8))),
                                child: SizedBox(
                                  height: 40,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Add Class',
                                      style: TextStyle(fontSize: 18),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    bool allCreated = true;
                                    for (int i = 0; i < studyObj.length; i++) {
                                      if (studyObj[i].editing || !studyObj[i].created) allCreated = false;
                                    }
                                    if (allCreated) studyObj.add(StudyObject());
                                  });
                                },
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          'Information',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 26,
                          ),
                        ),
                      ),
                      Text(
                        'Add a study objective, name it, and give it a time. You can choose from 15 minutes, 30 minutes, 45 minutes, and 60 minutes. Once created, you can press the play button, which will bring up the study timer. Once this timer runs out the check mark will go green, meaning you can check the objective off your list.',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
