import 'package:movie_app/data/repositories/repository.dart';

import '../../responses/movie_response.dart';
import '../mock_movie_repository.dart';

class MockNowPlayingMoviesRepository extends NowPlayingMoviesRepository
    with MockRepository {
  const MockNowPlayingMoviesRepository();
  @override
  // TODO: implement getPlayingMovies
  Future<MovieResponse> get getPlayingMovies async => throw '';
}
