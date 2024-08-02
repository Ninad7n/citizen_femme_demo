import 'package:citizen_femme/controller/controllers/auth_controller.dart';
import 'package:citizen_femme/view/screens/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/assets.dart';
import '../auth_sccrens/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2)).then((value) {
      if (Get.find<AuthController>().authRepo.getUserToken() == null) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const LoginScreen();
        }));
      } else {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return const HomeScreen();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Image.asset(
            Assets.imagesLogo,
          ),
        ),
      ),
    );
  }
}
