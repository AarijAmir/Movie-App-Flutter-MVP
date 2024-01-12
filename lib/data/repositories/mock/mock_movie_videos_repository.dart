import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/video_response.dart';

import '../mock_movie_repository.dart';

class MockMovieVideosRepository extends MovieVideosRepository
    with MockRepository {
  const MockMovieVideosRepository();
  @override
  Future<VideoResponse> getMovieVideos(int id) {
    // TODO: implement getMovieVideos
    throw UnimplementedError();
  }
}
