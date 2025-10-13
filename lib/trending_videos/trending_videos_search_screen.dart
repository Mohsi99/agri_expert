import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/video_model.dart';
import '../services/video_service.dart';
import 'Widget/video_card.dart';

class TrendingVideosSearchScreen extends StatefulWidget {
  const TrendingVideosSearchScreen({super.key});

  @override
  State<TrendingVideosSearchScreen> createState() => _TrendingVideosSearchScreenState();
}

class _TrendingVideosSearchScreenState extends State<TrendingVideosSearchScreen> {
  int selectedTab = 0;
  final TextEditingController _searchController = TextEditingController();
  final VideoService _videoService = VideoService();
  String _searchQuery = "";

  final List<String> tabs = ["All", "Recently Uploaded"];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<VideoModel> _filterVideos(List<VideoModel> videos) {
    if (_searchQuery.isEmpty) {
      return videos;
    }
    return videos.where((video) {
      return video.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();
  }

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
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close, color: Color(0xff339D44)),
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Search bar
            TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              style: GoogleFonts.raleway(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: const Color(0xFF292929),
              ),
              decoration: InputDecoration(
                hintText: "Search videos...",
                hintStyle: GoogleFonts.raleway(
                  color: const Color(0xFFB4B4B4),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                prefixIcon: const Icon(Icons.search, color: Color(0xFFB4B4B4)),
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

            /// Video List
            Expanded(
              child: StreamProvider.value(
                value: _videoService.streamAllVideos(),
                initialData: <VideoModel>[],
                builder: (context, child) {
                  final videos = context.watch<List<VideoModel>>();
                  final filteredVideos = _filterVideos(videos);

                  if (filteredVideos.isEmpty) {
                    return Center(
                      child: Text(
                        _searchQuery.isEmpty ? "No videos available" : "No videos found",
                        style: GoogleFonts.raleway(
                          fontSize: 16,
                          color: const Color(0xFFB4B4B4),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: filteredVideos.length,
                    itemBuilder: (context, index) {
                      final v = filteredVideos[index];
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