import 'package:flutter/material.dart';

class SetupAccountData with ChangeNotifier {
  String name = '';
  String birthdate = '';
  String gender = '';
  List<String> interests = [];
  //fotos
  String bio = '';
  String gendervoorkeur = '';
  String afstandvoorkeur = '';
  String leeftijdvoorkeur = '';

  void setName(String newName) {
    name = newName;
    notifyListeners();
  }

  void setBirthdate(String newBirthdate) {
    birthdate = newBirthdate;
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

  String getName() {
    return name;
  }

  String getBirthdate() {
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

  // Voeg een methode toe om alle gegevens te resetten als dat nodig is
  void resetData() {
    name = '';

    notifyListeners();
  }
}
