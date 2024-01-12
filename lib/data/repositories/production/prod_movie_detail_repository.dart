import 'package:movie_app/data/repositories/production_movie_repository.dart';
import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/movie_detail_response.dart';

class ProductionMovieDetailRepository extends MovieDetailRepository
    with ProductionRepository {
  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async =>
      await movieAPI.getMovieDetail(id);
}
