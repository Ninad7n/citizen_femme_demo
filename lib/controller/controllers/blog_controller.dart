import 'dart:developer';

import 'package:citizen_femme/controller/repositories/blog_repo.dart';
import 'package:citizen_femme/services/assets.dart';
import 'package:get/get.dart';

import '../../model/resp/blog_categories_model.dart';
import '../../model/resp/blog_details_model.dart';
import '../../model/resp/blog_list_model.dart';

class BlogController extends GetxController implements GetxService {
  final BlogRepo blogRepo;
  BlogController({required this.blogRepo});

  List<BlogCategoriesModel> categoriesData = [];
  List<BlogListModel> blogListData = [];
  bool isLoading = false;
  bool isBlogLIstLoading = false;

  List<String> imageString = [
    Assets.imagesImage1,
    Assets.imagesImage2,
    Assets.imagesImage3,
    Assets.imagesImage4,
  ];

  Future getCategories() async {
    isLoading = true;
    update();
    try {
      await blogRepo.getCategoriesCall().then((value) {
        log(value, name: "getCategoriesCall");
        if (value != null) ;
        categoriesData = blogCategoriesModelFromJson(value);
      });
    } catch (e) {
      log('$e', name: 'ERROR AT getCategories');
    }
    isLoading = false;
    update();
  }

  Future getBlogList(id) async {
    isBlogLIstLoading = true;
    update();
    try {
      await blogRepo.getBlogListCall(id).then((value) {
        log("$value", name: "getBlogList");
        if (value != null) {
          blogListData = blogListModelFromJson(value);
        }
      });
    } catch (e) {
      log('$e', name: 'ERROR AT getBlogList');
    }
    isBlogLIstLoading = false;
    update();
  }

  Future<BlogDetailsModel?> getBlogDetails(id) async {
    try {
      return await blogRepo.getBlogDetailsCall(id).then((value) {
        log("$value", name: "getBlogDetails");
        return blogDetailsModelFromJson(value);
      });
    } catch (e) {
      log('$e', name: 'ERROR AT getBlogDetails');
      return null;
    }
  }
}
