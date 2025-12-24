import 'image_model.dart';
import 'genre_model.dart';
import 'studio_model.dart';
import 'trailer_model.dart';

class AnimeModel {
  final int malId;
  final String title;
  final String? titleEnglish;
  final String? titleJapanese;
  final String type;
  final double? score;
  final String? synopsis;
  final ImageModel images;
  final TrailerModel trailer;
  final List<GenreModel> genres;
  final List<StudioModel> studios;
  final int? year;

  AnimeModel({
    required this.malId,
    required this.title,
    this.titleEnglish,
    this.titleJapanese,
    required this.type,
    this.score,
    this.synopsis,
    required this.images,
    required this.trailer,
    required this.genres,
    required this.studios,
    this.year,
  });

  factory AnimeModel.fromJson(Map<String, dynamic> json) {
    return AnimeModel(
      malId: json['mal_id'],
      title: json['title'],
      titleEnglish: json['title_english'],
      titleJapanese: json['title_japanese'],
      type: json['type'],
      score: (json['score'] as num?)?.toDouble(),
      synopsis: json['synopsis'],
      year: json['year'],
      images: ImageModel.fromJson(json['images']),
      trailer: TrailerModel.fromJson(json['trailer']),
      genres: (json['genres'] as List)
          .map((e) => GenreModel.fromJson(e))
          .toList(),
      studios: (json['studios'] as List)
          .map((e) => StudioModel.fromJson(e))
          .toList(),
    );
  }
}
