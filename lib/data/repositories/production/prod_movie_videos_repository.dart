import 'package:movie_app/data/repositories/production_movie_repository.dart';
import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/video_response.dart';

class ProductionMovieVideosRepository extends MovieVideosRepository
    with ProductionRepository {
  @override
  Future<VideoResponse> getMovieVideos(int id) async =>
      await movieAPI.getMovieVideos(id);
}
