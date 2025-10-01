import 'package:agri_expert/auth/login_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:google_fonts/google_fonts.dart';

import '../auth/sign_up_view.dart';

class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();

  final List<OnboardingItem> onboardingData = [
    OnboardingItem(
      image: "assets/images/Frame 134.png",
      title: "Get Rid of Third\nPerson",
      description:
      "Using this application you can get rid of paying commission, free to chat, approach sellers and deal with them.",
    ),
    OnboardingItem(
      image: "assets/images/Rectangle 11.png",
      title: "Help in Market\nAnalysis",
      description:
      "You'll have all the market analysis in your pocket. You'll get to know the cheapest and genuine market rates.",
    ),
    OnboardingItem(
      image: "assets/images/Frame 134 (1).png",
      title: "Multilingual",
      description:
      "Easily register your store on the platform and save as a buyer your preferred items and search purchase them directly.",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4F6FB),
      body: PageView.builder(
        controller: _controller,
        itemCount: onboardingData.length,
        itemBuilder: (context, index) {
          final item = onboardingData[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 74),
              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 312,
                  width: 270,
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Positioned(
                        left: 40,
                        child: Transform.rotate(
                          angle: 0.04,
                          origin: const Offset(20, 20),
                          child: Container(
                            width: 400,
                            height: 312,
                            decoration: BoxDecoration(
                              color: const Color(0xff339D44).withValues(alpha: 0.2),
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(10),
                                topLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        bottom: 30,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10),
                          ),
                          child: Image.asset(
                            item.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 29),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 93),
                    Text(
                      item.title,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFF292929),
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      item.description,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.raleway(
                        color: const Color(0xFFB4B4B4),
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 50),
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          const SizedBox(),
                          SmoothPageIndicator(
                            controller: _controller,
                            count: onboardingData.length,
                            effect: WormEffect(
                              dotHeight: 8,
                              dotWidth: 8,
                              activeDotColor: const Color(0xFF339D44),
                              dotColor: const Color(0xFFB4B4B4).withValues(alpha: 0.7),
                            ),
                          ),
                          const SizedBox(width: 110),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                            },
                            child: const Text(
                              "Skip",
                              style: TextStyle(
                                color: Color(0xFF339D44),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}