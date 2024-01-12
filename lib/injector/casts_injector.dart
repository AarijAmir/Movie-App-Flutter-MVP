import 'package:movie_app/data/repositories/mock/mock_casts_repository.dart';
import 'package:movie_app/data/repositories/production/prod_casts_repository.dart';
import 'package:movie_app/data/repositories/repository.dart';

import '../utils/constants.dart';

class CastsInjector {
  static final CastsInjector _injector = CastsInjector._();
  static final _repositories = <Flavor, CastsRepository>{
    Flavor.mock: const MockCastsRepository(),
    Flavor.production: ProductionCastsRepository(),
  };
  CastsInjector._() : _flavor = Flavor.mock;
  factory CastsInjector() {
    return _injector;
  }
  Flavor _flavor;
  void configureRepository(Flavor flavor) {
    _flavor = flavor;
  }

  CastsRepository get repository => _repositories[_flavor]!;
}
