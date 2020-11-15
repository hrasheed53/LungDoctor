import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

//DEF:
//puts all the patient data from the api into a json file then a map

class PatientChart {
  var id;
  var age;
  var gender;
  var diagnosis;
  var narratives;
  var pastMedHistory1;
  var caseID;
  var pastMedHistory2;
  var bloodABGpco2;
  var bloodABGph;
  var bloodABGpo2;
  var bloodBNP;
  var bloodBUN;
  var bloodBicarbonate;
  var bloodChloride;
  var bloodCreatinine;
  var bloodGlucose;
  var bloodHemacrotit;
  var bloodHemoglobin;
  var bloodLactate;
  var bloodPlatelets;
  var bloodPotassium;
  var bloodPressure;
  var bloodSodium;
  var bloodWBC;
  var cxrLink;
  var cxrThoughts;
  var difficulty;
  var examAbdomen;
  var examExtremeties;
  var examGeneral;
  var examHead;
  var examHeart;
  var examLungs;
  var examNeck;
  var examSkin;
  var expertComments;
  var heartRate;
  var oxygenAmount;
  var oxygenSat;
  var pastMedHistory3;
  var provocatingFactors;
  var redHerrings;
  var respiratoryRate;
  var symptomDescription;
  var symptomOnset;
  var temperature;
  var tobaccoUse;

  PatientChart(
      {this.id,
      this.age,
      this.gender,
      this.diagnosis,
      this.narratives,
      this.pastMedHistory1,
      this.caseID,
      this.pastMedHistory2,
      this.bloodABGpco2,
      this.bloodABGph,
      this.bloodABGpo2,
      this.bloodBNP,
      this.bloodBUN,
      this.bloodBicarbonate,
      this.bloodChloride,
      this.bloodCreatinine,
      this.bloodGlucose,
      this.bloodHemacrotit,
      this.bloodHemoglobin,
      this.bloodLactate,
      this.bloodPlatelets,
      this.bloodPotassium,
      this.bloodPressure,
      this.bloodSodium,
      this.bloodWBC,
      this.cxrLink,
      this.cxrThoughts,
      this.difficulty,
      this.examAbdomen,
      this.examExtremeties,
      this.examGeneral,
      this.examHead,
      this.examHeart,
      this.examLungs,
      this.examNeck,
      this.examSkin,
      this.expertComments,
      this.heartRate,
      this.oxygenAmount,
      this.oxygenSat,
      this.pastMedHistory3,
      this.provocatingFactors,
      this.redHerrings,
      this.respiratoryRate,
      this.symptomDescription,
      this.symptomOnset,
      this.temperature,
      this.tobaccoUse});

  factory PatientChart.fromJson(Map<String, dynamic> json) {
    return PatientChart(
      id: json['_id'],
      age: json['Age'],
      gender: json['Gender'],
      diagnosis: json['Diagnosis'],
      narratives: json['Narratives'],
      pastMedHistory1: json['PastMedHistory1'],
      caseID: json['CaseID'],
      pastMedHistory2: json['PastMedHistory2'],
      bloodABGpco2: json['BloodABG_pco2'],
      bloodABGph: json['BloodABG_ph'],
      bloodABGpo2: json['BloodABG_po2'],
      bloodBNP: json['BloodBNP'],
      bloodBUN: json['BloodBUN'],
      bloodBicarbonate: json['BloodBicarbonate'],
      bloodChloride: json['BloodChloride'],
      bloodCreatinine: json['BloodCreatinine'],
      bloodGlucose: json['BloodGlucose'],
      bloodHemacrotit: json['BloodHemacrotit'],
      bloodHemoglobin: json['BloodHemoglobin'],
      bloodLactate: json['BloodLactate'],
      bloodPlatelets: json['BloodPlatelets'],
      bloodPotassium: json['BloodPotassium'],
      bloodPressure: json['BloodPressure'],
      bloodSodium: json['BloodSodium'],
      bloodWBC: json['BloodWBC'],
      cxrLink: json['CXRLink'],
      cxrThoughts: json['CSRThoughts'],
      difficulty: json['Difficulty'],
      examAbdomen: json['ExamAbdomen'],
      examExtremeties: json['ExamExtremities'],
      examGeneral: json['ExamGeneral'],
      examHead: json['ExamHead'],
      examHeart: json['ExamHeart'],
      examLungs: json['ExamLungs'],
      examNeck: json['ExamNeck'],
      examSkin: json['ExamSkin'],
      expertComments: json['ExpertComments'],
      heartRate: json['HeartRate'],
      oxygenAmount: json['OxygenAmount'],
      oxygenSat: json['OxygenSat'],
      pastMedHistory3: json['PastMedHistory3'],
      provocatingFactors: json['ProvocatingFactors'],
      redHerrings: json['RedHerrings'],
      respiratoryRate: json['RespiratoryRate'],
      symptomDescription: json['SymptomDescription'],
      symptomOnset: json['SymptomOnset'],
      temperature: json['Temperature'],
      tobaccoUse: json['TobaccoUse'],
    );
  }
}

Future<PatientChart> getPatientChart(url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    print(PatientChart.fromJson(jsonDecode(response.body)).age);
    return PatientChart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load patient data');
  }
}
