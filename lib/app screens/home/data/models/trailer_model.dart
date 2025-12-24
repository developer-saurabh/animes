class TrailerModel {
  final String? youtubeId;
  final String? embedUrl;

  TrailerModel({
    this.youtubeId,
    this.embedUrl,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      youtubeId: json['youtube_id'],
      embedUrl: json['embed_url'],
    );
  }
}
