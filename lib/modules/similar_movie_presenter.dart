import 'package:movie_app/data/models/movie.dart';
import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/injector/similar_movies_injector.dart';

abstract class SimilarMoviesListContract {
  void onLoadSimilarMovieCompleteWithSuccess(List<Movie> moviesList);
  void onLoadSimilarWithError(String errorMessage);
}

class SimilarMovieListPresenter {
  final SimilarMoviesListContract _view;
  final SimilarMoviesRepository _similarMoviesRepository;
  SimilarMovieListPresenter(this._view)
      : _similarMoviesRepository = SimilarMoviesInjector().repository;
  void loadSimilarMovies(int id) async {
    _similarMoviesRepository.getSimilarMovies(id).then((value) {
      if (value.error.isEmpty) {
        _view.onLoadSimilarMovieCompleteWithSuccess(value.movies);
      } else {
        _view.onLoadSimilarWithError(value.error);
      }
    }).onError((error, stackTrace) {
      _view.onLoadSimilarWithError(error.toString());
    });
  }
}
