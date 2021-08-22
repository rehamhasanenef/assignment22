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

class AuthProvider extends ChangeNotifier {
  TabController tabController;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cituController = TextEditingController();
  resetControllers() {
    emailController.clear();
    passwordController.clear();
  }

  register() async {
    try {
      UserCredential userCredential = await AuthHelper.authHelper
          .signup(emailController.text, passwordController.text);
      RegisterRequest registerRequest = RegisterRequest(
          id: userCredential.user.uid,
          city: cituController.text,
          country: countryController.text,
          email: emailController.text,
          fName: firstNameController.text,
          lName: lastNameController.text,
          password: passwordController.text);
      await FirestorHelper.firestorHelper.addUserToFirestore(registerRequest);
      await AuthHelper.authHelper.verifyEmail();
      await AuthHelper.authHelper.logout();
      tabController.animateTo(1);
    } on Exception catch (e) {
      // TODO
    }
// navigate to login

    resetControllers();
  }

  login() async {
    UserCredential userCredinial = await AuthHelper.authHelper
        .signin(emailController.text, passwordController.text);
    FirestorHelper.firestorHelper
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
  }