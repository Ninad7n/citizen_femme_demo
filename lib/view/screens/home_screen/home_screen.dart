import 'dart:math';

import 'package:citizen_femme/controller/controllers/blog_controller.dart';
import 'package:citizen_femme/controller/repositories/auth_repo.dart';
import 'package:citizen_femme/view/screens/auth_sccrens/login_screen.dart';
import 'package:citizen_femme/view/screens/blogs_screen.dart/blog_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../services/assets.dart';
import '../support_screen/support_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<BlogController>().getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    Image.asset(
                      Assets.imagesLogo,
                      height: 40,
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.clear,
                      ),
                    )
                  ],
                ),
              ),
              const Divider(),
              GetBuilder<BlogController>(builder: (state) {
                return ListView(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  children: state.categoriesData.map((e) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 0, vertical: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return BlogList(
                                  id: e.id!,
                                  titleName: e.name!,
                                );
                              }));
                            },
                            child: ColoredBox(
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      e.name!,
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.domine(
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.chevron_right_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList() +
                      [
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return const SupportScreen();
                              }));
                            },
                            child: ColoredBox(
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      'Support',
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.domine(
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.chevron_right_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: GestureDetector(
                            onTap: () {
                              Get.find<AuthRepo>().clearSharedData();
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) {
                                return const LoginScreen();
                              }), (Route<dynamic> route) => false);
                            },
                            child: ColoredBox(
                              color: Colors.white,
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  children: [
                                    Text(
                                      'Log Out',
                                      textAlign: TextAlign.start,
                                      style: GoogleFonts.domine(
                                        fontSize: 17,
                                      ),
                                    ),
                                    const Spacer(),
                                    IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                        Icons.chevron_right_rounded,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                );
              }),
            ],
          ),
        ),
      ),
      appBar: AppBar(
        leadingWidth: 50,
        leading: Builder(builder: (context) {
          return GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                Assets.svgsQuillHamburger,
              ),
            ),
          );
        }),
        centerTitle: true,
        title: Image.asset(
          Assets.imagesLogo,
          height: 40,
        ),
        /* Column(
          children: [
            Text(
              "Citizen Femme".toUpperCase(),
              style: GoogleFonts.domine(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "The Stylish Guide for the female traveller",
              style: GoogleFonts.roboto(
                fontSize: 10,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ), */
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SvgPicture.asset(
              Assets.svgsMaterialSymbolsSearch,
            ),
          ),
        ],
      ),
      body: GetBuilder<BlogController>(builder: (state) {
        return state.isLoading
            ? const Center(
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            : ListView(
                children: [
                  GridView(
                    physics: const NeverScrollableScrollPhysics(),
                    // itemCount: state.categoriesData.length,
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.1,
                    ),
                    children: state.categoriesData.map((blog) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return BlogList(
                              id: blog.id!,
                              titleName: blog.name!,
                            );
                          }));
                        },
                        child: Column(
                          children: [
                            Image.asset(state.imageString[
                                Random().nextInt(state.imageString.length)]),
                            const Spacer(),
                            Text(
                              blog.name!,
                              style: GoogleFonts.domine(
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),

                            // CachedNetworkImage(imageUrl: blog.,),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Center(
                    child: Text(
                      "Blog Details",
                      style: GoogleFonts.domine(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  SizedBox(
                    height: 180,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 6,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: SizedBox(
                              width: 160,
                              child: Column(
                                children: [
                                  Image.asset(Assets.imagesBottomImage),
                                  const Spacer(),
                                  Text(
                                    "Lorem Ipsum is simply dummy text of the printing and typesetting industry",
                                    maxLines: 3,
                                    style: GoogleFonts.domine(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  Image.asset(
                    Assets.imagesFooterImage,
                    width: double.infinity,
                    fit: BoxFit.fill,
                  ),
                ],
              );
      }),
    );
  }
}
