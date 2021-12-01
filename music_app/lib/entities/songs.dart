class Song {
  String id;
  String title;
  String duration;
  String path;
  String imagePath;
  String artist;
  String album;

  Song({
    required this.id,
    required this.title,
    required this.path,
    required this.imagePath,
    required this.artist,
    required this.album,
    required this.duration,
  });

  factory Song.fromJson(Map<String, dynamic> json) {
    return Song(
      id: json['id'] as String,
      title: json['title'] as String,
      duration: json['duration'] as String,
      path: json['path'] as String,
      imagePath: json['image_path'] as String,
      artist: json['artist'] as String,
      album: json['album'] as String,
    );
  }
}
