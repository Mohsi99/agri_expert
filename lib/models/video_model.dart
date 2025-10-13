class VideoModel {
  final String videoId;
  final String userId;
  final String title;
  final String description;
  final String thumbnailUrl;
  final String videoUrl;
  final DateTime createdAt;

  VideoModel({
    required this.videoId,
    required this.userId,
    required this.title,
    required this.description,
    required this.thumbnailUrl,
    required this.videoUrl,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'videoId': videoId,
      'userId': userId,
      'title': title,
      'description': description,
      'thumbnailUrl': thumbnailUrl,
      'videoUrl': videoUrl,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  factory VideoModel.fromMap(Map<String, dynamic> map) {
    return VideoModel(
      videoId: map['videoId'] ?? '',
      userId: map['userId'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      thumbnailUrl: map['thumbnailUrl'] ?? '',
      videoUrl: map['videoUrl'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
    );
  }
}