import 'package:movie_app/data/repositories/repository.dart';

import '../data/models/movie.dart';
import '../data/responses/movie_response.dart';
import '../exceptions/fetch_data_exception.dart';
import '../injector/movies_by_genre_injector.dart';

abstract class MoviesByGenreContract {
  void onLoadMoviesCompleteWithSuccess(List<Movie> moviesList);
  void onLoadMoviesWithError(String errorMessage);
}

class MoviesByGenrePresenter {
  final MoviesByGenreContract _view;
  final MoviesByGenreRepository _moviesByGenreRepository;
  MoviesByGenrePresenter(this._view)
      : _moviesByGenreRepository = MoviesByGenreInjector().repository;
  void loadMovies(int id) async {
    try {
      MovieResponse movieResponse =
          await _moviesByGenreRepository.getMovieByGenre(id);
      if (movieResponse.error.isEmpty) {
        print('${movieResponse.movies}Movies List With Genre');
        _view.onLoadMoviesCompleteWithSuccess(movieResponse.movies);
      } else {
        _view.onLoadMoviesWithError(movieResponse.error);
      }
    } on NetworkException catch (e) {
      _view.onLoadMoviesWithError(e.message);
    } catch (e) {
      _view.onLoadMoviesWithError(e.toString());
    }
  }
}
