import 'package:movies_app/api/api_endpoints.dart';
import 'package:movies_app/api/base_api_provider.dart';
import 'package:movies_app/model/tv_shows_response_model.dart';

class TvShowsApiCalls {
  const TvShowsApiCalls();

  /// [getPopularTvShows] will be a [GET] api and will return the [TvShowsResponseModel].
  static Future<TvShowsResponseModel?> getPopularTvShows({String? searchQuery}) async {
    var response = await ApiProvider.getAsync(
        searchQuery?.isNotEmpty == true ? ApiEndpoints.searchTvShows + searchQuery! : ApiEndpoints.popularTvShows);
    TvShowsResponseModel? responseModel;
    if (response != null) {
      responseModel = tvShowsResponseModelFromJson(response.body.toString());
    }

    return responseModel;
  }
}
