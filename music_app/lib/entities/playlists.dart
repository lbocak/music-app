class Playlist {
  String id;
  String title;
  String imagePath;
  String description;
  String creator;

  Playlist(
      {required this.id,
      required this.title,
      required this.imagePath,
      required this.description,
      required this.creator});

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
        id: json['id'] as String,
        title: json['title'] as String,
        imagePath: json['image_path'] as String,
        description: json['description'] as String,
        creator: json['creator'] as String);
  }
}
