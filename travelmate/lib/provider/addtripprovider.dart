import 'package:flutter/material.dart';

class AddTripData with ChangeNotifier {
  String destination = '';
  late DateTime startdate;
  late DateTime enddate;
  List<String> features = [];
  String description = '';
  //fotos
  String imageUrl = '';
  String tripname = '';
  String leeftijdvoorkeur = '';
  String gendervoorkeur = '';
  String afstandvoorkeur = '';

  void setDestination(String newDestination) {
    destination = newDestination;
    notifyListeners();
  }

  void setStartdate(DateTime newStartdate) {
    startdate = newStartdate;
    notifyListeners();
  }

  void setEnddate(DateTime newEnddate) {
    enddate = newEnddate;
    notifyListeners();
  }

  void addFeature(String feature) {
    features.add(feature);
    notifyListeners();
  }

  void removeFeature(String feature) {
    features.remove(feature);
    notifyListeners();
  }

  void setUitleg(String newDescription) {
    description = newDescription;
    notifyListeners();
  }

  void setTripname(String newTripname) {
    tripname = newTripname;
    notifyListeners();
  }

  void setLeeftijdvoorkeur(String newLeeftijdvoorkeur) {
    leeftijdvoorkeur = newLeeftijdvoorkeur;
    notifyListeners();
  }

  void setGendervoorkeur(String newGendervoorkeur) {
    gendervoorkeur = newGendervoorkeur;
    notifyListeners();
  }

  void setAfstandvoorkeur(String newAfstandvoorkeur) {
    afstandvoorkeur = newAfstandvoorkeur;
    notifyListeners();
  }

  String getTripname() {
    return tripname;
  }

  String getLeeftijdvoorkeur() {
    return leeftijdvoorkeur;
  }

  String getGendervoorkeur() {
    return gendervoorkeur;
  }

  String getAfstandvoorkeur() {
    return afstandvoorkeur;
  }

  String getDestination() {
    return destination;
  }

  DateTime getStartdate() {
    return startdate;
  }

  DateTime getEnddate() {
    return enddate;
  }

  List<String> getFeatures() {
    return features;
  }

  String getUitleg() {
    return description;
  }

  //reset data
  void resetData() {
    destination = '';
    startdate = DateTime.now();
    enddate = DateTime.now();
    features = [];
    description = '';
    imageUrl = '';
    tripname = '';
    leeftijdvoorkeur = '';
    gendervoorkeur = '';
    afstandvoorkeur = '';
    notifyListeners();
  }
}
