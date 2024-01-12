import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/movie_response.dart';

import '../mock_movie_repository.dart';

class MockSimilarMoviesRepository extends SimilarMoviesRepository
    with MockRepository {
  const MockSimilarMoviesRepository();
  @override
  Future<MovieResponse> getSimilarMovies(int id) {
    // TODO: implement getSimilarMovies
    throw UnimplementedError();
  }
}
