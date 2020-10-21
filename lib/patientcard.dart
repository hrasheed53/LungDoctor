import 'package:RESP2/testResults.dart';
import 'package:RESP2/xrayResults.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'diagnoseButton.dart';
import 'package:path/path.dart';
//import 'package:excel/excel.dart';
// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  //get variables

  runApp(PatientCard());
}

class PatientCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget demographics = Container(
      margin: const EdgeInsets.only(left: 12.0, right: 12.0),
      padding: const EdgeInsets.all(12),
      //demographics and vital columns:
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0x99f5e6bc),
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            //demographics column
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 8, top: 8, left: 8, right: 2),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Age:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Gender:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Race:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 8, top: 8, left: 2, right: 8),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '74',
                          ),
                          Text(
                            'Male',
                          ),
                          Text(
                            'White',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: const Color(0x99f5e6bc),
              border: Border.all(color: Colors.black38, width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 8, top: 8, left: 8, right: 2),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Temperature:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Respiratory Rate:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Blood Pressure:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'O\u2082 Saturation:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'O\u2082 Received:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      bottom: 8, top: 8, left: 2, right: 8),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '38.4 C',
                          ),
                          Text(
                            '121 bpm',
                          ),
                          Text(
                            '104/53',
                          ),
                          Text(
                            '91%',
                          ),
                          Text(
                            '4 L/min',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    Color color = Theme.of(context).primaryColor;

    Widget patientHistory = Container(
      margin: const EdgeInsets.only(left: 12.0, right: 12.0),
      decoration: BoxDecoration(
        color: const Color(0x99f5e6bc),
        border: Border.all(color: Colors.black38, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding:
                const EdgeInsets.only(bottom: 8, top: 8, left: 8, right: 2),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Past History 1:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Past History 2:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Past History 3:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Tobacco Use:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Onset of Symptoms:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Duration of Symptoms:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Provocating Factors:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Description of Symptoms:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Severity of Symptoms:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Relieving Factors:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding:
                const EdgeInsets.only(bottom: 8, top: 8, left: 2, right: 8),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'heart failure',
                    ),
                    Text(
                      'coronary artery disease',
                    ),
                    Text(
                      'COPD',
                    ),
                    Text(
                      'current',
                    ),
                    Text(
                      '3 days',
                    ),
                    Text(
                      'constant',
                    ),
                    Text(
                      'exertion',
                    ),
                    Text(
                      'chest heaviness',
                    ),
                    Text(
                      'severe',
                    ),
                    Text(
                      'none',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );

//---------------------------------------------------------------------------------
//-----------------------X-RAYS AND TESTS BUTTONS----------------------------------
    Widget buttonSection = Container(
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
//-----------------------END ORDER TESTS BUTTON----------------------------------
    );

//-----------------------BUTTON FOR DIAGNOSING----------------------------------
    Widget diagnoseButton = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              diagnoseBttn(context);
            },
            child: _buildDiagnoseButtonColumn(
                const Color(0xffe34646), Icons.local_pharmacy, 'DIAGNOSE'),
          ),
        ],
      ),
    );
//-----------------------END BUTTON FOR DIAGNOSING----------------------------------

    return MaterialApp(
      title: 'Patient Chart',
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blue[600],
          title: Text('Patient Chart'),
        ),
        body: ListView(
          children: [
            Padding(padding: EdgeInsets.only(top: 16.0)),
            demographics,
            Padding(padding: EdgeInsets.only(top: 12.0)),
            patientHistory,
            Padding(padding: EdgeInsets.only(top: 20.0)),
            buttonSection,
            Padding(padding: EdgeInsets.only(top: 16.0)),
            diagnoseButton
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey, width: 2),
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

  Column _buildDiagnoseButtonColumn(Color color, IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
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
        context, MaterialPageRoute(builder: (context) => Diagnose()));
  }
}
