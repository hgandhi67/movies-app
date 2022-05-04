class ApiEndpoints {
  /// Api key used for the api calls in the application
  static const String apiKey = '4b362574a245356411cd7a6a115441d0';

  /// Base URL for the api parts.
  static const String baseUrlProd = 'https://api.themoviedb.org/3';

  /// Url for the popular tv shows
  static const String popularTvShows = '/tv/popular?language=en-US&page=1&api_key=';

  /// Url for the search of popular tv shows
  static const String searchTvShows = '/search/tv?language=en-US&page=1&include_adult=false&api_key=';
}
