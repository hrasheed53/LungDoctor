import 'dart:ui';
import 'package:RESP2/parsePatientData.dart';
import 'package:RESP2/testResults.dart';
import 'package:RESP2/xrayResults.dart';
import 'package:flutter/material.dart';
import 'package:RESP2/physicalExam.dart';
import 'package:flutter/rendering.dart';
import 'diagnoseButton.dart';
import 'xrayResults.dart';
import 'package:condition/condition.dart';
import 'dart:math';

class PatientCard extends StatefulWidget {
  PatientCard({Key key, this.patientsLeft}) : super(key: key);
  final int patientsLeft;

  @override
  _PatientCardState createState() => _PatientCardState();
}

//Contains all the logic for the patient card user interface. Now with comment
//headers for easier understanding.

String baseURL = 'https://diagnostic-gamification-api.herokuapp.com/v1/cases/';

//REPLACE BOOLS BELOW WITH LOGIC
//some patients have no provocating factors listed:
bool provocatingFactors = true;
//some patients only have one or two histories listed:
bool history2 = true;
bool history3 = true;

class _PatientCardState extends State<PatientCard> {
  Future<PatientChart> futureChart;

  //vars for pulling random case:
  Random random = new Random();
  int randomCase;
  String url;

  int caseID;
  //data to be passed on to diagnoseButton:
  int remaining;
  String redHerring;
  String expertAdvice;
  String diagnosis;
  String difficultyLevel;

  //data to be passed on to testResults:
  String wbc;
  String hemo;
  String hema;
  String plat;
  String na;
  String cl;
  String k;
  String c;
  String bun;
  String creat;
  String glucose;
  String bnp;
  String abgph;
  String abgpo;
  String abgpo2;
  String lactate;

  //for physical exam:
  String head;
  String neck;
  String heart;
  String lungs;
  String ab;
  String ext;
  String skin;

  //For Beta, provided 19 available cases with non-sequential case IDs
  //  (had to hardcode the IDs)
  List<int> availableCaseIDs = [
    208,
    209,
    210,
    211,
    212,
    213,
    216,
    222,
    224,
    228,
    231,
    233,
    234,
    236,
    238,
    241,
    243,
    246,
    247
  ];

  //initialize state and get (future) chart data
  //  (this is called every time the app navs to this screen):
  @override
  void initState() {
    super.initState();
    //choose a random case ID to pull from:
    randomCase = random.nextInt(19);
    url = baseURL + availableCaseIDs[randomCase].toString();
    print(url);
    //pull Future item containing case data:
    futureChart = getPatientChart(url);
  }

  //where the widget building happens:
  @override
  Widget build(BuildContext context) {
    //decrement no. patients left to examine:
    remaining = widget.patientsLeft - 1;
    //ensconced the FutureBuilder, which creates the entire patient card UI,
    //in a big container below. this is so we can access the API data ONCE
    //instead of repeatedly calling futurebuilder in every
    //widget that requires data from the API, which is slow.
    //(FutureBuilder required since pulling from the API is asynchronous)

    return Container(
      child: new FutureBuilder<PatientChart>(
        future: futureChart,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //
            //update variables to pass to the buttons (diagnose, order tests, order x-ray):
            //  diagnose
            redHerring = snapshot.data.redHerrings;
            expertAdvice = snapshot.data.expertComments;
            diagnosis = snapshot.data.diagnosis;
            difficultyLevel = snapshot.data.difficulty;
            //  order tests
            wbc = snapshot.data.bloodWBC.toString();
            hemo = snapshot.data.bloodHemoglobin.toString();
            hema = snapshot.data.bloodHemacrotit.toString();
            plat = snapshot.data.bloodPlatelets.toString();
            na = snapshot.data.bloodSodium.toString();
            cl = snapshot.data.bloodChloride.toString();
            k = snapshot.data.bloodPotassium.toString();
            c = snapshot.data.bloodBicarbonate.toString();
            bun = snapshot.data.bloodBUN.toString();
            creat = snapshot.data.bloodCreatinine.toString();
            glucose = snapshot.data.bloodGlucose.toString();
            bnp = snapshot.data.bloodBNP.toString();
            abgph = snapshot.data.bloodABGph.toString();
            abgpo = snapshot.data.bloodABGpo2.toString();
            abgpo2 = snapshot.data.bloodABGpco2.toString();
            lactate = snapshot.data.bloodLactate.toString();

            //  xray
            caseID = snapshot.data.caseID;

            //  physical exam
            head = snapshot.data.examHead;
            neck = snapshot.data.examNeck;
            if (neck == null) {
              neck = "blank";
            }
            heart = snapshot.data.examHeart;
            lungs = snapshot.data.examLungs;
            ab = snapshot.data.examAbdomen;
            ext = snapshot.data.examExtremeties;
            skin = snapshot.data.examSkin;

            //BEGIN WIDGET CREATION:
            //---------------SYMPTOM ONSET-----------------------------------------
            Widget onset = Container(
              padding: const EdgeInsets.only(bottom: 6, top: 6),
              margin: const EdgeInsets.only(left: 12, right: 12),
              decoration: BoxDecoration(
                color: const Color(0x99f5e6bc),
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Onset of Symptoms: ",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(snapshot.data.symptomOnset,
                      style: TextStyle(fontSize: 18)),
                ],
              ),
            ); //onset of symptoms

            //some patients do not have provocating factors listed:
            bool _checkProvocating() {
              if (snapshot.data.provocatingFactors == "") {
                return false;
              }
              return true;
            }

            Widget _checkSymptoms() {
              return Container(
                child: Conditioned(
                  cases: [
                    Case(
                      //no provocating factors listed:
                      _checkProvocating() == false,
                      builder: () => Container(
                        padding:
                            const EdgeInsets.only(top: 4, left: 9, right: 9),
                        child: Text(snapshot.data.symptomDescription,
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
                    Case(
                      //provocating factors are listed:
                      _checkProvocating() == true,
                      builder: () => Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                top: 4, left: 9, right: 9),
                            child: Text(
                                "Provocating factors: " +
                                    snapshot.data.provocatingFactors,
                                style: TextStyle(fontSize: 16)),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 4, left: 9, right: 9),
                            child: Text(snapshot.data.symptomDescription,
                                style: TextStyle(fontSize: 16)),
                          ),
                        ],
                      ),
                    ),
                  ],
                  defaultBuilder: () => Icon(Icons.wb_sunny_rounded),
                ),
              );
            }

            //---------------PATIENT'S SYMPTOMS-----------------------------------------
            /* Widget symptoms = Container(
              padding: const EdgeInsets.only(top: 4, left: 9, right: 9),
              child: Text(snapshot.data.symptomDescription,
                  style: TextStyle(fontSize: 16)),
            );*/

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
                    "Symptoms:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  _checkSymptoms(),
                ],
              ),
            ); //symptoms list

            //------------PATIENT'S HISTORY-----------------------------------------
            //some patients don't have pastmedicalhistory2 field, check for that:
            bool _history2() {
              if (snapshot.data.pastMedHistory2 == "") {
                return false;
              }
              return true;
            }

            //some patients don't have pastmedicalhistory3 field, check for that:
            bool _history3() {
              if (snapshot.data.pastMedHistory3 == "") {
                return false;
              }
              return true;
            }

            //build history widget based on
            Widget _checkHistory() {
              return Container(
                child: Conditioned(
                  cases: [
                    Case(
                      //if history2 exists, check if history3 exists:
                      _history2() == true,
                      builder: () => Conditioned(
                        cases: [
                          Case(
                            //history3 exists, print all 3 histories
                            _history3() == true,
                            builder: () => Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 9, right: 9),
                                  child: Text(
                                    "- " + snapshot.data.pastMedHistory1,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 9, right: 9),
                                  child: Text(
                                    "- " + snapshot.data.pastMedHistory2,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 9, right: 9),
                                  child: Text(
                                    "- " + snapshot.data.pastMedHistory3,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Case(
                            //history3 doesn't exist, print only history 1 and 2
                            _history3() == false,
                            builder: () => Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 9, right: 9),
                                  child: Text(
                                    "- " + snapshot.data.pastMedHistory1,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 4, left: 9, right: 9),
                                  child: Text(
                                    "- " + snapshot.data.pastMedHistory2,
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                        defaultBuilder: () => Icon(Icons.wb_sunny_rounded),
                      ),
                    ),
                    Case(
                      //if history2 doesn't exist, history3 doesn't either:
                      _history2() == false,
                      builder: () => Container(
                        padding:
                            const EdgeInsets.only(top: 4, left: 9, right: 9),
                        child: Text(
                          "- " + snapshot.data.pastMedHistory1,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                  defaultBuilder: () => Icon(Icons.wb_sunny_rounded),
                ),
              );
            }

            /*Widget history = Container(
                padding: const EdgeInsets.only(top: 4, left: 9, right: 9),
                child: Text(
                  "- " + snapshot.data.pastMedHistory1,
                  style: TextStyle(fontSize: 16),
                ));*/

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
                    "History:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    textAlign: TextAlign.center,
                  ),
                  _checkHistory(),
                ],
              ),
            );

            bool _checkSmoker() {
              if (snapshot.data.tobaccoUse != "never") {
                return true;
              } else {
                return false;
              }
            }

            //------------TOBACCO USE -- CHECK BOXES-----------------------------------------
            Widget _tobaccoBoxes() {
              return Container(
                  child: Conditioned(
                cases: [
                  Case(
                    //IF SMOKER
                    _checkSmoker() == true,
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
                    _checkSmoker() == false,
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
                children: [
                  onset,
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
                  padding: const EdgeInsets.only(
                      bottom: 8, top: 8, left: 8, right: 2),
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
                          Text(snapshot.data.temperature.toString()),
                          Padding(padding: EdgeInsets.only(top: 9.0)),
                          Text(
                            'Respiratory Rate (breaths/min)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(snapshot.data.respiratoryRate.toString()),
                          Padding(padding: EdgeInsets.only(top: 9.0)),
                          Text(
                            'Heart Rate (beats/min)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(snapshot.data.heartRate.toString()),
                          Padding(padding: EdgeInsets.only(top: 9.0)),
                          Text(
                            'Blood Pressure (mm Hg)',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(snapshot.data.bloodPressure),
                          Padding(padding: EdgeInsets.only(top: 9.0)),
                          Text(
                            'O\u2082 Saturation',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(snapshot.data.oxygenSat),
                          Padding(padding: EdgeInsets.only(top: 9.0)),
                          Text(
                            'O\u2082 Received',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(snapshot.data.oxygenAmount),
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
            Widget physical = Container(
                padding: const EdgeInsets.only(left: 9, right: 9),
                child: Text(snapshot.data.examGeneral));

            //        button to "conduct" physical exam
            //------------------------------------------------------
            Widget conductPhysical = Container(
              child: Column(children: [
                GestureDetector(
                    onTap: () {
                      viewExamResults(context);
                    },
                    child: _buildPhysicalExamButton(
                        Theme.of(context).primaryColor,
                        Icons.person,
                        'Conduct Exam')),
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
                ], //BOXES OF TAB
              ),
            );
//=============================================================================
//                       Narrative tab
//=============================================================================
            //---------NARRATIVE TEXT--------------------------------------
            Widget narrative = Container(
                padding: const EdgeInsets.only(top: 6, left: 12, right: 12),
                child: Text(snapshot.data.narratives));
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
                        child: _buildButtonColumn(
                            color, Icons.wb_sunny, 'ORDER X-RAYS'),
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
                            const Color(0xffe34646),
                            Icons.local_pharmacy,
                            'DIAGNOSE'),
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
                    title: Text("Patient " +
                        snapshot.data.caseID.toString() +
                        ": " +
                        snapshot.data.gender +
                        ", age " +
                        snapshot.data.age.toString()),
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
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}", style: TextStyle(fontSize: 4));
          } else {
            //show loading spinner when pulling data
            return Scaffold(
              body: Center(
                child: Container(
                  width: 40,
                  height: 40,
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          }
        },
      ),
    );

    //                    Symptoms, History, and Tobacco Use tab
    //=============================================================================
    //---------------ONSET OF SYMPTOMS-----------------------------------
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

  Future viewExamResults(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Physical(
                head: head,
                neck: neck,
                heart: heart,
                lungs: lungs,
                ab: ab,
                ext: ext,
                skin: skin)));
  }

  Future viewTestResults(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Tests(
                wbc: wbc,
                hemo: hemo,
                hema: hema,
                plat: plat,
                na: na,
                cl: cl,
                k: k,
                c: c,
                bun: bun,
                creat: creat,
                glucose: glucose,
                bnp: bnp,
                abgph: abgph,
                abgpo: abgpo,
                abgpo2: abgpo2,
                lactate: lactate)));
  }

  Future viewXrays(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Xrays(caseID: caseID)));
  }

  Future diagnoseBttn(context) async {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Diagnose(
            patientsLeft: remaining,
            difficulty: difficultyLevel,
            answer: diagnosis,
            rH: redHerring,
            eA: expertAdvice),
      ),
    );
  }
}
