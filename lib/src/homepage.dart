import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:movies_app/model/tv_shows_response_model.dart';
import 'package:movies_app/src/api_provider.dart';
import 'package:movies_app/src/loading_widget.dart';
import 'package:movies_app/src/tv_show_item_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  /// [List] of Results giving the list of the popular tv shows, either searched or not.
  List<Result> tvShowsList = [];

  /// [bool] value showing the loader, [true] when loading data and [false] when loaded.
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchTvShows();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Movies App'), centerTitle: true),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        child: Stack(
          children: [
            _rootHomePageWidget(),
            if (isLoading) ...[const LoadingWidget()],
          ],
        ),
      ),
    );
  }

  /// Widget function which gives the UI for the root homepage, it contains all other ui like list, loading management,
  /// search bar etc.
  Widget _rootHomePageWidget() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _tvShowsListWidget(),
        _searchBarWidget(),
      ],
    );
  }

  /// Widget function which gives the UI for the search bar widget.
  Widget _searchBarWidget() {
    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 16),
      transitionDuration: const Duration(milliseconds: 200),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      width: MediaQuery.of(context).size.width * 0.9,
      debounceDelay: const Duration(milliseconds: 200),
      onSubmitted: (query){
        fetchTvShows(searchQuery: query);
      },
      onQueryChanged: (query){
        if(query == ''){
          fetchTvShows();
        }
      },
      clearQueryOnClose: true,
      closeOnBackdropTap: true,
      backdropColor: Colors.transparent,
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction.searchToClear(showIfClosed: false),
      ],
      builder: (context, transition) {
        return const SizedBox();
      },
    );
  }

  /// Widget function which gives the UI for the list of the tv shows
  Widget _tvShowsListWidget() {
    return ListView.builder(
      itemCount: tvShowsList.length,
      shrinkWrap: true,
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.1),
      itemBuilder: (context, index) {
        return TvShowItemWidget(result: tvShowsList[index]);
      },
    );
  }

  /// Function which loads the data of all the popular tv shows, it also provides the search functionality
  /// based on the value of the [searchQuery] passed.
  /// By default, [searchQuery] will be empty.
  void fetchTvShows({String searchQuery = ''}) async {
    manageLoader(true);
    TvShowsResponseModel? tvShowsResponseModel = await TvShowsApiCalls.getPopularTvShows(searchQuery: searchQuery);
    manageLoader(false);
    tvShowsList.clear();
    setState(() {
      tvShowsList.addAll(tvShowsResponseModel!.results!);
    });
  }

  /// Function which change the state of the loader based on the value passed in the function.
  void manageLoader(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
}
