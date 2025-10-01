import 'package:agri_expert/questions/widgets/Custom%20TabBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Widget/video_card.dart';
import 'comment_view.dart';

class TrendingVideosSearchScreen extends StatefulWidget {
  const TrendingVideosSearchScreen({super.key});

  @override
  State<TrendingVideosSearchScreen> createState() => _TrendingVideosSearchScreenState();
}

class _TrendingVideosSearchScreenState extends State<TrendingVideosSearchScreen> {
  int selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();
  String query = "";

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
      title: "How to buy a Tractor",
      thumbnail: "assets/images/Video.png",
      uploadedDate: "21 Oct 2021 Monday",
      views: "250",
      comments: "35",
    ),
    TrendingVideo(
      title: "How to buy a Crane",
      thumbnail: "assets/images/Video.png",
      uploadedDate: "1 day ago",
      views: "120",
      comments: "12",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    // filter videos by query
    final filteredVideos = videos
        .where((v) =>
        v.title.toLowerCase().contains(query.toLowerCase().trim()))
        .toList();

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
            onPressed: () {},
            icon: const Icon(Icons.close, color: Color(0xff339D44)),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search bar
            TextField(
              controller: _searchController,
              onChanged: (val) {
                setState(() {
                  query = val;
                });
              },
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0xFF292929),
              ),
              decoration: InputDecoration(
                hintText: "Search Tractor...",
                hintStyle: GoogleFonts.raleway(
                  color: const Color(0xFFB4B4B4),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12),
                border: OutlineInputBorder(
                  borderSide: const BorderSide(width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFFB4B4B4)),
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0xFF339D44)),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),

            const SizedBox(height: 20),


            /// Video list
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredVideos.length,
              itemBuilder: (context, index) {
                final v = filteredVideos[index];
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