import 'anime_model.dart';
import 'pagination_model.dart';

class TopAnimeResponseModel {
  final PaginationModel pagination;
  final List<AnimeModel> data;

  TopAnimeResponseModel({
    required this.pagination,
    required this.data,
  });

  factory TopAnimeResponseModel.fromJson(Map<String, dynamic> json) {
    return TopAnimeResponseModel(
      pagination: PaginationModel.fromJson(json['pagination']),
      data: (json['data'] as List)
          .map((e) => AnimeModel.fromJson(e))
          .toList(),
    );
  }
}
