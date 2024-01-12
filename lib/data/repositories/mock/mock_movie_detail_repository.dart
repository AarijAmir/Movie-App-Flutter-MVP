import 'package:movie_app/data/repositories/mock_movie_repository.dart';
import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/movie_detail_response.dart';

class MockMovieDetailRepository extends MovieDetailRepository
    with MockRepository {
  const MockMovieDetailRepository();
  @override
  Future<MovieDetailResponse> getMovieDetail(int id) {
    // TODO: implement getMovieDetail
    throw UnimplementedError();
  }
}
