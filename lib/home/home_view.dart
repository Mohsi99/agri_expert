import 'package:flutter/material.dart';

import 'Widget/Dashboard_Card.dart';

import 'package:google_fonts/google_fonts.dart';


class HomeView extends StatelessWidget {
  HomeView({super.key});

  final List<DashboardItem> items = [
    DashboardItem(
      title: "Total Questions",
      value: "224",
      iconPath:"assets/icons/bi_question (1).png", // you add in assets
    ),
    DashboardItem(
      title: "Answered\n Questions",
      value: "154",
      iconPath: "assets/icons/Vector (4).png",
    ),
    DashboardItem(
      title: "Total Views",
      value: "1.5k",
      iconPath: "assets/icons/carbon_cube-view.png"
    ),
    DashboardItem(
      title: "Total Videos",
      value: "12",
      iconPath: "assets/icons/Frame 109.png"
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
               Text(
                "Dashboard!",
                style: GoogleFonts.raleway(
                  color: Color(0xff292929),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Welcome to Dashboard",
                style: GoogleFonts.raleway(
                  fontSize: 14,
                  color: Color(0xffD4D4D4),
                ),
              ),
              const SizedBox(height: 30),

              /// Grid for cards
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  mainAxisSpacing: 11,
                  crossAxisSpacing: 9,
                  childAspectRatio: 1.5,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return DashboardCard(
                    title: item.title,
                    value: item.value,
                    iconPath: item.iconPath,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
class DashboardItem {
  final String title;
  final String value;
  final String iconPath; // asset path for the image/icon

  DashboardItem({
    required this.title,
    required this.value,
    required this.iconPath,
  });
}