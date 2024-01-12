import 'package:movie_app/data/repositories/production_movie_repository.dart';
import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/cast_response.dart';
import 'package:movie_app/data/responses/movie_detail_response.dart';

class ProductionCastsRepository extends CastsRepository
    with ProductionRepository {
  @override
  Future<CastResponse> getCasts(int id) async => await movieAPI.getCasts(id);
}
