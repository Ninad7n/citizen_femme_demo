import 'package:citizen_femme/services/api_services.dart';
import 'package:citizen_femme/services/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final SharedPreferences prefs;
  AuthRepo({required this.prefs});

  static const String _loginUser = "custom/v1/login";
  static const String _contactUsData = "gf/v2/forms/1/submissions";

  Future lognUserCall(data) async {
    return await ApiCalls().apiCallWithResponsePost(_loginUser, data);
  }

  Future contactUsDataCall(data) async {
    return await ApiCalls().apiCallWithResponsePost(_contactUsData, data);
  }

  String? getUserToken() {
    return prefs.getString(AppConstants.userToken);
  }

  setUserToken(token) async {
    return await prefs.setString(AppConstants.userToken, token);
  }

  clearSharedData() {
    prefs.clear();
  }

  bool isEmail(data) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(data);
  }
}
