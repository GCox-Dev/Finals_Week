import 'dart:math';

import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String valA = '0';
  String valB = '0';
  String operator = '';
  String output = '0';
  double size = 70;

  double dp(double val, int places){
    double mod = pow(10.0, places);
    return ((val * mod).round().toDouble() / mod);
  }

  void process() {
    try {
      if (operator == ' + ') {
        if (valA.contains('.') || valB.contains('.')) {
          double result = double.parse(valA) + double.parse(valB);
          valA = result.toString();
        } else {
          int result = int.parse(valA) + int.parse(valB);
          valA = result.toString();
        }
      } else if (operator == ' - ') {
        if (valA.contains('.') || valB.contains('.')) {
          double result = double.parse(valA) - double.parse(valB);
          valA = result.toString();
        } else {
          int result = int.parse(valA) - int.parse(valB);
          valA = result.toString();
        }
      } else if (operator == ' x ') {
        if (valA.contains('.') || valB.contains('.')) {
          double result = double.parse(valA) * double.parse(valB);
          valA = result.toString();
        } else {
          int result = int.parse(valA) * int.parse(valB);
          valA = result.toString();
        }
      } else if (operator == ' ÷ ') {
        double result = double.parse(valA) / double.parse(valB);
        valA = result.toString();
      }
      valA = dp(double.parse(valA), 8).toString();
      valB = '0';
      operator = '';
      reouput();
    } catch (e) {
    }
  }

  void reouput() {
    if (operator == '') {
      output = '$valA';
    } else if (valB == '0') {
      output = '$valA$operator';
    } else {
      output = '$valA$operator$valB';
    }
  }

  Widget numberButton(int number) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        height: size,
        width: size,
        child: FlatButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Center(child: Text('$number', style: TextStyle(fontSize: 20))),
          color: Colors.grey[350],
          onPressed: () {
            setState(() {
              String val = '$number';
              if (operator == '')
                valA = valA == '0' ? val : valA + val;
              else
                valB = valB == '0' ? val : valB + val;
              reouput();
            });
          },
        ),
      ),
    );
  }

  Widget operationButton(String label) {
    if (label != 'delete' && label != '=') {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: size,
          width: size,
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(label,
                    style: TextStyle(
                        fontSize: 20,
                        color: label != '.' ? Colors.blue : Colors.black))),
            color: Colors.grey[350],
            onPressed: () {
              setState(() {
                if (label == '.') {
                  if (!valA.contains('.') && operator == '')
                    valA = valA + '.';
                  else if (!valB.contains('.')) valB = valB + '.';
                } else if (label != 'x²' && label != '±' && valA != '0') {
                  if (valB == '0')
                    operator = ' $label ';
                  else {
                    process();
                    operator = ' $label ';
                  }
                } else if (label == 'x²' && (valA != '0' && valA != '0.' && valB == '0')) {
                  if (valA.contains('.')) {
                    double result = double.parse(valA) * double.parse(valA);
                    valA = result.toString();
                  } else {
                    int result = int.parse(valA) * int.parse(valA);
                    valA = result.toString();
                  }
                } else if (label == '±') {
                  if (valB != '0') valB = (valB.contains('-') ? valB.substring(1) : '-' + valB);
                  else if (valA != '0' && operator == '') valA = (valA.contains('-') ? valA.substring(1) : '-' + valA);
                }
                reouput();
              });
            },
          ),
        ),
      );
    } else if (label == 'delete') {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: size,
          width: size,
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Icon(
              Icons.backspace,
              color: Colors.blue,
            )),
            color: Colors.grey[350],
            onPressed: () {
              setState(() {
                if (valA != '0') {
                  if (operator != '') {
                    if (valB == '0') {
                      operator = '';
                    } else {
                      if (valB.length == 2 && valB.contains('-'))
                        valB = '0';
                      else if (valB.length > 1 && !valB.contains('-'))
                        valB = valB.substring(0, valB.length - 1);
                      else
                        valB = '0';
                    }
                  } else {
                    if (valA.length == 2 && valA.contains('-'))
                      valA = '0';
                    else if (valA.length > 1)
                      valA = valA.substring(0, valA.length - 1);
                    else
                      valA = '0';
                  }
                }
                reouput();
              });
            },
            onLongPress: () {
              setState(() {
                valA = '0';
                valB = '0';
                operator = '';
                output = '';
                reouput();
              });
            },
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(2.0),
        child: Container(
          height: size,
          width: size * 2 + 4,
          child: FlatButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Center(
                child: Text(label,
                    style: TextStyle(fontSize: 20, color: Colors.blue))),
            color: Colors.grey[350],
            onPressed: () {
              setState(() {
                process();
              });
            },
          ),
        ),
      );
    }
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
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40), topRight: Radius.circular(40))),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: <Widget>[
              Card(
                  color: Colors.grey[300],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: SizedBox(
                      height: 100,
                      child: Center(
                        child: Text('Calculator',
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold)),
                      ))),
              Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Text(
                            output,
                            style: TextStyle(fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.grey[300],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          operationButton('delete'),
                          operationButton('±'),
                          operationButton('x²'),
                          operationButton('+')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          numberButton(7),
                          numberButton(8),
                          numberButton(9),
                          operationButton('-')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          numberButton(4),
                          numberButton(5),
                          numberButton(6),
                          operationButton('x')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          numberButton(1),
                          numberButton(2),
                          numberButton(3),
                          operationButton('÷')
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          operationButton('.'),
                          numberButton(0),
                          operationButton('=')
                        ],
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
