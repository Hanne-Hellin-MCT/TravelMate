import 'package:flutter/material.dart';

class AddTripData with ChangeNotifier {
  String destination = '';
  String startdate = '';
  String enddate = '';
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

  void setStartdate(String newStartdate) {
    startdate = newStartdate;
    notifyListeners();
  }

  void setEnddate(String newEnddate) {
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

  String getStartdate() {
    return startdate;
  }

  String getEnddate() {
    return enddate;
  }

  List<String> getFeatures() {
    return features;
  }

  String getUitleg() {
    return description;
  }
}
