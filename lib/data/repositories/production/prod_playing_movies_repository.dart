import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/movie_response.dart';

import '../production_movie_repository.dart';

class ProductionNowPlayingMoviesRepository extends NowPlayingMoviesRepository
    with ProductionRepository {
  @override
  // TODO: implement getPlayingMovies
  Future<MovieResponse> get getPlayingMovies async =>
      await movieAPI.getPlayingMovies();
}
