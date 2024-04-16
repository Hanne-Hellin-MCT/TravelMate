import 'package:flutter/material.dart';

class AddTripData extends ChangeNotifier {
  String destination = '';
  DateTime startdate = DateTime.now();
  DateTime enddate = DateTime.now();
  List<String> features = [];
  String description = '';
  //fotos
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
}
