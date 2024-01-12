import '../data/repositories/mock/mock_similar_movies_repository.dart';
import '../data/repositories/production/prod_similar_movies_repository.dart';
import '../data/repositories/repository.dart';
import '../utils/constants.dart';

class SimilarMoviesInjector {
  static final SimilarMoviesInjector _injector = SimilarMoviesInjector._();
  static final _repositories = <Flavor, SimilarMoviesRepository>{
    Flavor.mock: const MockSimilarMoviesRepository(),
    Flavor.production: ProductionSimilarMoviesRepository(),
  };
  SimilarMoviesInjector._() : _flavor = Flavor.mock;
  factory SimilarMoviesInjector() {
    return _injector;
  }
  Flavor _flavor;
  void configureRepository(Flavor flavor) {
    _flavor = flavor;
  }

  SimilarMoviesRepository get repository => _repositories[_flavor]!;
}
