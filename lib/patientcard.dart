import 'dart:ui';
import 'package:RESP2/parsePatientData.dart';
import 'package:RESP2/testResults.dart';
import 'package:RESP2/xrayResults.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'diagnoseButton.dart';
import 'package:path/path.dart';
import 'xrayResults.dart';
import 'package:condition/condition.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class PatientCard extends StatefulWidget {
  PatientCard({Key key, this.patientsLeft}) : super(key: key);
  final int patientsLeft;

  @override
  _PatientCardState createState() => _PatientCardState();
}

//Contains all the logic for the patient card user interface. Now with comment
//headers for easier understanding.

String url = 'https://diagnostic-gamification-api.herokuapp.com/v1/cases/208';

//REPLACE BOOLS BELOW WITH LOGIC
bool tobaccoUser = true;
//some patients have no provocating factors listed:
bool provocatingFactors = true;
//some patients only have one or two histories listed:
bool history2 = true;
bool history3 = true;

int caseIDint = 208;
String caseID = caseIDint.toString();
String demographics = ": female, 25";
String chartTitle = caseID + "Patient " + caseID + demographics;

//PatientChart chart;

class _PatientCardState extends State<PatientCard> {
  int remaining;
  Future<PatientChart> futureChart;

  @override
  void initState() {
    super.initState();
    futureChart = getPatientChart(url);
  }

  @override
  Widget build(BuildContext context) {
    //decrement no. patients left to "examine"
    remaining = widget.patientsLeft - 1;
/*
    PatientChart chart = new FutureBuilder<PatientChart>(
      future: futureChart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return snapshot.data;
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(fontSize: 4));
        } else {
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        }
      },
    );
  
    futureChart.then((result) {
      setState(() {
        chart = result;
      });
    });*/
    //print(chart.age);
//                    Symptoms, History, and Tobacco Use tab
//=============================================================================
    //---------------ONSET OF SYMPTOMS-----------------------------------
    Widget onset = Container(
      padding: const EdgeInsets.only(bottom: 6, top: 6),
      decoration: BoxDecoration(
        color: const Color(0x99f5e6bc),
        border: Border.all(color: Colors.black38, width: 1),
        //borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Onset of Symptoms: ",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          //Text("[onset :()]"),
          FutureBuilder<PatientChart>(
            future: futureChart,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(snapshot.data.symptomOnset);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}", style: TextStyle(fontSize: 4));
              } else {
                // By default, show a loading spinner.
                return CircularProgressIndicator();
              }
            },
          ),
        ],
      ),
    ); //onset of symptoms

    //---------------PATIENT'S SYMPTOMS-----------------------------------------
    Widget symptoms = FutureBuilder<PatientChart>(
      future: futureChart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.symptomDescription);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(fontSize: 4));
        } else {
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        }
      },
    );

    //--------------SYMPTOMS LIST BOX-----------------------------------------
    Widget symptomsList = Container(
      padding: const EdgeInsets.only(bottom: 6, top: 6),
      decoration: BoxDecoration(
        color: const Color(0x99f5e6bc),
        border: Border.all(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Symptoms",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          symptoms,
        ],
      ),
    ); //symptoms list

    //------------PATIENT'S HISTORY-----------------------------------------
    Widget history = FutureBuilder<PatientChart>(
      future: futureChart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.pastMedHistory1);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(fontSize: 4));
        } else {
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        }
      },
    );

    //------------HISTORY LIST BOX-----------------------------------------
    Widget historyList = Container(
      padding: const EdgeInsets.only(bottom: 6, top: 6),
      decoration: BoxDecoration(
        color: const Color(0x99f5e6bc),
        border: Border.all(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "History",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          history,
        ],
      ),
    );

    //------------TOBACCO USE -- CHECK BOXES-----------------------------------------
    Widget _tobaccoBoxes() {
      return Container(
          child: Conditioned(
        cases: [
          Case(
            //IF SMOKER
            tobaccoUser = true,
            builder: () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_box),
                    Text("Yes"),
                  ],
                ),
                Padding(padding: EdgeInsets.only(right: 12.0)),
                Row(
                  children: [
                    Icon(Icons.check_box_outline_blank),
                    Text("No"),
                  ],
                ),
              ],
            ),
          ),
          Case(
            //IF NON-SMOKER
            tobaccoUser = false,
            builder: () => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.check_box_outline_blank),
                    Text("Yes"),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.check_box),
                    Text("No"),
                  ],
                ),
              ],
            ),
          ),
        ],
        defaultBuilder: () => Icon(Icons.wb_sunny_rounded),
      ));
    }

    //------------TOBACCO USE-----------------------------------------
    Widget tobaccoUse = Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: const Color(0x99f5e6bc),
        border: Border.all(color: Colors.black38, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Tobacco use?",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          _tobaccoBoxes(),
        ],
      ),
    );

    //-----------TAB FOR SYMPTOMS, HISTORY, AND TOBACCO-----------------------------------------
    Widget symptomsHistoryTab = Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: const EdgeInsets.all(12),
      child: ListView(
        //WHOLE COLUMN FOR TAB
        //mainAxisAlignment: MainAxisAlignment.start, //space between??
        children: [
          Row(
            children: [Expanded(child: onset)],
          ),
          //onset,
          Padding(padding: EdgeInsets.only(top: 12.0)),
          Row(
            children: [Expanded(child: symptomsList)],
          ),
          Padding(padding: EdgeInsets.only(top: 12.0)),
          Row(
            children: [Expanded(child: historyList)],
          ),
          Padding(padding: EdgeInsets.only(top: 12.0)),
          Row(
            children: [Expanded(child: tobaccoUse)],
          ),
        ], //BOXES OF TAB
      ),
    );
//=============================================================================

//                    Vitals and Physical Exam tab
//=============================================================================
    //               list of vitals
    //---------------------------------------------------------
    Widget vitals = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8, top: 8, left: 8, right: 2),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Temperature (\u2103)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder<PatientChart>(
                    future: futureChart,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.temperature.toString());
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}",
                            style: TextStyle(fontSize: 4));
                      } else {
                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 9.0)),
                  Text(
                    'Respiratory Rate (breaths/min)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder<PatientChart>(
                    future: futureChart,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.respiratoryRate.toString());
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}",
                            style: TextStyle(fontSize: 4));
                      } else {
                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 9.0)),
                  Text(
                    'Heart Rate (beats/min)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder<PatientChart>(
                    future: futureChart,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.heartRate.toString());
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}",
                            style: TextStyle(fontSize: 4));
                      } else {
                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 9.0)),
                  Text(
                    'Blood Pressure (mm Hg)',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder<PatientChart>(
                    future: futureChart,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.bloodPressure);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}",
                            style: TextStyle(fontSize: 4));
                      } else {
                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 9.0)),
                  Text(
                    'O\u2082 Saturation',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder<PatientChart>(
                    future: futureChart,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.oxygenSat);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}",
                            style: TextStyle(fontSize: 4));
                      } else {
                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                  Padding(padding: EdgeInsets.only(top: 9.0)),
                  Text(
                    'O\u2082 Received',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  FutureBuilder<PatientChart>(
                    future: futureChart,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Text(snapshot.data.oxygenAmount);
                      } else if (snapshot.hasError) {
                        return Text("${snapshot.error}",
                            style: TextStyle(fontSize: 4));
                      } else {
                        // By default, show a loading spinner.
                        return CircularProgressIndicator();
                      }
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );

    //             title and vitals widgets
    //-------------------------------------------------------
    Widget vitalsList = Container(
      padding: const EdgeInsets.only(bottom: 6, top: 6),
      decoration: BoxDecoration(
        color: const Color(0x99f5e6bc),
        border: Border.all(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Vitals",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          vitals,
        ],
      ),
    );

    //         general results from the physical
    //--------------------------------------------------------------
    Widget physical = FutureBuilder<PatientChart>(
      future: futureChart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.examGeneral,
              style: TextStyle(fontSize: 16));
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(fontSize: 4));
        } else {
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        }
      },
    );

    //        button to "conduct" physical exam
    //------------------------------------------------------
    Widget conductPhysical = Container(
      child: Column(children: [
        GestureDetector(
            onTap: () {
              viewXrays(context);
            },
            child: _buildPhysicalExamButton(
                Theme.of(context).primaryColor, Icons.person, 'Conduct Exam')),
      ]),
    );

    //               box with physical exam button
    //-----------------------------------------------------------
    Widget physicalExam = Container(
      padding: const EdgeInsets.only(bottom: 6, top: 6),
      decoration: BoxDecoration(
        color: const Color(0x99f5e6bc),
        border: Border.all(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Physical Exam",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          Padding(padding: EdgeInsets.only(top: 6.0)),
          physical,
          Padding(padding: EdgeInsets.only(top: 6.0)),
          conductPhysical,
        ],
      ),
    );

    //            vitals and physical exam TAB
    //-----------------------------------------------------------
    Widget vitalsPhysicalTab = Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      padding: const EdgeInsets.all(12),
      child: ListView(
        //WHOLE COLUMN FOR TAB
        //mainAxisAlignment: MainAxisAlignment.start, //space between??
        children: [
          Row(
            children: [Expanded(child: vitalsList)],
          ),
          //onset,
          Padding(padding: EdgeInsets.only(top: 12.0)),
          Row(
            children: [Expanded(child: physicalExam)],
          ),
          Row(
            children: [Expanded(child: physicalExam)],
          ),
          Row(
            children: [Expanded(child: physicalExam)],
          ),
          Row(
            children: [Expanded(child: physicalExam)],
          ),
        ], //BOXES OF TAB
      ),
    );
//=============================================================================

//                       Narrative tab
//=============================================================================
    //---------NARRATIVE TEXT--------------------------------------
    //REPLACE REPLACE REPLACE
    Widget narrative = FutureBuilder<PatientChart>(
      future: futureChart,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.narratives);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}", style: TextStyle(fontSize: 4));
        } else {
          // By default, show a loading spinner.
          return CircularProgressIndicator();
        }
      },
    );
    //---------NARRATIVE BOX--------------------------------------
    Widget narrativeBox = Container(
      padding: const EdgeInsets.only(bottom: 6, top: 6),
      decoration: BoxDecoration(
        color: const Color(0x99f5e6bc),
        border: Border.all(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Patient Narrative",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          narrative,
        ],
      ),
    );
    //---------PATIENT NARRATIVE TAB--------------------------------------
    Widget narrativeTab = Container(
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: const EdgeInsets.all(12),
      child: ListView(
        //WHOLE COLUMN FOR TAB
        //mainAxisAlignment: MainAxisAlignment.start, //space between??
        children: [
          Row(
            children: [Expanded(child: narrativeBox)],
          ),
        ], //BOXES OF TAB
      ),
    );
//=============================================================================
    Color color = Theme.of(context).primaryColor;

//                    THREE MAIN BUTTONS SECTION
//------------------------------------------------------------------------------
    Widget bottomButtons = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
//-----------------------X-RAYS BUTTON----------------------------------
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  viewXrays(context);
                },
                child:
                    _buildButtonColumn(color, Icons.wb_sunny, 'ORDER X-RAYS'),
              ),
            ],
          ),
//-----------------------END X-RAYS BUTTON----------------------------------
//-----------------------DIAGNOSE BUTTON -- ALERT DIALOG----------------------------------
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        //title: Text('Ready?'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text(
                                  'Are you prepared to diagnose your patient?'),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('No, back to chart'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Let\'s diagnose!'),
                            onPressed: () {
                              Navigator.of(context).pop();
                              diagnoseBttn(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
                child: _buildDiagnoseButtonColumn(
                    const Color(0xffe34646), Icons.local_pharmacy, 'DIAGNOSE'),
              ),
            ],
          ),
//-----------------------END DIAGNOSE BUTTON----------------------------------
//-----------------------ORDER TESTS BUTTON----------------------------------
          Column(
            children: [
              GestureDetector(
                  onTap: () {
                    viewTestResults(context);
                  },
                  child: _buildButtonColumn(
                      color, Icons.folder_shared, 'ORDER TESTS')),
            ],
          )
        ],
      ),
    );

    //-----------------------PATIENT CARD FINAL SETUP------------------------
    return MaterialApp(
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: Text(chartTitle),
            /*leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed:
            ),*/
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Vitals and Physical",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Symptoms and History",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Tab(
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Patient Narrative",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              vitalsPhysicalTab,
              symptomsHistoryTab,
              narrativeTab,
            ],
          ),
          bottomNavigationBar: new Container(
              height: 100.0,
              color: color.withOpacity(0.2),
              padding: new EdgeInsets.only(top: 7.0),
              child: bottomButtons),
        ),
      ),
    );
  }

//----------------------------------------------------------------------
//                      HELPER FUNCTIONS
//----------------------------------------------------------------------
  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 62,
          padding: EdgeInsets.only(top: 8, left: 4, right: 4, bottom: 8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey, width: 2),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300].withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 18),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: color,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildDiagnoseButtonColumn(Color color, IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 100,
          padding: EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black54, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300].withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Column _buildPhysicalExamButton(Color color, IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black38, width: 1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[300].withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: color, size: 48),
              Container(
                margin: const EdgeInsets.only(top: 8),
                child: Text(
                  label,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future viewTestResults(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Tests()));
  }

  Future viewXrays(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Xrays()));
  }

  Future diagnoseBttn(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Diagnose(patientsLeft: remaining)));
  }
}
