import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/movie_response.dart';

import '../production_movie_repository.dart';

class ProductionMoviesByGenreRepository extends MoviesByGenreRepository
    with ProductionRepository {
  @override
  Future<MovieResponse> getMovieByGenre(int id) async =>
      await movieAPI.getMovieByGenre(id);
}
