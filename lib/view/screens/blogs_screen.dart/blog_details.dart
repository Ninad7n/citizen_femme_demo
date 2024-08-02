import 'package:cached_network_image/cached_network_image.dart';
import 'package:citizen_femme/controller/controllers/blog_controller.dart';
import 'package:citizen_femme/services/assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BlogDetails extends StatelessWidget {
  final int id;
  const BlogDetails({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Blog Details",
          style: GoogleFonts.domine(
            fontSize: 24,
          ),
        ),
      ),
      body: FutureBuilder(
        future: Get.find<BlogController>().getBlogDetails(id),
        builder: (BuildContext context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || snapshot.data == null) {
            return Text(
              "No data found",
              style: GoogleFonts.domine(
                fontSize: 24,
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              shrinkWrap: true,
              children: [
                CachedNetworkImage(
                  imageUrl: snapshot.data!.featuredImageUrl ?? "",
                  errorWidget: (context, url, error) => const Icon(Icons.info),
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
                ),
                const Divider(),
                IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        Assets.imagesProfile,
                        height: 45,
                        width: 45,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        snapshot.data!.authorName ?? "",
                        style: GoogleFonts.domine(
                          fontSize: 14,
                        ),
                      ),
                      const VerticalDivider(
                        // width: 1,
                        thickness: 2,
                      ),
                      Text(
                        snapshot.data!.createdDate ?? "",
                        style: GoogleFonts.domine(
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),

                Builder(builder: (context) {
                  return HtmlWidget(
                    // shrinkWrap: true,
                    snapshot.data!.content ?? "",
                  );
                })
                // Text(
                //   parseHtmlString(snapshot.data!.content!),
                //   style: GoogleFonts.domine(
                //     fontSize: 14,
                //   ),
                // ),
              ],
            ),
          );
        },
      ),
    );
  }
}
