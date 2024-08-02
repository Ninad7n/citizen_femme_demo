import 'package:citizen_femme/controller/controllers/auth_controller.dart';
import 'package:citizen_femme/controller/repositories/auth_repo.dart';
import 'package:citizen_femme/controller/repositories/blog_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/controllers/blog_controller.dart';

class Init {
  static Future initialize() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    Get.lazyPut(() => prefs);
    Get.lazyPut(() => AuthRepo(prefs: Get.find()));
    Get.lazyPut(() => BlogRepo(prefs: Get.find()));

    Get.lazyPut(() => AuthController(authRepo: Get.find()));
    Get.lazyPut(() => BlogController(blogRepo: Get.find()));
  }
}
