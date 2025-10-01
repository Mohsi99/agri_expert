import 'package:agri_expert/profile/edit_profile_view.dart';
import 'package:agri_expert/profile/ratings_reviews_view.dart';
import 'package:agri_expert/profile/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ReviewModel> reviews = [
      ReviewModel(
        name: "Fareeha Sadaqat",
        review: "Recommended Expert.",
        stars: 5,
        timeAgo: "20 mins ago",
        profileImage: "assets/images/Ellipse 7.png",
      ),
      ReviewModel(
        name: "Masab Mehmood",
        review: "Very Patient and Honest.",
        stars: 4,
        timeAgo: "1 hour ago",
        profileImage: "assets/images/Ellipse 7 (1).png",
      ),
      ReviewModel(
        name: "Muhammad Ali",
        review: "Very patient. Totally Recommended Expert.",
        stars: 4,
        timeAgo: "Yesterday",
        profileImage: "assets/images/Ellipse 7.png",
      ),
      ReviewModel(
        name: "Muhammad Ali",
        review: "Very patient. Totally Recommended Expert.",
        stars: 3,
        timeAgo: "Yesterday",
        profileImage: "assets/images/Ellipse 7 (1).png",
      ),
      ReviewModel(
        name: "Muhammad Ali",
        review: "Recommended Expert.",
        stars: 2,
        timeAgo: "Yesterday",
        profileImage: "assets/images/Ellipse 7.png",
      ),
      ReviewModel(
        name: "Muhammad Ali",
        review: "Very patient. Totally Recommended Expert.",
        stars: 1,
        timeAgo: "Yesterday",
        profileImage: "assets/images/Ellipse 7.png",
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        title: Text(
          "Profile",
          style: GoogleFonts.raleway(
            fontSize: 23,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF292929),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingsView(),
                  ));
            },
            icon: ImageIcon(AssetImage("assets/icons/carbon_settings.png"),
                color: Color(0xff339D44)),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            /// Profile image + Name + Email
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage("assets/images/Ellipse 7.png"),
            ),
            const SizedBox(height: 12),
            Text(
              "Muhammad Wajahat",
              style: GoogleFonts.raleway(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF111111),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "mwajahat.038@gmail.com",
              style: GoogleFonts.raleway(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff339D44)),
            ),

            const SizedBox(height: 12),
            SizedBox(
              width: 129,
              height: 40,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF339D44),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditProfileView(),
                      ));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const ImageIcon(
                      AssetImage("assets/icons/Icons.png"),
                      size: 16,
                      color: Color(0xffF4F6FB),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      "Edit Profile",
                      style: GoogleFonts.raleway(
                        color: const Color(0xffF4F6FB),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Stats",
                  style: GoogleFonts.raleway(
                    fontSize: 13.33,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF292929),
                  ),
                ),
                Text(
                  "See Dashboard",
                  style: GoogleFonts.raleway(
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xff339D44),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 16,
            ),

            /// Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("252 Answered",
                    style: GoogleFonts.raleway(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF292929),
                    )),
                Text("71 Pending",
                    style: GoogleFonts.raleway(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF292929),
                    )),
                Text("14 Videos Uploaded",
                    style: GoogleFonts.raleway(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF292929),
                    )),
              ],
            ),

            const SizedBox(height: 25),

            /// Ratings & Reviews Heading
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Ratings & Reviews",
                  style: GoogleFonts.raleway(
                    fontSize: 13.33,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF292929),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RatingsReviewsView(reviews: reviews),
                      ),
                    );
                  },
                  child: Text(
                    "See all",
                    style: GoogleFonts.raleway(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xff339D44),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            /// Dynamic Reviews List
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3,
              itemBuilder: (context, index) {
                final r = reviews[index];
                return reviewTile(r);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget reviewTile(ReviewModel review) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Profile picture
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(review.profileImage),
          ),
          const SizedBox(width: 10),

          /// Right side content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Name + Stars Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      review.name,
                      style: GoogleFonts.raleway(
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF292929),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        review.stars,
                        (index) => Icon(Icons.star_border,
                            size: 12, color: const Color(0xff339D44)),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 3),

                /// Time ago
                Text(
                  review.timeAgo,
                  style: GoogleFonts.raleway(
                      fontSize: 9,
                      fontWeight: FontWeight.w400,
                      color: Color(0xffB4B4B4)),
                ),

                const SizedBox(height: 10),

                /// Review text
                Text(
                  review.review,
                  style: GoogleFonts.raleway(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF292929),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Review Model Class
class ReviewModel {
  final String name;
  final String review;
  final int stars;
  final String timeAgo;
  final String profileImage;

  ReviewModel({
    required this.name,
    required this.review,
    required this.stars,
    required this.timeAgo,
    required this.profileImage,
  });
}
