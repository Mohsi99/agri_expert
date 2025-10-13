import 'package:flutter/material.dart';
import '../models/video_model.dart';
import '../services/video_service.dart';

class VideoProvider with ChangeNotifier {
  final VideoService _videoService = VideoService();
  bool _isUploading = false;
  bool get isUploading => _isUploading;

  Future<void> uploadVideo({
    required String userId,
    required String title,
    required String description,
    required String thumbnailUrl,
    required String videoUrl,
  }) async {
    try {
      _isUploading = true;
      notifyListeners();

      final video = VideoModel(
        videoId: DateTime.now().millisecondsSinceEpoch.toString(),
        userId: userId,
        title: title,
        description: description,
        thumbnailUrl: thumbnailUrl,
        videoUrl: videoUrl,
        createdAt: DateTime.now(),
      );

      await _videoService.uploadVideo(video);
    } catch (e) {
      debugPrint("Error uploading video: $e");
    } finally {
      _isUploading = false;
      notifyListeners();
    }
  }
}