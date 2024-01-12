import '../data/repositories/mock/mock_movie_videos_repository.dart';
import '../data/repositories/production/prod_movie_videos_repository.dart';
import '../data/repositories/repository.dart';
import '../utils/constants.dart';

class MovieVideosInjector {
  static final MovieVideosInjector _injector = MovieVideosInjector._();
  static final _repositories = <Flavor, MovieVideosRepository>{
    Flavor.mock: const MockMovieVideosRepository(),
    Flavor.production: ProductionMovieVideosRepository(),
  };
  MovieVideosInjector._() : _flavor = Flavor.mock;
  factory MovieVideosInjector() {
    return _injector;
  }
  Flavor _flavor;
  void configureRepository(Flavor flavor) {
    _flavor = flavor;
  }

  MovieVideosRepository get repository => _repositories[_flavor]!;
}
