import 'package:movie_app/data/models/video.dart';
import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/injector/movie_videos_injector.dart';

abstract class MovieVideosListContract {
  void onLoadMovieVideosCompleteWithSuccess(List<Video> videosList);
  void onLoadMovieVideosWithError(String errorMessage);
}

class MovieVideosListPresenter {
  final MovieVideosListContract _view;
  final MovieVideosRepository _movieVideosRepository;
  MovieVideosListPresenter(this._view)
      : _movieVideosRepository = MovieVideosInjector().repository;
  void loadMovieVideos(int id) async {
    _movieVideosRepository.getMovieVideos(id).then((value) {
      if (value.error.isEmpty) {
        _view.onLoadMovieVideosCompleteWithSuccess(value.videos);
      } else {
        _view.onLoadMovieVideosWithError(value.error);
      }
    }).onError((error, stackTrace) {
      _view.onLoadMovieVideosWithError(error.toString());
    });
  }
}
