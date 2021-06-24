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
// import 'package:photo_view/photo_view.dart';

class PatientCard extends StatefulWidget {
  PatientCard({Key key, this.patientsLeft}) : super(key: key);
  final int patientsLeft;

  @override
  _PatientCardState createState() => _PatientCardState();
}

//Contains all the logic for the patient card user interface. Now with comment
//headers for easier understanding.

String baseURL = 'https://diagnostic-gamification-api.herokuapp.com/v1/cases/';

//list of values user highlighted
List<String> summary = List<String>.filled(0, '', growable: true);

//REPLACE BOOLS BELOW WITH LOGIC
//some patients have no provocating factors listed:
bool provocatingFactors = true;
//some patients only have one or two histories listed:
bool history2 = true;
bool history3 = true;
//TabController tabController;

//bool seenLabsTab = false;
//bool seenCXRTab = false;

class _PatientCardState extends State<PatientCard>
    with TickerProviderStateMixin {
  Future<PatientChart> futureChart;

  //highlighting bools vitals
  bool pressedTemp = false;
  bool pressedBP = false;
  bool pressedHR = false;
  bool pressedRR = false;
  bool pressedOS = false;
  bool pressedO = false;

  //labtab
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

    tabController = new TabController(vsync: this, length: 4);
    //choose a random case ID to pull from:
    randomCase = random.nextInt(19);
    url = baseURL + availableCaseIDs[randomCase].toString();
    print(url);
    //pull Future item containing case data:
    futureChart = getPatientChart(url);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  //static final _myTabbedPageKey = new GlobalKey<_PatientCardState>();

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
    tabController = new TabController(vsync: this, length: 4);
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
                color: Colors.red[50],
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
                color: Colors.red[50],
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
                color: Colors.red[50],
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
                color: Colors.red[50],
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(12),
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
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Row(
                    children: [Expanded(child: symptomsList)],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Row(
                    children: [Expanded(child: historyList)],
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
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
                          // Text(
                          //   snapshot.data.heartRate.toString() + '\u2103',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 25,
                          //   ),
                          // ),
                          TextButton(
                              child: new Text(
                                snapshot.data.temperature.toString() + '\u2103',
                                style: pressedTemp
                                    ? TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.yellow,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedTemp = !pressedTemp,
                                );
                                if (!pressedTemp) {
                                  summary.remove(
                                      snapshot.data.temperature.toString() +
                                          '\u2103');
                                } else {
                                  summary.add(
                                      snapshot.data.temperature.toString() +
                                          '\u2103');
                                }
                              }),
                          //Padding(padding: EdgeInsets.only(top: 4.0)),
                          Text(
                            '(Temperature) TEST summary.length=' +
                                summary.length.toString(),
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
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
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedBP = !pressedBP,
                                );
                                if (!pressedBP) {
                                  summary.remove(
                                      snapshot.data.bloodPressure.toString() +
                                          ' mm Hg');
                                } else {
                                  summary.add(
                                      snapshot.data.bloodPressure.toString() +
                                          ' mm Hg');
                                }
                              }),
                          //Padding(padding: EdgeInsets.only(top: 9.0)),
                          //Padding(padding: EdgeInsets.only(top: 4.0)),
                          Text(
                            '(Blood Pressure)',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
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
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedHR = !pressedHR,
                                );
                                if (!pressedHR) {
                                  summary.remove(
                                      snapshot.data.heartRate.toString() +
                                          ' Beats/Min');
                                } else {
                                  summary.add(
                                      snapshot.data.heartRate.toString() +
                                          ' Beats/Min');
                                }
                              }),
                          Text(
                            '(Heart Rate)',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
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
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedRR = !pressedRR,
                                );
                                if (!pressedRR) {
                                  summary.remove(
                                      snapshot.data.respiratoryRate.toString() +
                                          ' Breaths/Min');
                                } else {
                                  summary.add(
                                      snapshot.data.respiratoryRate.toString() +
                                          ' Breaths/Min');
                                }
                              }),
                          Text(
                            '(Respiratory Rate)',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                              child: new Text(
                                snapshot.data.oxygenSat,
                                style: pressedOS
                                    ? TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.yellow,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedOS = !pressedOS,
                                );
                                if (!pressedOS) {
                                  summary.remove(
                                      snapshot.data.oxygenSat.toString() +
                                          ' (O\u2082 Saturation)');
                                } else {
                                  summary.add(
                                      snapshot.data.oxygenSat.toString() +
                                          ' (O\u2082 Saturation)');
                                }
                              }),
                          Text(
                            '(O\u2082 Saturation)',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          TextButton(
                              child: new Text(
                                snapshot.data.oxygenAmount,
                                style: pressedO
                                    ? TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.yellow,
                                        fontSize: 25.0,
                                        fontWeight: FontWeight.bold)
                                    : TextStyle(
                                        fontSize: 25.0,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                setState(
                                  () => pressedO = !pressedO,
                                );
                                if (!pressedO) {
                                  summary.remove(
                                      snapshot.data.oxygenAmount.toString() +
                                          ' (O\u2082 Received)');
                                } else {
                                  summary.add(
                                      snapshot.data.oxygenAmount.toString() +
                                          ' (O\u2082 Received)');
                                }
                              }),
                          Text(
                            '(O\u2082 Received)',
                            style: TextStyle(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
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
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.red[50],
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

            //         general results from the physical
            //--------------------------------------------------------------
            Widget physical = Container(
                padding: const EdgeInsets.only(left: 9, right: 9, bottom: 7),
                child: Text(
                  "Patient is " + snapshot.data.examGeneral,
                  style: TextStyle(
                      //fontWeight: FontWeight.bold,
                      fontSize: 18),
                  textAlign: TextAlign.center,
                ));

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
              margin: EdgeInsets.only(left: 10, right: 10),
              decoration: BoxDecoration(
                color: Colors.red[50],
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Physical Exam",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        decoration: TextDecoration.underline),
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
//                       Labs tab
//=============================================================================
            Widget labTab = Container(
              child: ListView(
                children: [
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("White blood cells - "),
                        TextButton(
                            child: new Text(
                              wbc + " K/uL",
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
                                summary.remove(
                                    "White blood cells - " + wbc + " K/uL");
                              } else {
                                summary.add(
                                    "White blood cells - " + wbc + " K/uL");
                              }
                            }),
                      ]),
                      subtitle: Text("Normal Ranges: K/uL")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Hemoglobin - "),
                        TextButton(
                            child: new Text(
                              hemo + " g/dL",
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
                                summary.remove(
                                    "Hemoglobin - " + hemo + " g/dL");
                              } else {
                                summary.add(
                                    "Hemoglobin - " + hemo + " g/dL");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: g/dL")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Hematocrit - "),
                        TextButton(
                            child: new Text(
                              hema + "%",
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
                                summary.remove(
                                    "Hematocrit - " + hema + "%");
                              } else {
                                summary.add(
                                    "Hematocrit - " + hema + "%");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: ")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Platelets - "),
                        TextButton(
                            child: new Text(
                              plat + " K/uL",
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
                                summary.remove(
                                    "Platelets - " + plat + " K/uL");
                              } else {
                                summary.add(
                                    "Platelets - " + plat + " K/uL");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: K/uL")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Sodium - "),
                        TextButton(
                            child: new Text(
                              na + " mmol/L",
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
                                summary.remove(
                                    "Sodium - " + na + " mmol/L");
                              } else {
                                summary.add(
                                    "Sodium - " + na + " mmol/L");
                              }
                            }),
                       
                      ]),
                      subtitle: Text("Normal Ranges: mmol/L")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Potassium - "),
                        TextButton(
                            child: new Text(
                              k + " mmo/L",
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
                                summary.remove(
                                    "Potassium - " + k + " mmo/L");
                              } else {
                                summary.add(
                                    "Potassium - " + k + " mmo/L");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: mmo/L")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Chloride - "),
                        TextButton(
                            child: new Text(
                              cl + " mmo/L",
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
                                summary.remove(
                                    "Chloride - " + cl + " mmo/L");
                              } else {
                                summary.add(
                                    "Chloride - " + cl + " mmo/L");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: mmo/L")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Bicarbonate - "),
                        TextButton(
                            child: new Text(
                              c + " mmo/L",
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
                                summary.remove(
                                    "Bicarbonate - " + c + " mmo/L");
                              } else {
                                summary.add(
                                    "Bicarbonate - " + c + " mmo/L");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: mmo/L")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("BUN (blood urea nitrogen) -"),
                        TextButton(
                            child: new Text(
                              bun + " mg/dL",
                              style: pressedBun
                                  ? TextStyle(
                                      color: Colors.black,
                                      backgroundColor: Colors.yellow,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)
                                  : TextStyle(
                                      fontSize: 16.0,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              setState(
                                () => pressedBun = !pressedBun,
                              );
                              if (!pressedBun) {
                                summary.remove(
                                    "BUN (blood urea nitrogen) - " + bun + " mg/dL");
                              } else {
                                summary.add(
                                    "BUN (blood urea nitrogen) - " + bun + " mg/dL");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: mg/dL")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Creatinine - "),
                        TextButton(
                            child: new Text(
                              creat + " mg/dL",
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
                                summary.remove(
                                    "Creatinine - " + creat + " mg/dL");
                              } else {
                                summary.add(
                                    "Creatinine - " + creat + " mg/dL");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: mg/dL")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Glucose - "),
                        TextButton(
                            child: new Text(
                              glucose + " mg/dL",
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
                                summary.remove(
                                    "Glucose - " + glucose + " mg/dL");
                              } else {
                                summary.add(
                                    "Glucose - " + glucose + " mg/dL");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: mg/dL")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("BNP - "),
                        TextButton(
                            child: new Text(
                              bnp + " mg/dL",
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
                                summary.remove(
                                    "BNP - " + bnp + " mg/dL");
                              } else {
                                summary.add(
                                    "BNP - " + bnp + " mg/dL");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: mg/dL")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("ABG (arterial blood gas) - "),
                        TextButton(
                            child: new Text(
                              "pH " + abgph,
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
                                summary.remove(
                                    "ABG (arterial blood gas) - " + "pH " + abgph);
                              } else {
                                summary.add(
                                    "ABG (arterial blood gas) - " + "pH " + abgph);
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges:")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("ABG - pCO\u2082 - "),
                        TextButton(
                            child: new Text(
                              abgpo2 + " mm Hg",
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
                                summary.remove(
                                    "ABG - pCO\u2082 - " + abgpo2 + " mm Hg");
                              } else {
                                summary.add(
                                    "ABG - pCO\u2082 - " + abgpo2 + " mm Hg");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: ")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("ABG - pO\u2082 - "),
                        TextButton(
                            child: new Text(
                              abgpo + " mm Hg",
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
                                summary.remove(
                                    "ABG - pO\u2082 - " + abgpo + " mm Hg");
                              } else {
                                summary.add(
                                    "ABG - pO\u2082 - " + abgpo + " mm Hg");
                              }
                            }),
                       
                      ]),
                      subtitle: Text("Normal Ranges")),
                  ListTile(
                      leading: Text(''),
                      title: Row(children: <Widget>[
                        Text("Lactate - "),
                        TextButton(
                            child: new Text(
                              lactate + " mmol/L",
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
                                summary.remove(
                                    "Lactate - " + lactate + " mmol/L");
                              } else {
                                summary.add(
                                    "Lactate - " + lactate + " mmol/L");
                              }
                            }),
                        
                      ]),
                      subtitle: Text("Normal Ranges: ")),
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
            //---------NARRATIVE TEXT--------------------------------------
            Widget narrative = Container(
                padding: const EdgeInsets.only(top: 6, left: 12, right: 12),
                child: Text(
                  snapshot.data.narratives,
                  style: TextStyle(fontSize: 18),
                ));
            //---------NARRATIVE BOX--------------------------------------
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
//-----------------------BACK BUTTON----------------------------------
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //viewXrays(context);
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
//-----------------------NEXT BUTTON----------------------------------
                  Column(
                    children: [
                      GestureDetector(
                          onTap: () {
                            //viewTestResults(context);
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
            return new // MaterialApp(
                //   home: //new PatientCard(
                //   key: _myTabbedPageKey,
                // ),
                Scaffold(
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
                  // onTap: (index) {
                  //   if(tabController.index == 2 && seenLabstab == false){
                  //     //tabController.index = tabController.previousIndex;
                  //   }
                  //   else if(tabController.index == 3 && seenCXRtab == false){
                  //     //tabController.index = tabController.previousIndex;
                  //   }
                  //   else{
                  //     //tabController.index = (tabController.index) % 4;
                  //   }
                  //   //tabController.index = tabController.previousIndex;
                  // },
                  controller: tabController,
                  tabs: [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Patient Narrative",
                          style: TextStyle(
                            fontSize: 15,
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
                            fontSize: 15,
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
                            fontSize: 15,
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
                            fontSize: 15,
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
              //),
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
                //padding:
                //  EdgeInsets.only(top: 12, bottom: 12, left: 4, right: 4),
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
