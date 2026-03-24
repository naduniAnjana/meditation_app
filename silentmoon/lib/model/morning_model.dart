class MorningModel {
  final String title;
  final String artist;
  final String image;
  final String audio;
  final String duration;

  MorningModel({
    required this.title,
    required this.artist,
    required this.image,
    required this.audio,
    required this.duration,
  });

  factory MorningModel.fromJson(Map<String, dynamic> json) {
    return MorningModel(
      title: json['title'] ?? '',
      artist: json['artist'] ?? '',
      image: json['image'] ?? '',
      audio: json['audio'] ?? '',
      duration: json['duration'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'artist': artist,
      'image': image,
      'audio': audio,
      'duration': duration,
    };
  }
}
