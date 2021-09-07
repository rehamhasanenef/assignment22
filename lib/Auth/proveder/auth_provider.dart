import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsg2_app/Auth/helpers/auth_helper.dart';
import 'package:gsg2_app/Auth/helpers/firstore_helper.dart';
import 'package:gsg2_app/Auth/models/register_request.dart';
import 'package:gsg2_app/Auth/ui/login_page .dart';
import 'package:gsg2_app/chats/home_page.dart';
import 'package:gsg2_app/services/custom_dialoug.dart';
import 'package:gsg2_app/services/routes_helper.dart';
import 'package:gsg2_app/Auth/models/contre.dart';
import 'package:gsg2_app/Auth/helpers/firestorage_helper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gsg2_app/Auth/ui/register_page.dart';
import 'package:gsg2_app/Auth/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    getCountriesFromFirestore();
  }
  TabController tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cituController = TextEditingController();


  UserModel user;
  getUserFromFirestore() async {
    String userId = AuthHelper.authHelper.getUserId();
    user = await FirestoreHelper.firestoreHelper.getUserFromFirestore(userId);
    notifyListeners();
  }
  
  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  List<CountryModel> countries;
  List<dynamic> cites = [];
  CountryModel selectedCountry;
  String selectedCity;
  selectCountry(CountryModel countryModel) {
    this.selectedCountry = countryModel;
    this.cites = countryModel.cites;
    selectCity(cites.first.toString());
    notifyListeners();
  }

  selectCity(dynamic cites) {
    this.selectedCity = cites;
    notifyListeners();
  }

  getCountriesFromFirestore() async {
    List<CountryModel> countries =
        await FirestoreHelper.firestoreHelper.getAllCountries();
    this.countries = countries;
    selectCountry(countries.first);
    notifyListeners();
  }

  ///////////////////////////////////////////////////
  ///upload Image
  File file;
  selectFile() async {
    File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.file = File(imageFile.path);
    notifyListeners();
  }

///////////////////////////////////////////////////

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      String imageUrl =
          await FirebaseStorageHelper.firebaseStorageHelper.uploadImage(file);
      RegisterRequest registerRequest = RegisterRequest(
          imageUrl: imageUrl,
          id: userCredential.user.uid,
          city: selectedCity,
          country: selectedCountry.name,
          email: emailController.text,
          fName: firstNameController.text,
          lName: lastNameController.text,
          password: passwordController.text);
      FirestoreHelper.firestoreHelper.addUserToFirestore(registerRequest);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logout();
      tabController.animateTo(1);
    } on Exception catch (e) {
      // TODO
    }
// navigate to login

    resetControllers();
  }
  logout() async {
    await AuthHelper.authHelper.logout();
    RouteHelper.routeHelper.goToPageWithReplacement(Register.routeName);
  }

  login() async {
    UserCredential userCredinial = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    FirestoreHelper.firestoreHelper
        .getUserFromFirestore(userCredinial.user.uid);
    RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);

    resetControllers();
  }

  sendVericiafion() {
    AuthHelper.authHelper.verifyEmail();
    AuthHelper.authHelper.logout();
  }

  resetPassword() async {
    AuthHelper.authHelper.resetPassword(emailController.text);
    resetControllers();
  }

  checkLogin() {
    bool isLoggedIn = AuthHelper.authHelper.checkUserLoging();

    if (isLoggedIn) {
      //this.myId = AuthHelper.authHelper.getUserId();
      //  getAllUsers();
      RouteHelper.routeHelper.goToPageWithReplacement(HomePage.routeName);
    } else {
      RouteHelper.routeHelper.goToPageWithReplacement(Register.routeName);
    }
  }
}
