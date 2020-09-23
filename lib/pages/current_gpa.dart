import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradehub/services/Class.dart';

class CurrentGPA extends StatefulWidget {
  List<Class> classes;
  CurrentGPA(List<Class> classes) {
    this.classes = classes;
  }

  @override
  _CurrentGPAState createState() => _CurrentGPAState(classes);
}

class _CurrentGPAState extends State<CurrentGPA> {
  List<Class> classes;
  _CurrentGPAState(List<Class> classes) {
    this.classes = classes;
  }

  double gpa = 0.0;
  String message = 'Not enough information';

  double dp(double val, int places) {
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  void calculateGPA() {
    if (classes.length > 0) {
      double total = 0;
      int length = 0;
      for (int i = 0; i < classes.length; i++) {
        if (classes[i].created) {
          total += classes[i].grade;
          length++;
        }
      }
      if (length != 0 && total != 0) {
        gpa = total / length;
        gpa = dp(gpa, 2);
        if (gpa >= 3.5)
          message = 'Nice job, that\'s an amazing GPA!';
        else if (gpa >= 3.0)
          message = 'You\'re doing great, you got this!';
        else
          message = 'Keep going, you can do this!';
      } else {
        gpa = 0.0;
        message = 'Keep going, you can do this!';
      }
    } else {
      gpa = 0.0;
      message = 'Not enough information';
    }
  }

  void addClass() {
    for (int i = 0; i < classes.length; i++) {
      if (!classes[i].created) return;
    }
    classes.add(Class());
  }

  TextEditingController textController;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  Widget classCard(Class c) {
    if (!c.created)
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Row(
              children: <Widget>[
                Expanded(
                    flex: 7,
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
                            hintText: 'ex: Math',
                          ),
                        ),
                      ),
                    )),
                Expanded(
                  flex: 2,
                  child: DropdownButton(
                    value: c.letterGrade,
                    icon: Icon(Icons.arrow_drop_down),
                    onChanged: (String newValue) {
                      setState(() {
                        c.letterGrade = newValue;
                        if (newValue == 'A')
                          c.grade = 4.0;
                        else if (newValue == 'B+')
                          c.grade = 3.7;
                        else if (newValue == 'B')
                          c.grade = 3.3;
                        else if (newValue == 'B-')
                          c.grade = 3.0;
                        else if (newValue == 'C+')
                          c.grade = 2.7;
                        else if (newValue == 'C')
                          c.grade = 2.3;
                        else if (newValue == 'C-')
                          c.grade = 2.0;
                        else if (newValue == 'D+')
                          c.grade = 1.7;
                        else if (newValue == 'D')
                          c.grade = 1.3;
                        else if (newValue == 'D-')
                          c.grade = 1.0;
                        else if (newValue == 'F') c.grade = 0.0;
                      });
                    },
                    items: <String>[
                      'A',
                      'B+',
                      'B',
                      'B-',
                      'C+',
                      'C',
                      'C-',
                      'D+',
                      'D',
                      'D-',
                      'F'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: FlatButton(
                    child:
                        Center(child: Icon(Icons.check, color: Colors.black)),
                    onPressed: () {
                      setState(() {
                        c.name = textController.text != ''
                            ? textController.text
                            : 'New Class';
                        textController.text = '';
                        c.created = true;
                        calculateGPA();
                      });
                    },
                  ),
                ),
              ],
            )),
      );
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
          decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            children: <Widget>[
              Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      color: Colors.grey[400],
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Text(
                          '${c.name}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  )),
              Expanded(
                flex: 3,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Container(
                    color: Colors.grey[400],
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: Text(
                        'Grade: ${c.letterGrade}',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: FlatButton(
                  child: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    setState(() {
                      classes.remove(c);
                      calculateGPA();
                    });
                  },
                ),
              )
            ],
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[700],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blue[700],
      ),
      body: Container(
        height: 700,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40)),
            color: Colors.grey[200]),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(40),
                        topLeft: Radius.circular(40),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: SizedBox(
                    height: 100,
                    child: Center(
                      child: Text('Semester GPA Calculator',
                          style: TextStyle(
                              fontSize: 28, fontWeight: FontWeight.bold)),
                    ),
                  )),
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
                        children: classes.map((c) => classCard(c)).toList(),
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
                                    addClass();
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
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Your GPA is a $gpa',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
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
                        'When it comes to GPA\'s there are multiple ways your school can calculate your GPA. This calculator uses the system from my high school. My school uses an unweighted system, meaning that AP classes are graded as normal classes, therefore are worth the same as a normal class. In addition to this, A+\'s and A-\'s are weighted the same as an A. This also means that a GPA will not exceed 4.0. The math to figure out an unweighted GPA is very simple. All you need to do is average your grades together. You can find these values anywhere online.',
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
