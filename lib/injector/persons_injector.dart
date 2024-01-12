import '../data/repositories/mock/mock_persons_repostiory.dart';
import '../data/repositories/production/prod_persons_repostiory.dart';
import '../data/repositories/repository.dart';
import '../utils/constants.dart';

class PersonsInjector {
  static final PersonsInjector _injector = PersonsInjector._();
  static final _repositories = <Flavor, PersonsRepository>{
    Flavor.mock: const MockPersonsRepository(),
    Flavor.production: ProductionPersonsRepository(),
  };
  PersonsInjector._() : _flavor = Flavor.mock;
  factory PersonsInjector() {
    return _injector;
  }
  Flavor _flavor;
  void configureRepository(Flavor flavor) {
    _flavor = flavor;
  }

  PersonsRepository get repository => _repositories[_flavor]!;
}
