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
import 'dart:math';
import 'package:photo_view/photo_view.dart';

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

// list of exam values user highlighted
List<String> examSummary = List<String>.filled(0, '', growable: true);

TextStyle highlightStyle(bool pressed) {
  return pressed
      ? TextStyle(
          color: Colors.black,
          backgroundColor: Colors.yellow,
          fontSize: 17.0,
          fontWeight: FontWeight.bold)
      : TextStyle(
          fontSize: 17.0, color: Colors.black, fontWeight: FontWeight.bold);
}

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
  // keeps track so when widget rebuilds tab view index doesn't reset to 0
  int currentTabIndex = 0;

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

    //tabController = new TabController(vsync: this, length: 4);
    // choose a random case ID to pull from:
    randomCase = random.nextInt(19);
    url = baseURL + availableCaseIDs[randomCase].toString();
    print(url);
    summary.clear();
    vitalSummary.clear();
    labsummary.clear();
    examSummary.clear();
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
    tabController = new TabController(
        vsync: this, length: 4, initialIndex: currentTabIndex);
    return Container(
      child: new FutureBuilder<PatientChart>(
        future: futureChart,
        builder: (context, snapshot) {
          print("building on line 203");
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
                                    snapshot.data.temperature.toString() +
                                        '\u2103',
                                    style: pressedTemp
                                        ? TextStyle(
                                            color: Colors.black,
                                            backgroundColor: Colors.yellow,
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            fontSize: 19.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    setState(
                                      () {
                                        pressedTemp = !pressedTemp;
                                        print("HEREEEEE");
                                      },
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
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            fontSize: 19.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    setState(
                                      () => pressedBP = !pressedBP,
                                    );
                                    if (!pressedBP) {
                                      vitalSummary.remove("Blood Pressure - " +
                                          snapshot.data.bloodPressure
                                              .toString() +
                                          ' mm Hg');
                                    } else {
                                      vitalSummary.add("Blood Pressure - " +
                                          snapshot.data.bloodPressure
                                              .toString() +
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
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            fontSize: 19.0,
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
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            fontSize: 19.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                  ),
                                  onPressed: () {
                                    setState(
                                      () => pressedRR = !pressedRR,
                                    );
                                    if (!pressedRR) {
                                      vitalSummary.remove(
                                          "Respiratory Rate - " +
                                              snapshot.data.respiratoryRate
                                                  .toString() +
                                              ' Breaths/Min');
                                    } else {
                                      vitalSummary.add("Respiratory Rate - " +
                                          snapshot.data.respiratoryRate
                                              .toString() +
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
                                            fontSize: 19.0,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            fontSize: 19.0,
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
                                            fontSize: 17.0,
                                            fontWeight: FontWeight.bold)
                                        : TextStyle(
                                            fontSize: 17.0,
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
                children: [vitals],
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
                //padding: EdgeInsets.zero,
                // didn't modify padding here so dividers covered whole page
                children: [
                  SwitchListTile(
                      activeColor: Colors.blue[300],
                      // make this zero so it uses padding of parent
                      contentPadding: const EdgeInsets.all(8.0),
                      value: showNormalRanges,
                      title: Text('Show Normal Ranges'),
                      onChanged: (value) {
                        setState(() {
                          showNormalRanges = !showNormalRanges;
                        });
                      }),
                  // *** CBC SECTION *** //
                  // put Rows in containers so could control padding
                  Container(
                      padding: EdgeInsets.only(left: 8.0, bottom: 8.0),
                      child: Row(
                        children: <Widget>[
                          Text("Complete Blood Count",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(bottom: 0.5, top: 0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                              child: new RichText(
                                text: TextSpan(
                                  text: 'White blood cells - ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: wbc,
                                        style: highlightStyle(pressedwbc)),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedwbc = !pressedwbc,
                                );
                                if (!pressedwbc) {
                                  labsummary.remove(
                                      "White blood cells - " + wbc + " K/uL");
                                } else {
                                  labsummary.add(
                                      "White blood cells - " + wbc + " K/uL");
                                }
                              }),
                          Container(
                              padding: EdgeInsets.only(right: 10.0),
                              child: showNormalRanges
                                  ? Text("5-10 K/uL",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey))
                                  : Text("")),
                        ],
                      )),
                  Container(
                      padding: EdgeInsets.only(bottom: 0.5, top: 0.5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          TextButton(
                              child: new RichText(
                                text: TextSpan(
                                  text: 'Hemoglobin - ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: hemo,
                                        style: highlightStyle(pressedhemo)),
                                  ],
                                ),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedhemo = !pressedhemo,
                                );
                                if (!pressedhemo) {
                                  labsummary
                                      .remove("Hemoglobin - " + hemo + " g/dL");
                                } else {
                                  labsummary
                                      .add("Hemoglobin - " + hemo + " g/dL");
                                }
                              }),
                          Container(
                              // only on right so top+bottom customized by listView
                              padding: EdgeInsets.only(right: 10.0),
                              child: showNormalRanges
                                  ? Text("12.0-17.5 g/dL",
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.grey))
                                  : Text("")),
                        ],
                      )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'Hematocrit - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: hema,
                                    style: highlightStyle(pressedhema)),
                              ],
                            ),
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
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("36-50%",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'Platelets - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: plat,
                                    style: highlightStyle(pressedplat)),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () => pressedplat = !pressedplat,
                            );
                            if (!pressedplat) {
                              labsummary
                                  .remove("Platelets - " + plat + " K/uL");
                            } else {
                              labsummary.add("Platelets - " + plat + " K/uL");
                            }
                          }),
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("140-450 K/uL",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Divider(
                        color: Colors.grey[400],
                        height: 0,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      )),
                  // *** BASIC METABOLIC SECTION *** //
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(children: <Widget>[
                        Text("Basic Metabolic Panel",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'Sodium - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: na, style: highlightStyle(pressedNa)),
                              ],
                            ),
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
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("136-145 mmol/L",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'Potassium - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: k, style: highlightStyle(pressedK)),
                              ],
                            ),
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
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("3.6-5.2 mmol/L",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'Bicarbonate - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: c, style: highlightStyle(pressedBi)),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () => pressedBi = !pressedBi,
                            );
                            if (!pressedBi) {
                              labsummary
                                  .remove("Bicarbonate - " + c + " mmo/L");
                            } else {
                              labsummary.add("Bicarbonate - " + c + " mmo/L");
                            }
                          }),
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("23-30 mmol/L",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'BUN - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: bun,
                                    style: highlightStyle(pressedBun)),
                              ],
                            ),
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
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("7-20 mg/dL",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'Creatinine - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: creat,
                                    style: highlightStyle(pressedCrea)),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () => pressedCrea = !pressedCrea,
                            );
                            if (!pressedCrea) {
                              labsummary
                                  .remove("Creatinine - " + creat + " mg/dL");
                            } else {
                              labsummary
                                  .add("Creatinine - " + creat + " mg/dL");
                            }
                          }),
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("0.59-1.35 mg/dL",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'Glucose - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: glucose,
                                    style: highlightStyle(pressedGluc)),
                              ],
                            ),
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
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("70-120 mg/dL",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Divider(
                        color: Colors.grey[400],
                        height: 0,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      )),
                  // *** ARTERIAL BLOOD GAS SECTION *** //
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(children: <Widget>[
                        Text("Arterial Blood Gas",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'pH - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: abgph,
                                    style: highlightStyle(pressedABG)),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () => pressedABG = !pressedABG,
                            );
                            if (!pressedABG) {
                              labsummary.remove("ABG (arterial blood gas) - " +
                                  "pH " +
                                  abgph);
                            } else {
                              labsummary.add("ABG (arterial blood gas) - " +
                                  "pH " +
                                  abgph);
                            }
                          }),
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("7.35-7.45",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'pCO\u2082 - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: abgpo2,
                                    style: highlightStyle(pressedPCO)),
                              ],
                            ),
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
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("38-42 mmHg",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'pO\u2082 - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: abgpo,
                                    style: highlightStyle(pressedPO)),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () => pressedPO = !pressedPO,
                            );
                            if (!pressedPO) {
                              labsummary.remove(
                                  "ABG - pO\u2082 - " + abgpo + " mmHg");
                            } else {
                              labsummary
                                  .add("ABG - pO\u2082 - " + abgpo + " mmHg");
                            }
                          }),
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("75-100 mmHg",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Container(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: Divider(
                        color: Colors.grey[400],
                        height: 0,
                        thickness: 2,
                        indent: 0,
                        endIndent: 0,
                      )),
                  // *** OTHER LABS SECTION *** //
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: Row(children: <Widget>[
                        Text("Other Labs",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ])),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'BNP - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: bnp,
                                    style: highlightStyle(pressedBNP)),
                              ],
                            ),
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
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("< 100 mg/dL",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      TextButton(
                          child: new RichText(
                            text: TextSpan(
                              text: 'Lactate - ',
                              style:
                                  TextStyle(color: Colors.black, fontSize: 18),
                              children: <TextSpan>[
                                TextSpan(
                                    text: lactate,
                                    style: highlightStyle(pressedlac)),
                              ],
                            ),
                          ),
                          onPressed: () {
                            setState(
                              () => pressedlac = !pressedlac,
                            );
                            if (!pressedlac) {
                              labsummary
                                  .remove("Lactate - " + lactate + " mmol/L");
                            } else {
                              labsummary
                                  .add("Lactate - " + lactate + " mmol/L");
                            }
                          }),
                      Container(
                          // only on right so top+bottom customized by listView
                          padding: EdgeInsets.only(right: 10.0),
                          child: showNormalRanges
                              ? Text("< 1.0 mmol/L",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.grey))
                              : Text("")),
                    ],
                  ),
                ],
              ),
            );

//=============================================================================
//                       CXR tab
//=============================================================================
            /* this is the no zoom failsafe version
              Image(
                image: NetworkImage("https://lungxrays.s3.amazonaws.com/" +
                    caseID.toString() +
                    ".jpg"),
              ),*/
            Widget cxrTab = Container(
              child: PhotoView(
                imageProvider: NetworkImage(
                    "https://lungxrays.s3.amazonaws.com/" +
                        caseID.toString() +
                        ".jpg"),
              ),
            );

//=============================================================================
//                       Narrative tab
//=============================================================================

            //}
            //---------NARRATIVE TEXT--------------------------------------
            Container(
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
                  numSentences-1 >= 1
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 1. " + snapshot.data.narratives.split('.')[0] + ".",
                            textAlign: TextAlign.left,
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
                          }),),)
                      : Text(""),
                  numSentences -1>= 2
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 2." + snapshot.data.narratives.split('.')[1] + ".",
                            textAlign: TextAlign.left,
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 3
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 3." + snapshot.data.narratives.split('.')[2] + ".",
                            textAlign: TextAlign.left,
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 4
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 4." + snapshot.data.narratives.split('.')[3] + ".",
                            textAlign: TextAlign.left,
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 5
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 5." +snapshot.data.narratives.split('.')[4] + ".",
                            textAlign: TextAlign.left,
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
                          }),),)
                      : Text(""),
                  numSentences -1>= 6
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 6." +snapshot.data.narratives.split('.')[5] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences -1>= 7
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 7." +snapshot.data.narratives.split('.')[6] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 8
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 8." + snapshot.data.narratives.split('.')[7] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences -1>= 9
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 9." +snapshot.data.narratives.split('.')[8] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 10
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 10." +snapshot.data.narratives.split('.')[9] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 11
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 11." + snapshot.data.narratives.split('.')[10] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 12
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 12." +snapshot.data.narratives.split('.')[11] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences -1 >= 13
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 13." +snapshot.data.narratives.split('.')[12] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences -1 >= 14
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 14." +snapshot.data.narratives.split('.')[13] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences - 1 >= 15
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 15." +snapshot.data.narratives.split('.')[14] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 16
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 16." +snapshot.data.narratives.split('.')[15] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 17
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 17." +snapshot.data.narratives.split('.')[16] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 18
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 18." + snapshot.data.narratives.split('.')[17] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 19
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 19." +snapshot.data.narratives.split('.')[18] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 20
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 20." + snapshot.data.narratives.split('.')[19] + ".",
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
                          }),),)
                      : Text(""),
                  numSentences-1 >= 21
                      ? Align(alignment: Alignment.centerLeft,
                  child: Container(child: TextButton(
                          child: new Text(
                            " 21." +snapshot.data.narratives.split('.')[20] + ".",
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
                          }),),)
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
                          // keeps tab controller from resetting to index 0
                          currentTabIndex = pagenum;
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
                          if (summary.isNotEmpty ||
                              vitalSummary.isNotEmpty ||
                              examSummary.isNotEmpty ||
                              labsummary.isNotEmpty) {
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(
                                    'Highlights',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                                        if (examSummary.isNotEmpty)
                                          Text(
                                            'Physical Exam: ',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        for (int i = 0;
                                            i < examSummary.length;
                                            i++)
                                          Text('${examSummary[i]}'),
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
                                            examSummary.isEmpty &&
                                            vitalSummary.isEmpty)
                                          Text(
                                              'You did not highlight any data!'),
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
                          } else {
                            Navigator.of(context).pop();
                            diagnoseBttn(context);
                          }
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
                            int pagenum = (tabController.index + 1) % 4;
                            if (pagenum == 0) {
                              pagenum = 3;
                            }
                            tabController.animateTo(pagenum);
                            // keeps tab controller from resetting to index 0
                            currentTabIndex = pagenum;
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
                  onTap: (int tab) {
                    // keeps tab controller from resetting to index 0
                    currentTabIndex = tab;
                  },
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

  // Column _TEMPOFFbuildButtonColumn(Color color, IconData icon, String label) {
  //   return Column(
  //     children: [
  //       Container(
  //         width: 62,
  //         padding: EdgeInsets.only(top: 8, left: 4, right: 4, bottom: 8),
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.blueGrey, width: 2),
  //           borderRadius: BorderRadius.circular(8),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey[300].withOpacity(0.5),
  //               spreadRadius: 5,
  //               blurRadius: 7,
  //               offset: Offset(0, 4), // changes position of shadow
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(icon, color: color, size: 18),
  //             Container(
  //               margin: const EdgeInsets.only(top: 8),
  //               child: Align(
  //                 alignment: Alignment.center,
  //                 child: Text(
  //                   label,
  //                   style: TextStyle(
  //                     fontSize: 14,
  //                     fontWeight: FontWeight.w400,
  //                     color: color,
  //                   ),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  // Column _TEMPOFFbuildDiagnoseButtonColumn(
  //     Color color, IconData icon, String label) {
  //   return Column(
  //     children: [
  //       Container(
  //         width: 100,
  //         padding: EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
  //         decoration: BoxDecoration(
  //           border: Border.all(color: Colors.black54, width: 2),
  //           borderRadius: BorderRadius.circular(12),
  //           boxShadow: [
  //             BoxShadow(
  //               color: Colors.grey[300].withOpacity(0.5),
  //               spreadRadius: 5,
  //               blurRadius: 7,
  //               offset: Offset(0, 4), // changes position of shadow
  //             ),
  //           ],
  //         ),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           children: [
  //             Icon(icon, color: color, size: 24),
  //             Container(
  //               margin: const EdgeInsets.only(top: 8),
  //               child: Text(
  //                 label,
  //                 style: TextStyle(
  //                   fontSize: 18,
  //                   fontWeight: FontWeight.w400,
  //                   color: color,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Column _buildPhysicalExamButton(Color color, IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 36, right: 36, top: 30, bottom: 30),
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
                //examSummary: examSummary,
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
