import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movies_app/api/api_endpoints.dart';
import 'package:movies_app/model/tv_shows_db_model.dart';
import 'package:movies_app/model/tv_shows_response_model.dart';
import 'package:movies_app/widget/tv_show_item_widget.dart';

class FavouritePage extends StatefulWidget {
  const FavouritePage({Key? key}) : super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<TvShowsDbModel> favList = [];

  @override
  void initState() {
    super.initState();
    getFavourites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favourites'), centerTitle: true, automaticallyImplyLeading: true),
      body: _favTvShowsListWidget(),
    );
  }

  /// Widget function which gives the UI for the list of the tv shows
  Widget _favTvShowsListWidget() {
    return ListView.builder(
      itemCount: favList.length,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
      itemBuilder: (context, index) {
        TvShowsDbModel tvShowsDbModel = favList[index];
        return TvShowItemWidget(
          showFav: false,
          result: Result(
            id: tvShowsDbModel.id,
            name: tvShowsDbModel.name,
            overview: tvShowsDbModel.overview,
            posterPath: tvShowsDbModel.posterPath,
          ),
        );
      },
    );
  }

  void getFavourites() async {
    final box = await Hive.openBox<TvShowsDbModel>(ApiEndpoints.databaseName);

    setState(() {
      favList = box.values.toList().isNotEmpty == true ? box.values.toList() : [];
    });
  }
}
