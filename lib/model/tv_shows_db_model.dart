import 'package:movies_app/model/tv_shows_response_model.dart';

import 'package:hive/hive.dart';
part 'tv_shows_db_model.g.dart';

@HiveType(typeId: 0)
class TvShowsDbModel extends HiveObject {
  @HiveField(0)
  Result? tvShowsList;
}
