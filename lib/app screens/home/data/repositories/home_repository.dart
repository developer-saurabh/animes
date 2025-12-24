import '../../../../core/constants/api_constants.dart';
import '../../../../core/network/api_helper.dart';
import '../models/top_anime_response_model.dart';

class HomeRepository {
  final ApiHelper _apiHelper;

  HomeRepository(this._apiHelper);

  Future<TopAnimeResponseModel> fetchTopMovies() async {
    final response = await _apiHelper.get(
      ApiConstants.topAnime,
      queryParameters: {
        'type': ApiConstants.animeTypeMovie,
      },
    );

    return TopAnimeResponseModel.fromJson(response);
  }
}
