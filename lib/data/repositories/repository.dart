import 'package:movie_app/data/responses/cast_response.dart';
import 'package:movie_app/data/responses/movie_detail_response.dart';

import '../responses/genre_response.dart';
import '../responses/movie_response.dart';
import '../responses/person_reponse.dart';
import '../responses/video_response.dart';

abstract class MoviesRepository {
  const MoviesRepository();
  Future<MovieResponse> get getMovies;
}

abstract class NowPlayingMoviesRepository {
  const NowPlayingMoviesRepository();
  Future<MovieResponse> get getPlayingMovies;
}

abstract class GenresRepository {
  const GenresRepository();
  Future<GenreResponse> get getGenres;
}

abstract class PersonsRepository {
  const PersonsRepository();
  Future<PersonResponse> get getPersons;
}

abstract class MoviesByGenreRepository {
  const MoviesByGenreRepository();
  Future<MovieResponse> getMovieByGenre(int id);
}

abstract class MovieDetailRepository {
  const MovieDetailRepository();
  Future<MovieDetailResponse> getMovieDetail(int id);
}

abstract class CastsRepository {
  const CastsRepository();
  Future<CastResponse> getCasts(int id);
}

abstract class SimilarMoviesRepository {
  const SimilarMoviesRepository();
  Future<MovieResponse> getSimilarMovies(int id);
}

abstract class MovieVideosRepository {
  const MovieVideosRepository();
  Future<VideoResponse> getMovieVideos(int id);
}
