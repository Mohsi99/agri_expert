import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_view.dart';

class RatingsReviewsView extends StatelessWidget {
  final List<ReviewModel> reviews;

  const RatingsReviewsView({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        title: Text(
          "Ratings & Reviews",
          style: GoogleFonts.raleway(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF292929),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xff339D44)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        itemCount: reviews.length,
        itemBuilder: (context, index) {
          final r = reviews[index];
          return reviewTile(r);
        }, separatorBuilder: (BuildContext context, int index) { return SizedBox(height: 20,); },
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