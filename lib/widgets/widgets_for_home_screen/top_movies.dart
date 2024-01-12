import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/modules/movies_presenter.dart';

import '../../style/theme/theme.dart';
import '../elements/error_element.dart';
import '../elements/loading_element.dart';

class TopMovies extends StatefulWidget {
  const TopMovies({super.key});

  @override
  State<TopMovies> createState() => _TopMoviesState();
}

class _TopMoviesState extends State<TopMovies> implements MoviesListContract {
  late MoviesListPresenter? _moviesListPresenter;
  List<Movie> _moviesList = [];
  bool _isStartLoading = true;
  String _errorMessage = '';
  _TopMoviesState() {
    _moviesListPresenter = MoviesListPresenter(this);
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _moviesListPresenter?.loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(
            left: 10.0,
            top: 20.0,
          ),
          child: Text(
            'TOP RATED MOVIES',
            style: TextStyle(
              color: titleColor,
              fontWeight: FontWeight.w500,
              fontSize: 12.0,
            ),
          ),
        ),
        const SizedBox(
          height: 5.0,
        ),
        _buildTopMoviesLoadingOrResultWidget(size),
      ],
    );
  }

  Widget _buildTopMoviesLoadingOrResultWidget(Size size) {
    return (_isStartLoading)
        ? SizedBox(
            height: size.height * 0.8,
            width: size.width,
            child: Center(
              child: buildLoadingWidget(
                size,
              ),
            ),
          )
        : (_isStartLoading == false &&
                _errorMessage.isNotEmpty &&
                _moviesList.isEmpty)
            ? buildErrorWidget(_errorMessage)
            : _buildTopMoviesWidget(_moviesList);
  }

  Widget _buildTopMoviesWidget(List<Movie> moviesList) {
    if (moviesList.isEmpty) {
      return const Center(
        child: Text(
          'No Movies',
          style: TextStyle(
            color: Colors.white,
            fontSize: 11.0,
          ),
        ),
      );
    } else {
      return Container(
        height: 270.0,
        padding: const EdgeInsets.only(
          left: 10.0,
        ),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: moviesList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                right: 10.0,
              ),
              child: Column(
                children: [
                  (moviesList[index].poster == null)
                      ? Container(
                          width: 120.0,
                          height: 180.0,
                          decoration: const BoxDecoration(
                            color: secondColor,
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                2.0,
                              ),
                            ),
                            shape: BoxShape.rectangle,
                          ),
                          child: Column(
                            children: const [
                              Icon(
                                EvaIcons.filmOutline,
                                color: Colors.white,
                                size: 50.0,
                              ),
                            ],
                          ),
                        )
                      : Container(
                          width: 120.0,
                          height: 180.0,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(
                                Radius.circular(2.0),
                              ),
                              shape: BoxShape.rectangle,
                              image: DecorationImage(
                                  image: NetworkImage(
                                      'https://image.tmdb.org/t/p/w200${moviesList[index].poster}'),
                                  fit: BoxFit.cover)),
                        ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  SizedBox(
                    width: 100.0,
                    child: Text(
                      moviesList[index].title,
                      maxLines: 2,
                      style: const TextStyle(
                        height: 1.4,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 11.0,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    children: [
                      Text(
                        moviesList[index].rating.toString(),
                        style: const TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        width: 5.0,
                      ),
                      RatingBar(
                        itemSize: 8.0,
                        ratingWidget: RatingWidget(
                          empty: const Icon(
                            EvaIcons.star,
                            color: secondColor,
                          ),
                          full: const Icon(
                            EvaIcons.star,
                            color: secondColor,
                          ),
                          half: const Icon(
                            EvaIcons.star,
                            color: secondColor,
                          ),
                        ),
                        initialRating: moviesList[index].rating / 2,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemPadding:
                            const EdgeInsets.symmetric(horizontal: 2.0),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      )
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      );
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _moviesListPresenter = null;

    super.dispose();
  }

  @override
  void onLoadMoviesCompleteWithSuccess(List<Movie> moviesList) {
    // TODO: implement onLoadMoviesCompleteWithSuccess
    setState(() {
      _moviesList = moviesList;
      _isStartLoading = false;
      _errorMessage = '';
    });
  }

  @override
  void onLoadMoviesWithError(String errorMessage) {
    // TODO: implement onLoadMoviesWithError
    // TODO: implement onLoadMoviesWithError
    print('Top Movies: Error Called');
    setState(() {
      _errorMessage = errorMessage;
      _isStartLoading = false;
      _moviesList = [];
    });
  }
}
