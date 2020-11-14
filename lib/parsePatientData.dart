import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;

//DEF:
//puts all the patient data from the api into a json file then a map

Future<PatientChart> getPatientChart(String url) async {
  final response = await http.get(url);
  if (response.statusCode == 200) {
    return PatientChart.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load patient data');
  }
}

class PatientChart {
  final String id;
  final int age;
  final String gender;
  final String diagnosis;
  final String narratives;
  final String pastMedHistory1;
  final int caseID;
  final String pastMedHistory2;
  final int bloodABGpco2;
  final int bloodABGph;
  final int bloodABGpo2;
  final int bloodBNP;
  final int bloodBUN;
  final int bloodBicarbonate;
  final int bloodChloride;
  final int bloodCreatinine;
  final int bloodGlucose;
  final int bloodHemacrotit;
  final int bloodHemoglobin;
  final int bloodLactate;
  final int bloodPlatelets;
  final int bloodPotassium;
  final String bloodPressure;
  final int bloodSodium;
  final int bloodWBC;
  final String cxrLink;
  final String cxrThoughts;
  final String difficulty;
  final String examAbdomen;
  final String examExtremeties;
  final String examGeneral;
  final String examHead;
  final String examHeart;
  final String examLungs;
  final String examNeck;
  final String examSkin;
  final String expertComments;
  final int heartRate;
  final String oxygenAmount;
  final String oxygenSat;
  final String pastMedHistory3;
  final String provocatingFactors;
  final String redHerrings;
  final int respiratoryRate;
  final String symptomDescription;
  final String symptomOnset;
  final int temperature;
  final String tobaccoUse;

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
      id: json['_id'] as String,
      age: json['Age'] as int,
      gender: json['Gender'] as String,
      diagnosis: json['Diagnosis'] as String,
      narratives: json['Narratives'] as String,
      pastMedHistory1: json['PastMedHistory1'] as String,
      caseID: json['CaseID'] as int,
      pastMedHistory2: json['PastMedHistory2'] as String,
      bloodABGpco2: json['BloodABG_pco2'] as int,
      bloodABGph: json['BloodABG_ph'] as int,
      bloodABGpo2: json['BloodABG_po2'] as int,
      bloodBNP: json['BloodBNP'] as int,
      bloodBUN: json['BloodBUN'] as int,
      bloodBicarbonate: ['BloodBicarbonate'] as int,
      bloodChloride: ['BloodChloride'] as int,
      bloodCreatinine: ['BloodCreatinine'] as int,
      bloodGlucose: ['BloodGlucose'] as int,
      bloodHemacrotit: ['BloodHemacrotit'] as int,
      bloodHemoglobin: ['BloodHemoglobin'] as int,
      bloodLactate: ['BloodLactate'] as int,
      bloodPlatelets: ['BloodPlatelets'] as int,
      bloodPotassium: ['BloodPotassium'] as int,
      bloodPressure: ['BloodPressure'] as String,
      bloodSodium: ['BloodSodium'] as int,
      bloodWBC: ['BloodWBC'] as int,
      cxrLink: ['CXRLink'] as String,
      cxrThoughts: ['CSRThoughts'] as String,
      difficulty: ['Difficulty'] as String,
      examAbdomen: ['ExamAbdomen'] as String,
      examExtremeties: ['ExamExtremities'] as String,
      examGeneral: ['ExamGeneral'] as String,
      examHead: ['ExamHead'] as String,
      examHeart: ['ExamHeart'] as String,
      examLungs: ['ExamLungs'] as String,
      examNeck: ['ExamNeck'] as String,
      examSkin: ['ExamSkin'] as String,
      expertComments: ['ExpertComments'] as String,
      heartRate: ['HeartRate'] as int,
      oxygenAmount: ['OxygenAmount'] as String,
      oxygenSat: ['OxygenSat'] as String,
      pastMedHistory3: ['PastMedHistory3'] as String,
      provocatingFactors: ['ProvocatingFactors'] as String,
      redHerrings: ['RedHerrings'] as String,
      respiratoryRate: ['RespiratoryRate'] as int,
      symptomDescription: ['SymptomDescription'] as String,
      symptomOnset: ['SymptomOnset'] as String,
      temperature: ['Temperature'] as int,
      tobaccoUse: ['TobaccoUse'] as String,
    );
  }
}
