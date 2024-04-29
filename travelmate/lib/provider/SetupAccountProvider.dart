import 'dart:ffi';

import 'package:flutter/material.dart';

class SetupAccountData with ChangeNotifier {
  String idtoken = '';
  String name = '';
  late DateTime birthdate = DateTime.now();
  String gender = '';
  List<String> interests = [];
  //fotos
  List<String> fotosurls = [];
  String bio = '';
  String gendervoorkeur = '';
  String afstandvoorkeur = '';
  String leeftijdvoorkeur = '';

  int? minleeftijdvoorkeur = 18;
  int? maxleeftijdvoorkeur = 25;

  get photoUrls => null;

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

  void setIdToken(String newIdToken) {
    idtoken = newIdToken;
    notifyListeners();
  }

  void setBirthdate(DateTime newBirthdate) {
    birthdate = newBirthdate;
    notifyListeners();
  }

  // set photourls
  void setFotosUrls(List<String> newFotosUrls) {
    fotosurls = newFotosUrls;
    notifyListeners();
  }

  // add photourl
  void addFotoUrl(String newFotoUrl) {
    fotosurls.add(newFotoUrl);
    notifyListeners();
  }

  void setGender(String newGender) {
    gender = newGender;
    notifyListeners();
  }

  void setBio(String newBio) {
    bio = newBio;
    notifyListeners();
  }

  void addInterest(String interest) {
    interests.add(interest);
    notifyListeners();
  }

  void removeInterest(String interest) {
    interests.remove(interest);
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

  void setLeeftijdvoorkeur(String newLeeftijdvoorkeur) {
    leeftijdvoorkeur = newLeeftijdvoorkeur;
    notifyListeners();
  }

  void setMinLeeftijdvoorkeur(int newMinLeeftijdvoorkeur) {
    minleeftijdvoorkeur = newMinLeeftijdvoorkeur;
    notifyListeners();
  }

  // Method to set max leeftijdvoorkeur
  void setMaxLeeftijdvoorkeur(int newMaxLeeftijdvoorkeur) {
    maxleeftijdvoorkeur = newMaxLeeftijdvoorkeur;
    notifyListeners();
  }

  // Getter for min leeftijdvoorkeur
  int? getMinLeeftijdvoorkeur() {
    return minleeftijdvoorkeur;
  }

  // Getter for max leeftijdvoorkeur
  int? getMaxLeeftijdvoorkeur() {
    return maxleeftijdvoorkeur;
  }

  String getName() {
    return name;
  }

  String getIdToken() {
    return idtoken;
  }

  DateTime getBirthdate() {
    return birthdate;
  }

  String getGender() {
    return gender;
  }

  String getBio() {
    return bio;
  }

  List<String> getInterests() {
    return interests;
  }

  List<String> getVoorkeuren() {
    return [gendervoorkeur, afstandvoorkeur, leeftijdvoorkeur];
  }

  String getGendervoorkeur() {
    return gendervoorkeur;
  }

  //get photourls
  List<String> getFotosurls() {
    return fotosurls;
  }

  // Voeg een methode toe om alle gegevens te resetten als dat nodig is
  void resetData() {
    name = '';
    idtoken = '';
    late DateTime birthdate = DateTime.now();
    gender = '';
    interests = [];
    fotosurls = [];
    bio = '';
    gendervoorkeur = '';
    afstandvoorkeur = '';
    leeftijdvoorkeur = '';
    minleeftijdvoorkeur = null;
    maxleeftijdvoorkeur = null;
    notifyListeners();
  }
}
