import 'package:meta/meta.dart';
import 'dart:convert';

TvShowsResponseModel tvShowsResponseModelFromJson(String str) => TvShowsResponseModel.fromJson(json.decode(str));

String tvShowsResponseModelToJson(TvShowsResponseModel data) => json.encode(data.toJson());

class TvShowsResponseModel {
  TvShowsResponseModel({
    @required this.page,
    @required this.results,
    @required this.totalPages,
    @required this.totalResults,
  });

  final int? page;
  final List<Result>? results;
  final int? totalPages;
  final int? totalResults;

  factory TvShowsResponseModel.fromJson(Map<String, dynamic> json) => TvShowsResponseModel(
    page: json["page"],
    results: json["results"] == null ? [] : List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    totalPages: json["total_pages"],
    totalResults: json["total_results"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
    "total_pages": totalPages,
    "total_results": totalResults,
  };
}

class Result {
  Result({
    this.backdropPath,
    this.firstAirDate,
    this.genreIds,
    this.id,
    this.name,
    this.originCountry,
    this.originalLanguage,
    this.originalName,
    this.overview,
    this.popularity,
    this.posterPath,
    this.voteAverage,
    this.voteCount,
  });

  final String? backdropPath;
  final DateTime? firstAirDate;
  final List<int>? genreIds;
  final int? id;
  final String? name;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalName;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final double? voteAverage;
  final int? voteCount;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    backdropPath: json["backdrop_path"],
    firstAirDate: json["first_air_date"] == null || json["first_air_date"] == '' ? null : DateTime.parse(json["first_air_date"]),
    genreIds: json["genre_ids"] == null ? null : List<int>.from(json["genre_ids"].map((x) => x)),
    id: json["id"],
    name: json["name"],
    originCountry: json["origin_country"] == null ? null : List<String>.from(json["origin_country"].map((x) => x)),
    originalLanguage: json["original_language"],
    originalName: json["original_name"],
    overview: json["overview"],
    popularity: json["popularity"] == null ? null : json["popularity"].toDouble(),
    posterPath: json["poster_path"],
    voteAverage: json["vote_average"] == null ? null : json["vote_average"].toDouble(),
    voteCount: json["vote_count"],
  );

  Map<String, dynamic> toJson() => {
    "backdrop_path": backdropPath,
    "first_air_date": firstAirDate == null ? null : "${firstAirDate?.year.toString().padLeft(4, '0')}-${firstAirDate?.month.toString().padLeft(2, '0')}-${firstAirDate!.day.toString().padLeft(2, '0')}",
    "genre_ids": genreIds == null ? null : List<dynamic>.from(genreIds!.map((x) => x)),
    "id": id,
    "name": name,
    "origin_country": originCountry == null ? null : List<dynamic>.from(originCountry!.map((x) => x)),
    "original_language": originalLanguage,
    "original_name": originalName,
    "overview": overview,
    "popularity": popularity,
    "poster_path": posterPath,
    "vote_average": voteAverage,
    "vote_count": voteCount,
  };
}
