import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/modules/movies_presenter.dart';
import 'package:movie_app/style/theme/theme.dart';
import 'package:movie_app/widgets/elements/error_element.dart';
import 'package:movie_app/widgets/elements/loading_element.dart';
import 'package:page_indicator/page_indicator.dart';

class NowPlaying extends StatefulWidget {
  const NowPlaying({super.key});

  @override
  State<NowPlaying> createState() => _NowPlayingState();
}

class _NowPlayingState extends State<NowPlaying> implements MoviesListContract {
  late final PageController _pageController;
  late MoviesListPresenter? _moviesListPresenter;
  List<Movie> _moviesList = [];
  bool _isStartLoading = true;
  String _errorMessage = '';
  _NowPlayingState() {
    _moviesListPresenter = MoviesListPresenter(this);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(viewportFraction: 1, keepPage: true);
    _moviesListPresenter!.loadMovies();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _moviesListPresenter = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    if (_isStartLoading) {
      return SizedBox(
        height: size.height * 0.8,
        width: size.width,
        child: Center(
          child: buildLoadingWidget(
            size,
          ),
        ),
      );
    } else {
      if (_isStartLoading == false &&
          _errorMessage.isNotEmpty &&
          _moviesList.isEmpty) {
        return buildErrorWidget(_errorMessage);
      } else {
        return _buildHomeWidget(_moviesList);
      }
    }
  }

  Widget _buildHomeWidget(List<Movie> moviesList) {
    return (moviesList.isEmpty)
        ? SizedBox(
            width: MediaQuery.of(context).size.width,
            child: const Center(
              child: Text(
                "No More Movies",
                style: TextStyle(color: Colors.black45),
              ),
            ),
          )
        : SizedBox(
            height: 220.0,
            child: PageIndicatorContainer(
              align: IndicatorAlign.bottom,
              length: moviesList.take(5).length,
              indicatorSpace: 8.0,
              padding: const EdgeInsets.all(5.0),
              indicatorColor: titleColor,
              indicatorSelectorColor: secondColor,
              shape: IndicatorShape.circle(size: 5.0),
              child: PageView.builder(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                itemCount: moviesList.take(5).length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: <Widget>[
                        Hero(
                          tag: moviesList[index].id,
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: 220.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      "https://image.tmdb.org/t/p/original/${moviesList[index].backPoster}")),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: const [
                                  0.0,
                                  0.9
                                ],
                                colors: [
                                  mainColor.withOpacity(1.0),
                                  mainColor.withOpacity(0.0)
                                ]),
                          ),
                        ),
                        const Positioned(
                          bottom: 0.0,
                          top: 0.0,
                          left: 0.0,
                          right: 0.0,
                          child: Icon(
                            FontAwesomeIcons.circlePlay,
                            color: secondColor,
                            size: 40.0,
                          ),
                        ),
                        Positioned(
                          bottom: 30.0,
                          child: Container(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            width: 250.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  moviesList[index].title,
                                  style: const TextStyle(
                                      height: 1.5,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
  }

  @override
  void onLoadMoviesCompleteWithSuccess(List<Movie> moviesList) {
    // TODO: implement onLoadMoviesCompleteWithSuccess
    print('Called: $_moviesList');
    setState(() {
      _moviesList = moviesList;
      _isStartLoading = false;
      _errorMessage = '';
    });
  }

  @override
  void onLoadMoviesWithError(String errorMessage) {
    // TODO: implement onLoadMoviesWithError
    print('Called With Error Playing Movies');
    setState(() {
      _errorMessage = errorMessage;
      _isStartLoading = false;
      _moviesList = [];
    });
  }
}
