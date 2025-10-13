import 'package:agri_expert/models/video_model.dart';
import 'package:agri_expert/questions/widgets/Custom%20TabBar.dart';
import 'package:agri_expert/trending_videos/trending_videos_search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../services/video_service.dart';
import 'Widget/video_card.dart';
import 'add_vidoea_view.dart';

class TrendingVideosScreen extends StatefulWidget {
  const TrendingVideosScreen({super.key});

  @override
  State<TrendingVideosScreen> createState() => _TrendingVideosScreenState();
}

class _TrendingVideosScreenState extends State<TrendingVideosScreen> {
  int selectedTab = 0;

  final List<String> tabs = ["All", "Recently Uploaded"];
  final VideoService _videoService = VideoService();

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTabBar(
              tabs: tabs,
              onTabSelected: (index) {
                print("Selected Video Tab: $index");
              },
            ),

            const SizedBox(height: 25),

            Expanded(
              child: StreamProvider.value(
                value: _videoService.streamAllVideos(),
                initialData: <VideoModel>[],
                builder: (context, child) {
                  final videos = context.watch<List<VideoModel>>();
                  return ListView.builder(
                    itemCount: videos.length,
                    itemBuilder: (context, index) {
                      final v = videos[index];
                      return VideoCard(
                        video: v,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
