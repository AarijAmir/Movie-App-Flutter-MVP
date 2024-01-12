import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/cast_response.dart';

import '../mock_movie_repository.dart';

class MockCastsRepository extends CastsRepository with MockRepository {
  const MockCastsRepository();
  @override
  Future<CastResponse> getCasts(int id) {
    // TODO: implement getCasts
    throw UnimplementedError();
  }
}
