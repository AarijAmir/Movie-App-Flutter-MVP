import 'package:movie_app/data/repositories/repository.dart';
import 'package:movie_app/data/responses/person_reponse.dart';

import '../production_movie_repository.dart';

class ProductionPersonsRepository extends PersonsRepository
    with ProductionRepository {
  @override
  // TODO: implement getPersons
  Future<PersonResponse> get getPersons async => await movieAPI.getPersons();
}
