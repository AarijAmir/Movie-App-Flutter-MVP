import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/movie_response.dart';

import '../production_movie_repository.dart';

class ProductionMoviesRepository extends MoviesRepository
    with ProductionRepository {
  @override
  // TODO: implement getMovies
  Future<MovieResponse> get getMovies async =>await movieAPI.getMovies();
}
