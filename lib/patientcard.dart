import 'dart:ui';

import 'package:RESP2/testResults.dart';
import 'package:RESP2/xrayResults.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'diagnoseButton.dart';
import 'package:path/path.dart';
import 'xrayResults.dart';
import 'package:condition/condition.dart';
//import 'package:excel/excel.dart';
// Uncomment lines 7 and 10 to view the visual layout at runtime.
// import 'package:flutter/rendering.dart' show debugPaintSizeEnabled;

void main() {
  // debugPaintSizeEnabled = true;
  //get variables

  runApp(PatientCard());
}

//REPLACE BOOLS BELOW WITH LOGIC
bool tobaccoUser = true;
//some patients have no provocating factors listed:
bool provocatingFactors = true;
//some patients only have one or two histories listed:
bool history2 = true;
bool history3 = true;

int caseIDint = 200;
String caseID = caseIDint.toString();
String demographics = "female, 25";
String chartTitle = "Patient " + caseID;

class PatientCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
          Text("[x] days"),
        ],
      ),
    ); //onset of symptoms

    //---------------PATIENT'S SYMPTOMS-----------------------------------------
    Widget symptoms = Text(
      "symptoms list",
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
    Widget history = Text(
      "history list",
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
      child: Column(
        //WHOLE COLUMN FOR TAB
        mainAxisAlignment: MainAxisAlignment.start, //space between??
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

    //---------VITALS--------------------------------------
    Widget vitals = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.only(bottom: 8, top: 8, left: 8, right: 2),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Temperature (C):',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Respiratory Rate (breaths/min):',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Heart Rate (beats/min):',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Blood Pressure (mm Hg):',
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
          padding: const EdgeInsets.only(bottom: 8, top: 8, left: 2, right: 8),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'temp',
                  ),
                  Text(
                    'resp rate',
                  ),
                  Text(
                    'heart rate',
                  ),
                  Text(
                    'blood pressure',
                  ),
                  Text(
                    'oxygen sat',
                  ),
                  Text(
                    'oxygen received',
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    //---------VITALS LIST--------------------------------------
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
    //---------PHYSICAL RESULTS--------------------------------------
    Widget physical = Text(
      "phys exam",
    );
    //---------PHYSICAL EXAM--------------------------------------
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
          physical,
        ],
      ),
    );
    //---------VITALS AND PHYSICAL EXAM TAB--------------------------------------
    Widget vitalsPhysicalTab = Container(
      margin: const EdgeInsets.only(left: 5.0, right: 5.0),
      padding: const EdgeInsets.all(12),
      child: Column(
        //WHOLE COLUMN FOR TAB
        mainAxisAlignment: MainAxisAlignment.start, //space between??
        children: [
          Row(
            children: [Expanded(child: vitalsList)],
          ),
          //onset,
          Padding(padding: EdgeInsets.only(top: 12.0)),
          Row(
            children: [Expanded(child: physicalExam)],
          ),
        ], //BOXES OF TAB
      ),
    );

    //---------NARRATIVE TEXT--------------------------------------
    Widget narrative = Text("narrative text");
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
      child: Column(
        //WHOLE COLUMN FOR TAB
        mainAxisAlignment: MainAxisAlignment.start, //space between??
        children: [
          Row(
            children: [Expanded(child: narrativeBox)],
          ),
        ], //BOXES OF TAB
      ),
    );

    Color color = Theme.of(context).primaryColor;

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

    //-----------------------PATIENT CARD FINAL SETUP------------------------
    return MaterialApp(
      title: chartTitle,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
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
            title: Text(chartTitle),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              vitalsPhysicalTab,
              symptomsHistoryTab,
              narrativeTab,
            ],
          ),
        ),
      ),
    );
  }

  //-------------------------HELPER FUNCTIONS------------------------------------
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
