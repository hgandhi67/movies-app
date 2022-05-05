import 'package:hive/hive.dart';
part 'tv_shows_db_model.g.dart';

@HiveType(typeId: 0)
class TvShowsDbModel extends HiveObject {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? name;

  @HiveField(2)
  String? overview;

  @HiveField(3)
  String? posterPath;
}
