class MorningModel {
  final String title;
  final String artist;
  final String image;
  final String audio;
  final String duration;
  final String category;

  MorningModel({
    required this.title,
    required this.artist,
    required this.image,
    required this.audio,
    required this.duration,
    required this.category,
  });

  factory MorningModel.fromJson(Map<String, dynamic> json) {
    return MorningModel(
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      image: json['image'] ?? '',
      audio: json['audio'] ?? '',
      duration: json['duration'] ?? '',
      category: json['category'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'image': image,
      'audio': audio,
      'duration': duration,
      'category': category,
    };
  }
}
