import 'package:movie_app/data/repositories/production_movie_repository.dart';
import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/movie_response.dart';

class ProductionSimilarMoviesRepository extends SimilarMoviesRepository
    with ProductionRepository {
  @override
  Future<MovieResponse> getSimilarMovies(int id) async =>
      await movieAPI.getSimilarMovies(id);
}
