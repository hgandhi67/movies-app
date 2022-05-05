import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/api/api_endpoints.dart';
import 'package:movies_app/model/tv_shows_db_model.dart';
import 'package:movies_app/model/tv_shows_response_model.dart';

class TvShowItemWidget extends StatefulWidget {
  final Result result;

  const TvShowItemWidget({Key? key, required this.result}) : super(key: key);

  @override
  _TvShowItemWidgetState createState() => _TvShowItemWidgetState();
}

class _TvShowItemWidgetState extends State<TvShowItemWidget> {
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    checkExistence();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.width * 0.02),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.network(
            widget.result.posterPath != null ? ApiEndpoints.imagesBaseUrl + widget.result.posterPath! : '',
            width: MediaQuery.of(context).size.width * 0.2,
            height: MediaQuery.of(context).size.width * 0.3,
            fit: BoxFit.cover,
            errorBuilder: (context, obj, stack) {
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                    height: MediaQuery.of(context).size.width * 0.05,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      strokeWidth: 3,
                    ),
                  ),
                ),
              );
            },
            loadingBuilder: (context, child, progress) {
              if (progress == null) return child;
              return SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
                height: MediaQuery.of(context).size.width * 0.3,
                child: Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.05,
                    height: MediaQuery.of(context).size.width * 0.05,
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                      strokeWidth: 3,
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    widget.result.name!,
                    style: const TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.03),
                  Text(
                    widget.result.overview!,
                    style: const TextStyle(fontSize: 14.0, color: Colors.blueGrey),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () => addToFavourite(),
            child: const Icon(Icons.favorite_border, size: 22.0, color: Colors.orangeAccent),
          ),
        ],
      ),
    );
  }

  void checkExistence() async {
    final box = await Hive.openBox<TvShowsDbModel>('ShowsDB');
    List<TvShowsDbModel> dbList = box.values.toList().isNotEmpty == true ? box.values.toList() : [];
    List<TvShowsDbModel> check = dbList.where((element) => element.tvShowsList?.id == widget.result.id).toList();

    setState(() {
      isFav = check.isNotEmpty;
    });
  }

  void addToFavourite() async {
    final box = Hive.box<TvShowsDbModel>('ShowsDB');
    List<TvShowsDbModel> dbList = box.values.toList().isNotEmpty == true ? box.values.toList() : [];
    int check = dbList.indexWhere((element) => element.tvShowsList?.id == widget.result.id);

    if (check == -1) {
      TvShowsDbModel tvShowsDbModel = TvShowsDbModel()..tvShowsList = widget.result;
      Hive.box<TvShowsDbModel>('ShowsDB').add(tvShowsDbModel);
      // box.add(tvShowsDbModel);
    } else {
      box.deleteAt(check);
    }
  }
}
