import '../data/repositories/mock/mock_playing_movies_repository.dart';
import '../data/repositories/production/prod_playing_movies_repository.dart';
import '../data/repositories/repository.dart';
import '../utils/constants.dart';

class NowPlayingMoviesInjector {
  static final NowPlayingMoviesInjector _injector =
      NowPlayingMoviesInjector._();
  static final _repositories = <Flavor, NowPlayingMoviesRepository>{
    Flavor.mock: const MockNowPlayingMoviesRepository(),
    Flavor.production: ProductionNowPlayingMoviesRepository(),
  };
  NowPlayingMoviesInjector._() : _flavor = Flavor.mock;
  factory NowPlayingMoviesInjector() {
    return _injector;
  }
  Flavor _flavor;
  void configureRepository(Flavor flavor) {
    _flavor = flavor;
  }

  NowPlayingMoviesRepository get repository => _repositories[_flavor]!;
}
