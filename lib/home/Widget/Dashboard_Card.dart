import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardCard extends StatelessWidget {
  final String title;
  final String value;
  final String iconPath;

  const DashboardCard({
    Key? key,
    required this.title,
    required this.value,
    required this.iconPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 154,
      height: 105,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFD4D4D4).withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0,top: 23,bottom: 14,right: 9),
        child: Row(
          children: [
            Image.asset(
              iconPath,
              width: 48,
              height: 48,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  value,
                  style:  GoogleFonts.raleway(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff292929)
                  ),
                ),
                Text(
                  title,
                  style: GoogleFonts.raleway(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,

                      color: Color(0xff292929)
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}