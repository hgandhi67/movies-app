import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:movies_app/api/api_endpoints.dart';
import 'package:movies_app/model/tv_shows_db_model.dart';
import 'package:movies_app/model/tv_shows_response_model.dart';

class TvShowItemWidget extends StatefulWidget {
  final Result result;
  final bool showFav;

  const TvShowItemWidget({Key? key, required this.result, this.showFav = true}) : super(key: key);

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
          if (widget.showFav) ...[
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
            InkWell(
              splashColor: Colors.transparent,
              onTap: () => addRemoveFromFavourite(),
              child: Icon(isFav ? Icons.favorite : Icons.favorite_border, size: 22.0, color: Colors.orangeAccent),
            ),
          ],
        ],
      ),
    );
  }

  void checkExistence() async {
    final box = await Hive.openBox<TvShowsDbModel>(ApiEndpoints.databaseName);
    List<TvShowsDbModel> dbList = box.values.toList().isNotEmpty == true ? box.values.toList() : [];
    List<TvShowsDbModel> check = dbList.where((element) => element.id == widget.result.id).toList();

    setState(() {
      isFav = check.isNotEmpty;
    });
  }

  void addRemoveFromFavourite() async {
    final box = Hive.box<TvShowsDbModel>(ApiEndpoints.databaseName);
    List<TvShowsDbModel> dbList = box.values.toList().isNotEmpty == true ? box.values.toList() : [];
    int check = dbList.indexWhere((element) => element.id == widget.result.id);

    if (check == -1) {
      TvShowsDbModel tvShowsDbModel = TvShowsDbModel()
        ..id = widget.result.id
        ..name = widget.result.name
        ..overview = widget.result.overview
        ..posterPath = widget.result.posterPath;
      box.add(tvShowsDbModel);
      checkExistence();
    } else {
      box.deleteAt(check);
      checkExistence();
    }
  }
}
