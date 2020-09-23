import 'dart:math';

import 'package:flutter/material.dart';

class FinalGrade extends StatefulWidget {
  @override
  _FinalGradeState createState() => _FinalGradeState();
}

class _FinalGradeState extends State<FinalGrade> {
  double requiredGrade = 0.0;
  double desiredGrade = 0;
  double currentGrade = 0;
  double finalWorth = 0;
  final currentController = TextEditingController();
  final desiredController = TextEditingController();
  final worthController = TextEditingController();

  String message = 'Not enough information';

  double dp(double val, int places){
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  @override
  void dispose() {
    super.dispose();
    currentController.dispose();
    desiredController.dispose();
    worthController.dispose();
  }

  void calculateRequiredGrade() {
    double majority = 1 - finalWorth;
    requiredGrade = ((desiredGrade - currentGrade * majority) / finalWorth);
    requiredGrade = dp(requiredGrade, 2);
    if (requiredGrade > 100)
      message = 'Keep going, you can still ace this test!';
    else if (requiredGrade > 88)
      message = 'Keep studying, you got this!';
    else if (requiredGrade > 70)
      message = 'You got this!';
    else if (requiredGrade > 0)
      message = 'Smooth sailing!';
    else
      message = 'You don\'t even have to try!';
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
          color: Colors.grey[200],
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
        ),
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
                      child: Text('Final Grade Calculator',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold)),
                    ),
                  )),
              Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 6, 0, 0),
                              child: Text(
                                'Your Current Grade',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: currentController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'ex: 96.7%',
                                  fillColor: Colors.grey[350],
                                  filled: true,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 6, 0, 0),
                              child: Text(
                                'Your Desired Grade',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 16, 0),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: desiredController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'ex: 92.4%',
                                  fillColor: Colors.grey[350],
                                  filled: true,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 6, 0, 8),
                              child: Text(
                                'Your Final is Worth',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 8, 16, 8),
                              child: TextField(
                                keyboardType: TextInputType.number,
                                controller: worthController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'ex: 10%',
                                  fillColor: Colors.grey[350],
                                  filled: true,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )),
              Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FlatButton(
                            onPressed: () {
                              setState(() {
                                if (currentController.text != '' &&
                                    desiredController.text != '' &&
                                    worthController.text != '' &&
                                    currentController.text != '0' &&
                                    desiredController.text != '0' &&
                                    worthController.text != '0') {
                                  currentGrade =
                                      double.parse(currentController.text);
                                  desiredGrade =
                                      double.parse(desiredController.text);
                                  finalWorth =
                                      double.parse(worthController.text) /
                                          100.0;
                                  calculateRequiredGrade();
                                } else {
                                  message =
                                      'Not enough or incorrect information given. Please provide more information.';
                                }
                              });
                            },
                            child: Text(
                              'Calculate Required Grade',
                              style: TextStyle(
                                  fontSize: 20, color: Colors.grey[800]),
                            )),
                      )
                    ],
                  )),
              Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8)),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'You need at least a $requiredGrade%',
                        textAlign: TextAlign.center,
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
                        'Your grade in a class typically has multiple categories, each with different weights on how they effect your overall grade. Your final exam is one of these categories, normally worth 10-20%. Check with your teacher or your syllabus for this information. I\'m going to show you how to figure out what you need on your final exam in order to get your desired grade. If you want to try it yourself you can use this simple equation. The variables are (d) for your desired grade, (c) for your current grade, and (f) for the amount your final exam is worth.\nThe equation is:',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '(d - c * (1 - f)) / f',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                              fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Text(
                        'You can try the equation out with the built in calculator that comes with this app!',
                        style: TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                      )
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
