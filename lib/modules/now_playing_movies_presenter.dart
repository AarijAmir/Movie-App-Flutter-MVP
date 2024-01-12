import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/injector/now_playing_movies_injector.dart';

import '../data/models/movie.dart';

abstract class NowPlayingMoviesContract {
  void onLoadNowPlayingMoviesCompleteWithSuccess(List<Movie> moviesList);
  void onLoadNowPlayingMoviesWithError(String errorMessage);
}

class NowPlayingMoviesPresenter {
  final NowPlayingMoviesContract _view;
  final NowPlayingMoviesRepository _nowPlayingMoviesRepository;
  NowPlayingMoviesPresenter(this._view)
      : _nowPlayingMoviesRepository = NowPlayingMoviesInjector().repository;
  void loadMovies() async {
    _nowPlayingMoviesRepository.getPlayingMovies.then((value) {
      if (value.error.isEmpty) {
        _view.onLoadNowPlayingMoviesCompleteWithSuccess(value.movies);
      } else {
        _view.onLoadNowPlayingMoviesWithError(value.error);
      }
    }).onError((error, stackTrace) {
      _view.onLoadNowPlayingMoviesWithError(error.toString());
    });
  }
}
