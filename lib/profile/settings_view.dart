import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          backgroundColor: const Color(0xFFFFFFFF),
          elevation: 0,
          title: Text(
            "Settings",
            style: GoogleFonts.raleway(
              fontSize: 23,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF292929),
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Color(0xff339D44)),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Account",
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Color(0xffD4D4D4)),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Rate our app",
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Color(0xffD4D4D4)),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  const ImageIcon(AssetImage("assets/icons/ant-design_logout-outlined.png"),
                      size: 24, color: Color(0xffF24E1E)),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Loguot",
                    style: GoogleFonts.raleway(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFFF24E1E),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
