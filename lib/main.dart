import 'package:flutter/material.dart';
import 'package:gradehub/pages/final_grade.dart';
import 'package:gradehub/pages/home.dart';
import 'package:gradehub/pages/current_gpa.dart';
import 'package:gradehub/pages/cumulative_gpa.dart';
import 'package:gradehub/pages/calculator.dart';
import 'package:gradehub/pages/studytool.dart';
import 'package:gradehub/services/Class.dart';
import 'package:gradehub/services/StudyObject.dart';

List<StudyObject> studyObj = [];
List<Class> classes = [];

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/' : (context) => Home(),
    '/sgpa' : (context) => CurrentGPA(classes),
    '/ugpa' : (context) => CumulativeGPA(),
    '/fgrade' : (context) => FinalGrade(),
    '/calc' : (context) => Calculator(),
    '/stimer' : (context) => StudyTimer(studyObj)

  },
));