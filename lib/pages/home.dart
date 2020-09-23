import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> names = [
    'Final Grade',
    'Semester GPA',
    'Cumulative GPA',
    'Basic Calculator'
  ];
  List<String> descriptions = [
    'Calculates the grade you will need to recieve on your final exam in order to get your desired grade.',
    'Calculates your current semester\'s GPA. This is based on an unweighted grading system.',
    'Calculates your cumulative GPA based on your current GPA, cumulative GPA, and number of semesters completed.',
    'A basic calculator with addition, subtraction, multiplication, and division.'
  ];
  List<String> destinations = ['/fgrade', '/sgpa', '/ugpa',  '/calc'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[700],
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Colors.blue[700],
            elevation: 0,
            //title: Text('Title'),
            centerTitle: true,
          ),
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
                          topRight: Radius.circular(40),
                          topLeft: Radius.circular(40),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                    ),
                    child: SizedBox(
                      height: 100,
                      child: Center(
                        child: Text('Finals Week',
                            style: TextStyle(
                              fontSize: 38,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    )),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Calculators', style: TextStyle(fontSize: 26), textAlign: TextAlign.center,),
                  ),
                ),
                Container(
                  height: 200,
                  padding: EdgeInsets.fromLTRB(4, 0, 4, 0),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          padding: EdgeInsets.fromLTRB(0, 8, 8, 8),
                          child: RaisedButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, '${destinations[index]}');
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            color: Colors.grey[300],
                            child: SizedBox(
                              width: 220,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '${names[index]}',
                                      style: TextStyle(
                                        fontSize: 20,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Text(
                                        '${descriptions[index]}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 18),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const Divider(),
                  ),
                ),
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Other', style: TextStyle(fontSize: 26), textAlign: TextAlign.center,),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    color: Colors.grey[300],
                    onPressed: (){
                      Navigator.pushNamed(context, '/stimer');
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: <Widget>[
                          Text(
                            'Study Timer',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Text(
                              'A tool that allows you to create a list of classes to study for. For each class, you can set a timer for the amount of time you wish to study.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.grey[700],
                                  fontSize: 18),
                            ),
                          )
                        ],
                      ),
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
                            'About',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ),
                        Text(
                          'I created this app because I wanted one place that combined tools from multiple other websites. Now all of those tools are at the tip of your fingers. This is my first app, so if you have any feedback or find any bugs please email me at: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'gcoxdev@gmail.com',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'To find information on updates and my newest apps\nfollow my instagram: ',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            '@gcoxdev',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Text(
                          'Good luck with all of your finals and exams. Thank you for downloading my app.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
