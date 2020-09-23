import 'dart:math';

import 'package:flutter/material.dart';

class CumulativeGPA extends StatefulWidget {
  @override
  _CumulativeGPAState createState() => _CumulativeGPAState();
}

class _CumulativeGPAState extends State<CumulativeGPA> {
  final sgpa = TextEditingController();
  final cgpa = TextEditingController();
  final numsem = TextEditingController();

  double cumGpa = 0;
  double semGpa = 0;
  double numSem = 0;
  double gpa = 0.0;
  String message = 'Not enough information';

  double dp(double val, int places){
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  void calculateGPA() {
    double result = 0;
    double percent = numSem / (numSem + 1);
    result = (cumGpa * percent) + (semGpa * (1 - percent));
    gpa = dp(result, 2);
    if (gpa >= 3.5)
      message = 'Nice job, that\'s an amazing GPA!';
    else if (gpa >= 3.0)
      message = 'Your doing great, you got this!';
    else
      message = 'Keep going, you can do this!';
  }

  @override
  void dispose() {
    super.dispose();
    sgpa.dispose();
    cgpa.dispose();
    numsem.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue[700],
        ),
        backgroundColor: Colors.blue[700],
        body: Container(
            height: 700,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40)),
                color: Colors.grey[200]),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child:
                  ListView(physics: BouncingScrollPhysics(), children: <Widget>[
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
                        child: Text('Cumulative GPA Calculator',
                            style: TextStyle(
                                fontSize: 26, fontWeight: FontWeight.bold)),
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
                                  'Your Semester GPA',
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
                                  controller: sgpa,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'ex: 3.91',
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
                                  'Your Cumulative GPA',
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
                                  controller: cgpa,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'ex: 3.44',
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
                                  'Number of Semesters',
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
                                  controller: numsem,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'ex: 5',
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
                                  if (sgpa.text != '' &&
                                      cgpa.text != '' &&
                                      numsem.text != '' &&
                                      sgpa.text != '0' &&
                                      cgpa.text != '0' &&
                                      numsem.text != '0') {
                                    cumGpa =
                                        double.parse(cgpa.text);
                                    semGpa =
                                        double.parse(sgpa.text);
                                    numSem =
                                        double.parse(numsem.text);
                                    calculateGPA();
                                  } else {
                                    gpa = 0.0;
                                    message =
                                        'Not enough or incorrect information given. Please provide more information.';
                                  }
                                });
                              },
                              child: Text(
                                'Calculate GPA',
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
                              'Your Cumulative GPA is $gpa%',
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
                              'I would like to clairify some things. This GPA calculator asumes that every semester is worth the same amount of credits. The semester GPA input is for the GPA of your current semester, you can find this out with the semester GPA calculator inside this app. The cumulative GPA input is for your cumulative GPA prior to your current semester, you can find this number on your high school transcript. The number of semesters input is for the number of semesters completed prior to your current semester.',
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    )
              ]),
            )));
  }
}
