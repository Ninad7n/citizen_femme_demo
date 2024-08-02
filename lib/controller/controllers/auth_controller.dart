import 'dart:developer';

import 'package:citizen_femme/controller/repositories/auth_repo.dart';
import 'package:citizen_femme/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../model/resp/user_model.dart';
import '../../view/screens/home_screen/home_screen.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({
    required this.authRepo,
  });

  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController sUserName = TextEditingController();
  TextEditingController sEmail = TextEditingController();
  TextEditingController sSubjet = TextEditingController();
  TextEditingController sMessage = TextEditingController();

  bool isRememberMe = false;
  bool isLoading = false;
  UserModel? userData;

  changeStatus() {
    isRememberMe = !isRememberMe;
    update();
  }

  clearData() {
    isRememberMe = false;
    userName.clear();
    password.clear();
    isLoading = false;
    sUserName.clear();
    sEmail.clear();
    sSubjet.clear();
    sMessage.clear();
  }

  Future makeLoginUser() async {
    try {
      if (AppConstants.loginFormkey.currentState!.validate()) {
        isLoading = true;
        update();
        await authRepo.lognUserCall(
          {
            "username": userName.text,
            "password": password.text,
          },
        ).then((value) {
          if (value != null) {
            userData = userModelFromJson(value);
            log("${userData!.toJson()}", name: "makeLoginUser");
            if (userData!.status == 'success') {
              if (isRememberMe) {
                authRepo.setUserToken(userData!.token);
              }
              clearData();
              Navigator.pushReplacement(
                  AppConstants.navigatorKey.currentContext!,
                  MaterialPageRoute(builder: (BuildContext context) {
                return const HomeScreen();
              }));
            }
          }
        });
      }
    } catch (e) {
      log('$e', name: 'ERROR AT makeLoginUser');
    }
    isLoading = false;
    update();
  }

  Future submitContactUs() async {
    if (sUserName.text.isEmpty ||
        sEmail.text.isEmpty ||
        sSubjet.text.isEmpty ||
        sMessage.text.isEmpty) {
      Fluttertoast.cancel();
      Fluttertoast.showToast(msg: "Invalid Data");
      return null;
    }
    if (!authRepo.isEmail(sEmail.text)) {
      Fluttertoast.showToast(msg: "Invalid Email");
      return null;
    }
    isLoading = true;
    update();
    await authRepo.contactUsDataCall({
      "input_1": sUserName.text,
      "input_3": sEmail.text,
      "input_4": sMessage.text,
      "input_5": sMessage.text,
    }).then((value) {
      Fluttertoast.showToast(msg: "Thank your for your response");
      clearData();
    });
    isLoading = false;
    update();
  }
}
