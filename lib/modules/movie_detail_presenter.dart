import 'package:movie_app/data/models/movie_detail.dart';
import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/movie_detail_response.dart';
import 'package:movie_app/injector/movie_detail_injector.dart';

import '../exceptions/fetch_data_exception.dart';

abstract class MovieDetailContract {
  void onLoadMoviesDetailCompleteWithSuccess(MovieDetail movieDetail);
  void onLoadMoviesDetailWithError(String errorMessage);
}

class MovieDetailPresenter {
  final MovieDetailContract _view;
  final MovieDetailRepository _movieDetailRepository;
  MovieDetailPresenter(this._view)
      : _movieDetailRepository = MovieDetailInjector().repository;
  void loadMovieDetail(int id) async {
    // print('Load Genres Called');
    print('Movie Detail Presenter Load Movie Detail Function called...');
    try {
      MovieDetailResponse movieDetailResponse =
          await _movieDetailRepository.getMovieDetail(id);
      // await Future.delayed(const Duration(seconds: 2));
      if (movieDetailResponse.error.isEmpty) {
        _view.onLoadMoviesDetailCompleteWithSuccess(
            movieDetailResponse.movieDetail!);
      } else {
        _view.onLoadMoviesDetailWithError(movieDetailResponse.error);
      }
    } on NetworkException catch (e) {
      _view.onLoadMoviesDetailWithError(e.message);
    } catch (e) {
      _view.onLoadMoviesDetailWithError(e.toString());
    }
  }
}
