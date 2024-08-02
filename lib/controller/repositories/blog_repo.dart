import 'package:shared_preferences/shared_preferences.dart';

import '../../services/api_services.dart';

class BlogRepo {
  final SharedPreferences prefs;
  BlogRepo({required this.prefs});

  static const String _getCategories = "custom/v1/categories";
  static const String _getBlogList = "custom/v1/posts";
  static const String _getBlogDetails = "custom/v1/post/";

  Future getCategoriesCall() async {
    return await ApiCalls().apiCallWithResponseGet(_getCategories);
  }

  Future getBlogListCall(id) async {
    return await ApiCalls()
        .apiCallWithResponseGet("$_getBlogList?category_id=$id");
  }

  Future getBlogDetailsCall(id) async {
    return await ApiCalls().apiCallWithResponseGet("$_getBlogDetails$id");
  }
}
