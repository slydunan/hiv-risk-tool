import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'dart:math';

List<Partner> initialPartners = [
  Partner(name: 'p1', hivStatus: 'Positive'),
  Partner(name: 'p2', hivStatus: 'Negative'),
  Partner(
      name: 'p2',
      hivStatus: 'Unknown',
      gender: 'Female',
      sexwithmen: 'Yes',
      injector: 'Yes',
      routes: ['Insertive Anal Intercourse (PAI)', 'Needle-sharing']),
  Partner(
      name: 'p3',
      hivStatus: 'Unknown',
      gender: 'Female',
      sexwithmen: 'Yes',
      injector: 'No',
      routes: ['Insertive Anal Intercourse (PAI)', 'Needle-sharing']),
];

class PartnerModel extends ChangeNotifier {
  /// Internal, private state of the cart. Stores the ids of each item.
  final List<Partner> partners = initialPartners;

  /// Adds [item] to cart. This is the only way to modify the cart from outside.
  void add(Partner partner) {
    partners.add(partner);
    // This line tells [Model] that it should rebuild the widgets that
    // depend on it.
    notifyListeners();
  }

  void remove(Partner partner) {
    partners.remove(partner);
    // Don't forget to tell dependent widgets to rebuild _every time_
    // you change the model.
    notifyListeners();
  }
}

class Partner {
  int id = 0;
  String name;
  String? description;
  String ethnicity;
  String hivStatus;
  String gender;
  String injector;
  String sexwithmen;
  List<String>? routes = [];
  List<String>? protection = [];
  double hivProb = -1;
  String demogNoInject = '';
  String demogInject = '';

  Partner(
      {this.name = 'Partner',
      this.hivStatus = 'Unknown',
      this.ethnicity = 'Unknown',
      this.gender = 'Unknown',
      this.sexwithmen = 'Unknown',
      this.injector = 'Unknown',
      this.hivProb = -1,
      this.routes,
      this.protection}) {
    switch (hivStatus) {
      case 'Unknown':
        hivProb = 0.1;
      case 'Positive':
        hivProb = 1;
      case 'Negative':
        hivProb = 0;
    }
    if (gender == 'Unknown') gender = 'Male';
    if (injector == 'Unknown') injector = 'No';
    demogNoInject = [gender, sexwithmen, ethnicity].join("");
    demogInject = [gender, ethnicity].join("");
    hivProb = calculateProb();
    print('$hivProb final');
  }

  double calculateProb() {
    if (hivStatus == 'Negative') {
      return 0;
    } else if (hivStatus == 'Positive') {
      return 1;
    } else if (hivStatus == 'Unknown') {
      double probNoInject = -1;
      probNoInject = getNoInject(demogNoInject);
      double probInject = -1;
      probInject = (injector == 'Yes') ? getInject(demogInject) : 0;
      print('demog: $demogNoInject');
      print('noinj: $probNoInject');
      print('inj: $probInject');
      hivProb = max(probInject, probNoInject);
      return hivProb;
    } else if (hivStatus == 'Custom') {
      return hivProb;
    } else {
      print('error not found');
      return -2;
    }
  }

  double getNoInject(String demogNoInject) {
    double prob = -5;
    print('Looking for $demogNoInject');
    for (int i = 1; i < csvNoInject.length; i++) {
      if (csvNoInject[i][0] == demogNoInject) {
        prob = csvNoInject[i][1];
        print('Prob value for $demogNoInject: $prob');
        return prob;
      }
    }
    print('Didnt find value for $demogNoInject: $prob');
    return prob;
  }

  double getInject(String demogInject) {
    double prob = -5;
    //print('Looking for $demogInject');
    for (int i = 1; i < csvInject.length; i++) {
      if (csvInject[i][0] == demogInject) {
        prob = csvInject[i][1];
        //print('Prob value for $demogInject: $prob');
        return prob;
      }
    }
    //print('Didnt find value for $demogInject: $prob');
    return prob;
  }
}

List<Partner> listPartner = [
  Partner(name: 'Partner1', hivStatus: "Positive", ethnicity: 'Asian'),
  Partner(name: 'Partner2', hivStatus: "Unknown"),
];

List<String> routeOptions = [
  'Insertive Anal Intercourse (PAI)',
  'Receptive Anal Intercourse (RAI)',
  'Insertive Vaginal Intercourse (IVI)',
  'Receptive Vaginal Intercourse (RVI)',
  'Needle-sharing'
];

List<List<dynamic>> csvNoInject = [
  ['demogNoInject', 'prob'],
  ['MaleUnknownUnknown', 0.003231],
  ['MaleUnknownBlack', 0],
  ['MaleUnknownHispanic', 0.005981],
  ['MaleUnknownWhite', 0.017568],
  ['MaleUnknownOther', 0.008396],
  ['MaleNoUnknown', 0.035596616],
  ['MaleNoBlack', 0],
  ['MaleNoHispanic', 0.000662159],
  ['MaleNoWhite', 0.0035406726],
  ['MaleNoOther', 0.0007426979],
  ['MaleYesUnknown', 0.0017280491],
  ['MaleYesBlack', 0],
  ['MaleYesHispanic', 0.0358785547],
  ['MaleYesWhite', 0.0726478204],
  ['MaleYesOther', 0.0576656665],
  ['FemaleUnknownUnknown', 0.0133812982],
  ['FemaleUnknownBlack', 0],
  ['FemaleUnknownHispanic', 0.0014538489],
  ['FemaleUnknownWhite', 0.0069060957],
  ['FemaleUnknownOther', 0.0015684562],
  ['FemaleNoUnknown', 0.0133812982],
  ['FemaleNoBlack', 0],
  ['FemaleNoHispanic', 0.0014538489],
  ['FemaleNoWhite', 0.0069060957],
  ['FemaleNoOther', 0.0015684562],
  ['FemaleYesUnknown', 0.0014087824],
  ['FemaleYesBlack', 0.0070651093],
  ['FemaleYesHispanic', 0.0015775065],
  ['FemaleYesWhite', 0.0003284269],
  ['FemaleYesOther', 0.0008903232],
];

List<List<dynamic>> csvInject = [
  ['demogInject', 'prob'],
  ['MaleUnknown', 0.0124789012],
  ['MaleBlack/African American', 0.049958889],
  ['MaleHispanic/Latino', 0.030884221],
  ['MaleWhite/Caucasian', 0.0040074041],
  ['MaleOther/Not Listed', 0.0120768395],
  ['FemaleUnknown', 0.0204355761],
  ['FemaleBlack/African American', 0.0787162714],
  ['FemaleHispanic/Latino', 0.0532318809],
  ['FemaleWhite/Caucasian', 0.0089427717],
  ['FemaleOther/Not Listed', 0.0206403359],
];
