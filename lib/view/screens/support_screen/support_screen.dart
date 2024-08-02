import 'package:citizen_femme/controller/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:google_fonts/google_fonts.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Contact Us",
          style: GoogleFonts.domine(
            fontSize: 24,
          ),
        ),
      ),
      body: GetBuilder<AuthController>(builder: (state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Username*",
                style: GoogleFonts.domine(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: state.sUserName,
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
                height: 20,
              ),
              Text(
                "Email*",
                style: GoogleFonts.domine(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: state.sEmail,
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
                height: 20,
              ),
              Text(
                "Subject*",
                style: GoogleFonts.domine(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: state.sSubjet,
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
                height: 20,
              ),
              Text(
                "Message*",
                style: GoogleFonts.domine(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: state.sMessage,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(200),
                ],
                maxLines: 4,
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
                height: 20,
              ),
              MaterialButton(
                elevation: 0,
                minWidth: double.infinity,
                color: Colors.black,
                onPressed: state.isLoading
                    ? () {}
                    : () {
                        state.submitContactUs();
                      },
                child: Center(
                  child: state.isLoading
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
                            "Submit",
                            style: GoogleFonts.domine(
                              fontWeight: FontWeight.normal,
                              fontSize: 24,
                              color: Colors.white,
                            ),
                          ),
                        ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
