import 'package:cached_network_image/cached_network_image.dart';
import 'package:citizen_femme/controller/controllers/blog_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:readmore/readmore.dart';

import 'blog_details.dart';

class BlogList extends StatefulWidget {
  final int id;
  final String titleName;
  const BlogList({super.key, required this.id, required this.titleName});

  @override
  State<BlogList> createState() => _BlogListState();
}

class _BlogListState extends State<BlogList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BlogController>().getBlogList(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.titleName,
          style: GoogleFonts.domine(
            fontSize: 24,
          ),
        ),
      ),
      body: GetBuilder<BlogController>(builder: (state) {
        return state.isBlogLIstLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView.builder(
                  itemCount: state.blogListData.length,
                  itemBuilder: (BuildContext context, int index) {
                    var blogData = state.blogListData[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) {
                          return BlogDetails(
                            id: blogData.id!,
                          );
                        }));
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                blogData.title ?? "",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            CachedNetworkImage(
                              imageUrl: blogData.featuredImage ?? "",
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.info),
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            ReadMoreText(
                              blogData.shortContent!,
                              trimMode: TrimMode.Line,
                              trimLines: 2,
                              colorClickableText: Colors.black,
                              trimCollapsedText: 'Show more',
                              trimExpandedText: 'Show less',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 14,
                              ),
                              moreStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                              lessStyle: GoogleFonts.roboto(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            /* Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                blogData.shortContent ?? "",
                                textAlign: TextAlign.center,
                                style: GoogleFonts.roboto(
                                  fontSize: 14,
                                ),
                              ),
                            ), */
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
      }),
    );
  }
}
