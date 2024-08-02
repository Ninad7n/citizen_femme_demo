import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/instance_manager.dart';
import 'package:http/http.dart' as http;
import '../../services/constants.dart';
import '../controller/repositories/auth_repo.dart';

class ApiCalls {
  String? token;
  Map<String, String>? mainHeaders;

  apiToasts(http.Response res, {url}) {
    Fluttertoast.cancel();
    try {
      if ((jsonDecode(res.body) as Map)['status'] == "error") {
        if ((jsonDecode(res.body) as Map).containsKey('message')) {
          showCustomToast("${jsonDecode(res.body)['message']}",
              color: url == null ? null : Colors.red);
          log("${jsonDecode(res.body)['message']}",
              name:
                  "${DateTime.now().toString().split(' ')[1]}->HANDLERS->${url ?? ""}");
        } else if ((jsonDecode(res.body) as Map).containsKey('msg')) {
          showCustomToast("${jsonDecode(res.body)['msg']}",
              color: url == null ? null : Colors.red);

          log("${jsonDecode(res.body)['msg']}",
              name:
                  "${DateTime.now().toString().split(' ')[1]}->HANDLERS->${url ?? ""}");
        } else if ((jsonDecode(res.body) as Map).containsKey('error')) {
          showCustomToast("${jsonDecode(res.body)['error']}",
              color: url == null ? null : Colors.red);
          log("${jsonDecode(res.body)['error']}",
              name:
                  "${DateTime.now().toString().split(' ')[1]}->HANDLERS->${url ?? ""}");
        }
      }
    } catch (e) {
      log('$e', name: "ERROR AT API HANDLER");
    }
  }

  showResponse(
    http.Response response,
    Map<String, dynamic>? postBody,
    String url,
    token,
  ) {
    log("TYPE : ${postBody == null ? "GET" : "POST ${DateTime.now().toString().split(' ')[1]}"}\nURL : $url\nTOKEN : $token\nPOSTBODY : $postBody\nRESPONSE CODE : ${response.statusCode}\nRESPONSE : ${response.body}\n",
        name: "API CALL");
  }

  showCustomToast(msg, {color}) {
    Fluttertoast.showToast(msg: "$msg", backgroundColor: color ?? Colors.black);
  }

  Future<dynamic> apiCallWithResponsePost(
      String extUrl, Map<String, dynamic> body) async {
    mainHeaders = {
      'Content-Type': 'application/json',
      'Authorization':
          'Bearer ${token = (Get.find<AuthRepo>().getUserToken())}',
    };
    var url = AppConstants.baseUrl + extUrl;
    try {
      http.Response response = await http.post(
        Uri.parse(url),
        body: jsonEncode(body),
        headers: mainHeaders,
      );
      showResponse(response, body, url, token);
      apiToasts(response, url: url);
      return response.body;
    } catch (e) {
      log('$url -Error catching data', name: e.toString());
      Fluttertoast.showToast(msg: "Something went wrong !! ");
      return "failed";
    }
  }

  Future<dynamic> apiCallWithResponseGet(String extUrl) async {
    mainHeaders = {
      'Accept': 'application/json',
      // 'Authorization':
      //     'Bearer ${token = (getx.Get.find<AuthRepo>().getUserToken())}',
    };
    var url = AppConstants.baseUrl + extUrl;
    try {
      http.Response response = await http.get(
        Uri.parse(url),
        headers: mainHeaders,
      );
      showResponse(response, null, url, token);
      return (response.body);
    } catch (e) {
      log('$url -Error catching data', name: e.toString());
      Fluttertoast.showToast(msg: "Something went wrong !! ");
      return "failed";
    }
  }
}
