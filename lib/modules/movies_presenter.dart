import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/injector/movies_injector.dart';

import '../data/models/movie.dart';

abstract class MoviesListContract {
  void onLoadMoviesCompleteWithSuccess(List<Movie> moviesList);
  void onLoadMoviesWithError(String errorMessage);
}

class MoviesListPresenter {
  final MoviesListContract _view;
  final MoviesRepository _moviesRepository;
  MoviesListPresenter(this._view)
      : _moviesRepository = MoviesInjector().repository;
  void loadMovies() async {
    _moviesRepository.getMovies.then((value) {
      if (value.error.isEmpty) {
        _view.onLoadMoviesCompleteWithSuccess(value.movies);
      } else {
        _view.onLoadMoviesWithError(value.error);
      }
    }).onError((error, stackTrace) {
      _view.onLoadMoviesWithError(error.toString());
    });
  }
}
