import 'package:citizen_femme/controller/controllers/auth_controller.dart';
import 'package:citizen_femme/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: GetBuilder<AuthController>(builder: (aState) {
            return Form(
              key: AppConstants.loginFormkey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Login",
                      style: GoogleFonts.domine(
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Username/Email",
                    style: GoogleFonts.domine(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: aState.userName,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(40),
                    ],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Invalid Text";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Password",
                    style: GoogleFonts.domine(
                      fontWeight: FontWeight.normal,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: aState.password,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Invalid Text";
                      }
                      return null;
                    },
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(15),
                    ],
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: aState.isRememberMe,
                        visualDensity: VisualDensity.compact,
                        onChanged: (value) {
                          aState.changeStatus();
                        },
                      ),
                      Text(
                        "Remember Me",
                        style: GoogleFonts.domine(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  MaterialButton(
                    elevation: 0,
                    minWidth: double.infinity,
                    color: Colors.black,
                    onPressed: aState.isLoading
                        ? () {}
                        : () {
                            aState.makeLoginUser();
                          },
                    child: Center(
                      child: aState.isLoading
                          ? const Center(
                              child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ))
                          : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Text(
                                "Log In",
                                style: GoogleFonts.domine(
                                  fontWeight: FontWeight.normal,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Fluttertoast.cancel();
                        Fluttertoast.showToast(
                            msg: "Not authorised to create an account!");
                      },
                      child: RichText(
                        text: TextSpan(
                          text: "Don’t have an account?",
                          style: GoogleFonts.domine(
                            fontWeight: FontWeight.normal,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: [
                            TextSpan(
                              text: " Register here",
                              style: GoogleFonts.domine(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
