import 'dart:ui';
import 'package:RESP2/parsePatientData.dart';
import 'package:RESP2/testResults.dart';
import 'package:RESP2/xrayResults.dart';
import 'package:flutter/material.dart';
import 'package:RESP2/physicalExam.dart';
import 'package:RESP2/gamePlay.dart';
import 'package:flutter/rendering.dart';
import 'diagnoseButton.dart';
import 'xrayResults.dart';
import 'package:condition/condition.dart';
import 'dart:math';
//import 'package:photo_view/photo_view.dart';

class PatientCard extends StatefulWidget {
  PatientCard({Key key, this.patientsLeft}) : super(key: key);
  final int patientsLeft;

  @override
  _PatientCardState createState() => _PatientCardState();
}

// Contains all the logic for the patient card user interface. Now with comment
// headers for easier understanding.

String baseURL = 'https://diagnostic-gamification-api.herokuapp.com/v1/cases/';

// list of patient narrative values user highlighted
List<String> summary = List<String>.filled(0, '', growable: true);

// list of vital values user highlighted
List<String> vitalSummary = List<String>.filled(0, '', growable: true);

// list of lab values user highlighted
List<String> labsummary = List<String>.filled(0, '', growable: true);

// TODO: REPLACE BOOLS BELOW WITH LOGIC
// some patients have no provocating factors listed:
bool provocatingFactors = true;
// some patients only have one or two histories listed:
bool history2 = true;
bool history3 = true;

class _PatientCardState extends State<PatientCard>
    with TickerProviderStateMixin {
  Future<PatientChart> futureChart;

  // highlighting bools vitals
  bool pressedTemp = false;
  bool pressedBP = false;
  bool pressedHR = false;
  bool pressedRR = false;
  bool pressedOS = false;
  bool pressedO = false;

  // labtab
  bool pressedwbc = false;
  bool pressedhemo = false;
  bool pressedhema = false;
  bool pressedplat = false;
  bool pressedNa = false;
  bool pressedK = false;
  bool pressedCl = false;
  bool pressedBi = false;
  bool pressedBun = false;
  bool pressedCrea = false;
  bool pressedGluc = false;
  bool pressedBNP = false;
  bool pressedABG = false;
  bool pressedPCO = false;
  bool pressedPO = false;
  bool pressedlac = false;

  TabController tabController;
  bool seenLabsTab = false;
  bool seenCXRTab = false;

  bool showNormalRanges = false;

  bool sentence1 = false;
  bool sentence2 = false;
  bool sentence3 = false;
  bool sentence4 = false;
  bool sentence5 = false;
  bool sentence6 = false;
  bool sentence7 = false;
  bool sentence8 = false;
  bool sentence9 = false;
  bool sentence10 = false;
  bool sentence11 = false;
  bool sentence12 = false;
  bool sentence13 = false;
  bool sentence14 = false;
  bool sentence15 = false;
  bool sentence16 = false;
  bool sentence17 = false;
  bool sentence18 = false;
  bool sentence19 = false;
  bool sentence20 = false;
  bool sentence21 = false;

  // vars for pulling random case:
  Random random = new Random();
  int randomCase;
  String url;

  int caseID;
  // data to be passed on to diagnoseButton:
  int remaining;
  String redHerring;
  String expertAdvice;
  String diagnosis;
  String difficultyLevel;

  // data to be passed on to testResults:
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

  // for physical exam:
  String patient;
  String head;
  String neck;
  String heart;
  String lungs;
  String ab;
  String ext;
  String skin;

  // For Beta, provided 19 available cases with non-sequential case IDs
  // (had to hardcode the IDs)
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

  // initialize state and get (future) chart data
  // (this is called every time the app navs to this screen):
  @override
  void initState() {
    super.initState();

    tabController = new TabController(vsync: this, length: 4);
    // choose a random case ID to pull from:
    randomCase = random.nextInt(19);
    url = baseURL + availableCaseIDs[randomCase].toString();
    print(url);
    summary.clear();
    vitalSummary.clear();
    labsummary.clear();
    // pull Future item containing case data:
    futureChart = getPatientChart(url);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  // where the widget building happens:
  @override
  Widget build(BuildContext context) {
    //decrement no. patients left to examine:
    remaining = widget.patientsLeft - 1;
    //ensconced the FutureBuilder, which creates the entire patient card UI,
    //in a big container below. this is so we can access the API data ONCE
    //instead of repeatedly calling futurebuilder in every
    //widget that requires data from the API, which is slow.
    //(FutureBuilder required since pulling from the API is asynchronous)
    tabController = new TabController(vsync: this, length: 4);
    return Container(
      child: new FutureBuilder<PatientChart>(
        future: futureChart,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            // update variables to pass to the buttons (diagnose, order tests, order x-ray):
            // diagnose
            redHerring = snapshot.data.redHerrings;
            expertAdvice = snapshot.data.expertComments;
            diagnosis = snapshot.data.diagnosis;
            difficultyLevel = snapshot.data.difficulty;
            // order tests
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

            // xray
            caseID = snapshot.data.caseID;

            // physical exam
            patient = "Patient is " + snapshot.data.examGeneral;
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

// BEGIN WIDGET CREATION: 
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
                          // Text(
                          //   snapshot.data.heartRate.toString() + '\u2103',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 25,
                          //   ),
                          // ),
                          Row(
                            children: <Widget>[
                            Text(
                            'Temperature -',
                            style: TextStyle(
                             
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                              child: new Text(
                                snapshot.data.temperature.toString() + '\u2103',
                                style: pressedTemp
                                    ? TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.yellow,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedTemp = !pressedTemp,
                                );
                                if (!pressedTemp) {
                                  vitalSummary.remove("Temperature - " +
                                      snapshot.data.temperature.toString() +
                                      '\u2103');
                                } else {
                                  vitalSummary.add("Temperature - " +
                                      snapshot.data.temperature.toString() +
                                      '\u2103');
                                }
                              }),
                              ],
                              ),
                          Row(
                            children: <Widget>[
                          Text(
                            'Blood Pressure -',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                              child: new Text(
                                snapshot.data.bloodPressure.toString() +
                                    ' mm Hg',
                                style: pressedBP
                                    ? TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.yellow,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedBP = !pressedBP,
                                );
                                if (!pressedBP) {
                                  vitalSummary.remove("Blood Pressure - " +
                                      snapshot.data.bloodPressure.toString() +
                                      ' mm Hg');
                                } else {
                                  vitalSummary.add("Blood Pressure - " +
                                      snapshot.data.bloodPressure.toString() +
                                      ' mm Hg');
                                }
                              }),
                              ],
                              ),
                              Row(
                            children: <Widget>[
                          Text(
                            'Heart Rate -',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                              child: new Text(
                                snapshot.data.heartRate.toString() +
                                    ' Beats/Min',
                                style: pressedHR
                                    ? TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.yellow,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedHR = !pressedHR,
                                );
                                if (!pressedHR) {
                                  vitalSummary.remove("Heart Rate - " +
                                      snapshot.data.heartRate.toString() +
                                      ' Beats/Min');
                                } else {
                                  vitalSummary.add("Heart Rate - " +
                                      snapshot.data.heartRate.toString() +
                                      ' Beats/Min');
                                }
                              }),
                              ],
                              ),
                               Row(
                            children: <Widget>[
                          Text(
                            'Respiratory Rate -',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                              child: new Text(
                                snapshot.data.respiratoryRate.toString() +
                                    ' Breaths/Min',
                                style: pressedRR
                                    ? TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.yellow,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedRR = !pressedRR,
                                );
                                if (!pressedRR) {
                                  vitalSummary.remove("Respiratory Rate - " +
                                      snapshot.data.respiratoryRate.toString() +
                                      ' Breaths/Min');
                                } else {
                                  vitalSummary.add("Respiratory Rate - " +
                                      snapshot.data.respiratoryRate.toString() +
                                      ' Breaths/Min');
                                }
                              }),
                              ],
                              ),
                                Row(
                            children: <Widget>[
                          Text(
                            'O\u2082 Saturation -',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                              child: new Text(
                                snapshot.data.oxygenSat,
                                style: pressedOS
                                    ? TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.yellow,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedOS = !pressedOS,
                                );
                                if (!pressedOS) {
                                  vitalSummary.remove(
                                      'O\u2082 Saturation - ${snapshot.data.oxygenSat.toString()}');
                                } else {
                                  vitalSummary.add(
                                      'O\u2082 Saturation - ${snapshot.data.oxygenSat.toString()}');
                                }
                              }),
                              ],
                              ),
                                 Row(
                            children: <Widget>[
                          Text(
                            'O\u2082 Received -',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          TextButton(
                              child: new Text(
                                snapshot.data.oxygenAmount,
                                style: pressedO
                                    ? TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.yellow,
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedO = !pressedO,
                                );
                                if (!pressedO) {
                                  vitalSummary.remove(
                                      'O\u2082 Received - ${snapshot.data.oxygenAmount.toString()}');
                                } else {
                                  vitalSummary.add(
                                      'O\u2082 Received - ${snapshot.data.oxygenAmount.toString()}');
                                }
                              }),
                              ],
                              ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );

            //             Title and Vitals Widgets
            //-------------------------------------------------------
            Widget vitalsList = Container(
              padding: const EdgeInsets.only(bottom: 6, top: 6),
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Vitals",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        decoration: TextDecoration.underline),
                    textAlign: TextAlign.center,
                  ),
                  vitals,
                ],
              ),
            );

            //         General Results from the Physical Examination
            //--------------------------------------------------------------
            // Widget physical = Container(
            //   padding: const EdgeInsets.only(left: 9, right: 9, bottom: 7),
              // child: Text(
              //   "Patient is " + snapshot.data.examGeneral,
              //   style: TextStyle(
              //       //fontWeight: FontWeight.bold,
              //       fontSize: 15),
              //   textAlign: TextAlign.center,
              // )
            //);

            //        Button to "Conduct" Physical Exam
            //------------------------------------------------------
            // Widget conductPhysical = Container(
            //   child: Column(children: [
            //     GestureDetector(
            //         onTap: () {
            //           viewExamResults(context);
            //         },
            //         child: _buildPhysicalExamButton(
            //             Theme.of(context).primaryColor,
            //             Icons.person,
            //             'Conduct Physical Exam')),
            //   ]),
            // );

            //               Box with Physical Exam Button
            //-----------------------------------------------------------
            Widget physicalExam = Container(
              child: Column(children: [
                GestureDetector(
                    onTap: () {
                      viewExamResults(context);
                    },
                    child: _buildPhysicalExamButton(
                        Theme.of(context).primaryColor,
                        Icons.person,
                        'Conduct Physical Exam')),
              ]),
            );
            // Container(
            //   padding: const EdgeInsets.only(bottom: 6, top: 6),
            //   margin: EdgeInsets.only(left: 10, right: 10),
            //   decoration: BoxDecoration(
            //     color: Colors.red[50],
            //     border: Border.all(color: Colors.black38, width: 1),
            //     borderRadius: BorderRadius.circular(12),
            //   ),
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //     //   Text(
            //     //     "Physical Exam",
            //     //     style: TextStyle(
            //     //         fontWeight: FontWeight.bold,
            //     //         fontSize: 30,
            //     //         decoration: TextDecoration.underline),
            //     //     textAlign: TextAlign.center,
            //     //   ),
            //       // Padding(padding: EdgeInsets.only(top: 6.0)),
            //       physical,
            //       // Padding(padding: EdgeInsets.only(top: 6.0)),
            //       conductPhysical,
            //     ],
            //   ),
            // );

            //            Vitals and Physical Exam Tab
            //-----------------------------------------------------------
            Widget vitalsPhysicalTab = Container(
              margin: const EdgeInsets.only(left: 5.0, right: 5.0),
              padding: const EdgeInsets.all(12),
              child: ListView(
                children: [
                  Row(
                    children: [Expanded(child: vitalsList)],
                  ),
                  // onset,
                  Padding(padding: EdgeInsets.only(top: 12.0)),
                  Row(
                    children: [Expanded(child: physicalExam)],
                  ),
                ], // BOXES OF TAB
              ),
            );
//=============================================================================
//                       Labs Tab
//=============================================================================
            Widget labTab = Container(
              child: ListView(
                children: [
                  SwitchListTile(
                      activeColor: Colors.blue[300],
                      contentPadding: const EdgeInsets.all(5.0),
                      value: showNormalRanges,
                      title: Text('Show Normal Ranges'),
                      onChanged: (value) {
                        setState(() {
                          showNormalRanges = !showNormalRanges;
                        });
                      }),
                  Row(
                    children: <Widget>[
                      Text(" CBC  ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Text(" White blood cells -",
                          style: TextStyle(fontSize: 18)),
                      TextButton(
                          child: new Text(
                            wbc,
                            style: pressedwbc
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold)
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {
                            setState(
                              () => pressedwbc = !pressedwbc,
                            );
                            if (!pressedwbc) {
                              labsummary.remove(
                                  "White blood cells - " + wbc + " K/uL");
                            } else {
                              labsummary
                                  .add("White blood cells - " + wbc + " K/uL");
                            }
                          }),
                      showNormalRanges
                          ? Text("                5-10 K/uL",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey))
                          : Text(""),
                    ],
                  ),
                  Row(children: <Widget>[
                    Text(" Hemoglobin -", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          hemo,
                          style: pressedhemo
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedhemo = !pressedhemo,
                          );
                          if (!pressedhemo) {
                            labsummary.remove("Hemoglobin - " + hemo + " g/dL");
                          } else {
                            labsummary.add("Hemoglobin - " + hemo + " g/dL");
                          }
                        }),
                    showNormalRanges
                        ? Text("                12.0-17.5 g/dL",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" Hematocrit - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          hema,
                          style: pressedhema
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedhema = !pressedhema,
                          );
                          if (!pressedhema) {
                            labsummary.remove("Hematocrit - " + hema + "%");
                          } else {
                            labsummary.add("Hematocrit - " + hema + "%");
                          }
                        }),
                    showNormalRanges
                        ? Text("                            36-50%",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" Platelets - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          plat,
                          style: pressedplat
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedplat = !pressedplat,
                          );
                          if (!pressedplat) {
                            labsummary.remove("Platelets - " + plat + " K/uL");
                          } else {
                            labsummary.add("Platelets - " + plat + " K/uL");
                          }
                        }),
                    showNormalRanges
                        ? Text("                       140-450 K/uL",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Divider(
                    color: Colors.grey[400],
                    height: 0,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Row(children: <Widget>[
                    Text("Basic Metabolic Panel",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
                  Row(children: <Widget>[
                    Text(" Sodium - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          na,
                          style: pressedNa
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedNa = !pressedNa,
                          );
                          if (!pressedNa) {
                            labsummary.remove("Sodium - " + na + " mmol/L");
                          } else {
                            labsummary.add("Sodium - " + na + " mmol/L");
                          }
                        }),
                    showNormalRanges
                        ? Text("               136-145 mmol/L",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" Potassium - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          k,
                          style: pressedK
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedK = !pressedK,
                          );
                          if (!pressedK) {
                            labsummary.remove("Potassium - " + k + " mmo/L");
                          } else {
                            labsummary.add("Potassium - " + k + " mmo/L");
                          }
                        }),
                    showNormalRanges
                        ? Text("             3.6-5.2 mmol/L",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text("Chloride - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          cl,
                          style: pressedCl
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedCl = !pressedCl,
                          );
                          if (!pressedCl) {
                            labsummary.remove("Chloride - " + cl + " mmo/L");
                          } else {
                            labsummary.add("Chloride - " + cl + " mmo/L");
                          }
                        }),
                    showNormalRanges
                        ? Text("                  96-106 mmol/L",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" Bicarbonate - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          c,
                          style: pressedBi
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedBi = !pressedBi,
                          );
                          if (!pressedBi) {
                            labsummary.remove("Bicarbonate - " + c + " mmo/L");
                          } else {
                            labsummary.add("Bicarbonate - " + c + " mmo/L");
                          }
                        }),
                    showNormalRanges
                        ? Text("             23-30 mmol/L",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" BUN -", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          bun,
                          style: pressedBun
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedBun = !pressedBun,
                          );
                          if (!pressedBun) {
                            labsummary.remove("BUN (blood urea nitrogen) - " +
                                bun +
                                " mg/dL");
                          } else {
                            labsummary.add("BUN (blood urea nitrogen) - " +
                                bun +
                                " mg/dL");
                          }
                        }),
                    showNormalRanges
                        ? Text("                                 7-20 mg/dL",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" Creatinine - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          creat,
                          style: pressedCrea
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedCrea = !pressedCrea,
                          );
                          if (!pressedCrea) {
                            labsummary
                                .remove("Creatinine - " + creat + " mg/dL");
                          } else {
                            labsummary.add("Creatinine - " + creat + " mg/dL");
                          }
                        }),
                    showNormalRanges
                        ? Text("              0.59-1.35 mg/dL",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" Glucose - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          glucose,
                          style: pressedGluc
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedGluc = !pressedGluc,
                          );
                          if (!pressedGluc) {
                            labsummary
                                .remove("Glucose - " + glucose + " mg/dL");
                          } else {
                            labsummary.add("Glucose - " + glucose + " mg/dL");
                          }
                        }),
                    showNormalRanges
                        ? Text("                     70-120 mg/dL",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Divider(
                    color: Colors.grey[400],
                    height: 0,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Row(children: <Widget>[
                    Text("Arterial Blood Gas",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
                  Row(children: <Widget>[
                    Text(" pH -", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          abgph,
                          style: pressedABG
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedABG = !pressedABG,
                          );
                          if (!pressedABG) {
                            labsummary.remove(
                                "ABG (arterial blood gas) - " + "pH " + abgph);
                          } else {
                            labsummary.add(
                                "ABG (arterial blood gas) - " + "pH " + abgph);
                          }
                        }),
                    showNormalRanges
                        ? Text(
                            "                                            7.35-7.45",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" pCO\u2082 - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          abgpo2,
                          style: pressedPCO
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedPCO = !pressedPCO,
                          );
                          if (!pressedPCO) {
                            labsummary.remove(
                                "ABG - pCO\u2082 - " + abgpo2 + " mmHg");
                          } else {
                            labsummary
                                .add("ABG - pCO\u2082 - " + abgpo2 + " mmHg");
                          }
                        }),
                    showNormalRanges
                        ? Text("                           38-42 mmHg",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" pO\u2082 -", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          abgpo,
                          style: pressedPO
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedPO = !pressedPO,
                          );
                          if (!pressedPO) {
                            labsummary
                                .remove("ABG - pO\u2082 - " + abgpo + " mmHg");
                          } else {
                            labsummary
                                .add("ABG - pO\u2082 - " + abgpo + " mmHg");
                          }
                        }),
                    showNormalRanges
                        ? Text("                             75-100 mmHg",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Divider(
                    color: Colors.grey[400],
                    height: 0,
                    thickness: 2,
                    indent: 0,
                    endIndent: 0,
                  ),
                  Row(children: <Widget>[
                    Text("Other Labs",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ]),
                  Row(children: <Widget>[
                    Text(" BNP - ", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          bnp,
                          style: pressedBNP
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedBNP = !pressedBNP,
                          );
                          if (!pressedBNP) {
                            labsummary.remove("BNP - " + bnp + " mg/dL");
                          } else {
                            labsummary.add("BNP - " + bnp + " mg/dL");
                          }
                        }),
                    showNormalRanges
                        ? Text("                              <100 mg/dL",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                  Row(children: <Widget>[
                    Text(" Lactate -", style: TextStyle(fontSize: 18)),
                    TextButton(
                        child: new Text(
                          lactate,
                          style: pressedlac
                              ? TextStyle(
                                  color: Colors.black,
                                  backgroundColor: Colors.yellow,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold)
                              : TextStyle(
                                  fontSize: 17.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          setState(
                            () => pressedlac = !pressedlac,
                          );
                          if (!pressedlac) {
                            labsummary
                                .remove("Lactate - " + lactate + " mmol/L");
                          } else {
                            labsummary.add("Lactate - " + lactate + " mmol/L");
                          }
                        }),
                    showNormalRanges
                        ? Text("                        <1.0 mmol/L ",
                            style: TextStyle(fontSize: 18, color: Colors.grey))
                        : Text(""),
                  ]),
                ],
              ),
            );

//=============================================================================
//                       CXR tab
//=============================================================================
            Widget cxrTab = Container(
              child: Image(
                image: NetworkImage("https://lungxrays.s3.amazonaws.com/" +
                    caseID.toString() +
                    ".jpg"),
              ),
              // PhotoView(
              //   imageProvider: NetworkImage("https://lungxrays.s3.amazonaws.com/" + caseID.toString() + ".jpg"),
              // ),
              //THIS VERSION LETS YOU ZOOM BUT I GET AN ERROR
            );

//=============================================================================
//                       Narrative tab
//=============================================================================

            //}
            //---------NARRATIVE TEXT--------------------------------------
            Widget narrative = Container(
                padding: const EdgeInsets.only(top: 6, left: 12, right: 12),
                child: Text(
                  snapshot.data.narratives,
                  style: TextStyle(fontSize: 18),
                ));
            //---------NARRATIVE BOX--------------------------------------
            var numSentences = snapshot.data.narratives.split('.').length;

            Widget narrativeBox = Container(
              padding: const EdgeInsets.only(bottom: 6, top: 6),
              decoration: BoxDecoration(
                color: Colors.red[50],
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
                  numSentences >= 1
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[0] + ".",
                            style: sentence1
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence1 = !sentence1,
                            );
                            if (!sentence1) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[0] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[0] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 2
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[1] + ".",
                            style: sentence2
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence2 = !sentence2,
                            );
                            if (!sentence2) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[1] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[1] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 3
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[2] + ".",
                            style: sentence3
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence3 = !sentence3,
                            );
                            if (!sentence3) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[2] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[2] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 4
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[3] + ".",
                            style: sentence4
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence4 = !sentence4,
                            );
                            if (!sentence4) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[3] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[3] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 5
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[4] + ".",
                            style: sentence5
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence5 = !sentence5,
                            );
                            if (!sentence5) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[4] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[4] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 6
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[5] + ".",
                            style: sentence6
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence6 = !sentence6,
                            );
                            if (!sentence6) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[5] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[5] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 7
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[6] + ".",
                            style: sentence7
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence7 = !sentence7,
                            );
                            if (!sentence7) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[6] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[6] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 8
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[7] + ".",
                            style: sentence8
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence8 = !sentence8,
                            );
                            if (!sentence8) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[7] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[7] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 9
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[8] + ".",
                            style: sentence9
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence9 = !sentence9,
                            );
                            if (!sentence9) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[8] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[8] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 10
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[9] + ".",
                            style: sentence10
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence10 = !sentence10,
                            );
                            if (!sentence10) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[9] + ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[9] + ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 11
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[10] + ".",
                            style: sentence11
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence11 = !sentence11,
                            );
                            if (!sentence11) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[10] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[10] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 12
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[11] + ".",
                            style: sentence12
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence12 = !sentence12,
                            );
                            if (!sentence12) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[11] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[11] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 13
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[12] + ".",
                            style: sentence13
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence13 = !sentence13,
                            );
                            if (!sentence13) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[12] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[12] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 14
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[13] + ".",
                            style: sentence14
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence14 = !sentence14,
                            );
                            if (!sentence14) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[13] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[13] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 15
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[14] + ".",
                            style: sentence15
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence15 = !sentence15,
                            );
                            if (!sentence15) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[14] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[14] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 16
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[15] + ".",
                            style: sentence16
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence16 = !sentence16,
                            );
                            if (!sentence16) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[15] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[15] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 17
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[16] + ".",
                            style: sentence17
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence17 = !sentence17,
                            );
                            if (!sentence17) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[16] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[16] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 18
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[17] + ".",
                            style: sentence18
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence18 = !sentence18,
                            );
                            if (!sentence18) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[17] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[17] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 19
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[18] + ".",
                            style: sentence19
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence19 = !sentence19,
                            );
                            if (!sentence19) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[18] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[18] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 20
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[19] + ".",
                            style: sentence20
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence20 = !sentence20,
                            );
                            if (!sentence20) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[19] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[19] +
                                      ".");
                            }
                          })
                      : Text(""),
                  numSentences >= 21
                      ? TextButton(
                          child: new Text(
                            snapshot.data.narratives.split('.')[20] + ".",
                            style: sentence21
                                ? TextStyle(
                                    color: Colors.black,
                                    backgroundColor: Colors.yellow,
                                    fontSize: 17.0,
                                  )
                                : TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.black,
                                  ),
                          ),
                          onPressed: () {
                            setState(
                              () => sentence21 = !sentence21,
                            );
                            if (!sentence21) {
                              summary.remove(
                                  snapshot.data.narratives.split('.')[20] +
                                      ".");
                            } else {
                              summary.add(
                                  snapshot.data.narratives.split('.')[20] +
                                      ".");
                            }
                          })
                      : Text(""),
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
//-----------------------BACK BUTTON----------------------------------
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // viewXrays(context);
                          int pagenum = (tabController.index - 1) % 4;
                          if (pagenum == 3) {
                            pagenum = 0;
                            //_buildButtonColumn(Colors.grey, Icons.wb_sunny, 'BACK')
                          }
                          tabController.animateTo(pagenum);
                        },
                        child:
                            _buildButtonColumn(color, Icons.wb_sunny, 'BACK'),
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
                                title: Text(
                                  'Highlights',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      if (summary.isNotEmpty)
                                        Text(
                                          'Patient Narrative: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      for (int i = 0; i < summary.length; i++)
                                        Text('${summary[i]}'),
                                      if (vitalSummary.isNotEmpty)
                                        Text(
                                          'Vitals: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      for (int i = 0;
                                          i < vitalSummary.length;
                                          i++)
                                        Text('${vitalSummary[i]}'),
                                      if (labsummary.isNotEmpty)
                                        Text(
                                          'Labs: ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      for (int i = 0;
                                          i < labsummary.length;
                                          i++)
                                        Text('${labsummary[i]}'),
                                      if (labsummary.isEmpty &&
                                          summary.isEmpty &&
                                          vitalSummary.isEmpty)
                                        Text('You did not highlight any data!'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Back to chart'),
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
//-----------------------NEXT BUTTON----------------------------------
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            // viewTestResults(context);
                            int pagenum = (tabController.index + 1) % 4;
                            if (pagenum == 0) {
                              pagenum = 3;
                            }
                            if (pagenum == 2) {
                              seenLabsTab = true;
                            }
                            if (pagenum == 3) {
                              seenCXRTab = true;
                            }
                            tabController.animateTo(pagenum);
                          },
                          child: _buildButtonColumn(
                              color, Icons.folder_shared, 'NEXT')),
                    ],
                  )
                ],
              ),
            );

            //-----------------------PATIENT CARD FINAL SETUP------------------------
            return new Scaffold(
              appBar: AppBar(
                title: Text("Patient " +
                    snapshot.data.caseID.toString() +
                    ": " +
                    snapshot.data.gender +
                    ", age " +
                    snapshot.data.age.toString()),
                leading: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.of(context).pop();
                    navigateToGameplay(context);
                  },
                ),
                centerTitle: true,
                bottom: TabBar(
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Patient Narrative",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Vitals and Physical",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Labs",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "CXR",
                          style: TextStyle(
                            fontSize: 13,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                physics: NeverScrollableScrollPhysics(),
                controller: tabController,
                children: [
                  narrativeTab,
                  vitalsPhysicalTab,
                  labTab,
                  cxrTab,
                ],
              ),
              bottomNavigationBar: new Container(
                  height: 105.0,
                  color: color.withOpacity(0.2),
                  padding: new EdgeInsets.only(top: 7.0),
                  child: bottomButtons),
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
  Card _buildButtonColumn(Color color, IconData icon, String label) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.blue[600],
        child: Center(
          child: Column(
            children: [
              Container(
                width: 80,
                // padding:
                // EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
                child: Column(
                  children: [
                    Container(
                      width: 62,
                      padding:
                          EdgeInsets.only(top: 8, left: 2, right: 2, bottom: 8),
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card _buildDiagnoseButtonColumn(Color color, IconData icon, String label) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        splashColor: Colors.blue[600],
        child: Center(
          child: Column(
            children: [
              Container(
                width: 110,
                padding:
                    EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: color, size: 24),
                    Container(
                      margin: const EdgeInsets.only(top: 4),
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
          ),
        ),
      ),
    );
  }

  Column _TEMPOFFbuildButtonColumn(Color color, IconData icon, String label) {
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
                offset: Offset(0, 4), // changes position of shadow
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

  Column _TEMPOFFbuildDiagnoseButtonColumn(
      Color color, IconData icon, String label) {
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
                offset: Offset(0, 4), // changes position of shadow
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
                offset: Offset(0, 4), // changes position of shadow
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

//----------------------------------------------------------------------
//                      NAVIGATOR  FUNCTIONS
//----------------------------------------------------------------------
  Future viewExamResults(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Physical(
                patient: patient,
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

  Future navigateToGameplay(context) async {
    Navigator.of(context).pop();
    Navigator.of(context).push(MaterialPageRoute(builder: (context) => Game()));
  }

  Future diagnoseBttn(context) async {
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
