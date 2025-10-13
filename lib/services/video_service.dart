import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/video_model.dart';

class VideoService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> uploadVideo(VideoModel video) async {
    await _firestore.collection('videos').doc(video.videoId).set(video.toMap());
  }

  Future<List<VideoModel>> fetchAllVideos() async {
    final snapshot = await _firestore
        .collection('videos')
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs.map((doc) => VideoModel.fromMap(doc.data())).toList();
  }

  Stream<List<VideoModel>> streamAllVideos() {
    return _firestore
        .collection('videos')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => VideoModel.fromMap(e.data()),
              )
              .toList(),
        );
  }

  Stream<List<VideoModel>> streamVideosByUserId(String userId) {
    return _firestore
        .collection('videos')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => VideoModel.fromMap(e.data()),
              )
              .toList(),
        );
  }
  Stream<List<VideoModel>> streamOtherUserVideos(String userId) {
    return _firestore
        .collection('videos')
        .where('userId', isNotEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => VideoModel.fromMap(e.data()),
              )
              .toList(),
        );
  }

  Future<void> deleteVideo(String videoId) async {
    await _firestore.collection('videos').doc(videoId).delete();
  }
}
