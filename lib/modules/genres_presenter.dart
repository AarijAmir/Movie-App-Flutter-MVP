import 'package:movie_app/data/models/genre.dart';

import '../data/repositories/repository.dart';
import '../data/responses/genre_response.dart';
import '../exceptions/fetch_data_exception.dart';
import '../injector/genres_injector.dart';

abstract class GenresListContract {
  void onLoadGenresCompleteWithSuccess(List<Genre> genresList);
  void onLoadGenresWithError(String errorMessage);
}

class GenresListPresenter {
  final GenresListContract _view;
  final GenresRepository _genresRepository;
  GenresListPresenter(this._view)
      : _genresRepository = GenresInjector().repository;
  void loadGenres() async {
    // print('Load Genres Called');
    try {
      GenreResponse movieResponse = await _genresRepository.getGenres;
      // await Future.delayed(const Duration(seconds: 2));
      if (movieResponse.error.isEmpty) {
        _view.onLoadGenresCompleteWithSuccess(movieResponse.genres);
      } else {
        _view.onLoadGenresWithError(movieResponse.error);
      }
    } on NetworkException catch (e) {
      _view.onLoadGenresWithError(e.message);
    } catch (e) {
      _view.onLoadGenresWithError(e.toString());
    }
  }
}
