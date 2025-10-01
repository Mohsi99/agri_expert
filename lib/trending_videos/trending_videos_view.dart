import 'package:agri_expert/questions/widgets/Custom%20TabBar.dart';
import 'package:agri_expert/trending_videos/trending_videos_search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widget/video_card.dart';
import 'add_vidoea_view.dart';
import 'comment_view.dart';

class TrendingVideosScreen extends StatefulWidget {
  const TrendingVideosScreen({super.key});

  @override
  State<TrendingVideosScreen> createState() => _TrendingVideosScreenState();
}

class _TrendingVideosScreenState extends State<TrendingVideosScreen> {
  int selectedTab = 0;

  final List<String> tabs = ["All", "Recently Uploaded"];

  final List<TrendingVideo> videos = [
    TrendingVideo(
      title: "How to Start A Tractor",
      thumbnail: "assets/images/Frame 19.png",
      uploadedDate: "15 mins ago",
      views: "139",
      comments: "22",
    ),
    TrendingVideo(
      title: "How to buy a Crane",
      thumbnail: "assets/images/Video.png",
      uploadedDate: "21 Oct 2021 Monday",
      views: "250",
      comments: "35",
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFFFFF),
        elevation: 0,
        title: Text(
          "Training Videos",
          style: GoogleFonts.raleway(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF292929),
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => TrendingVideosSearchScreen(),
                  ));
            },
            icon: const Icon(CupertinoIcons.search, color: Color(0xff339D44)),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddVideoScreen(),
                  ));
            },
            icon: const Icon(Icons.add, color: Color(0xff339D44)),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TabBar
            CustomTabBar(
              tabs: tabs,
              onTabSelected: (index) {
                print("Selected Video Tab: $index");
              },
            ),

            const SizedBox(height: 25),

            /// Video list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: videos.length,
              itemBuilder: (context, index) {
                final v = videos[index];
                return VideoCard(
                  title: v.title,
                  thumbnail: v.thumbnail,
                  uploadedDate: v.uploadedDate,
                  views: v.views,
                  comments: v.comments,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingVideo {
  final String title;
  final String thumbnail; // local asset ya network image
  final String uploadedDate; // "15 mins ago" ya "21 Oct 2021 Monday"
  final String views;
  final String comments;

  TrendingVideo({
    required this.title,
    required this.thumbnail,
    required this.uploadedDate,
    required this.views,
    required this.comments,
  });
}
