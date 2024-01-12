import 'package:movie_app/data/repositories/repository.dart';

import '../../responses/person_reponse.dart';
import '../mock_movie_repository.dart';

class MockPersonsRepository extends PersonsRepository with MockRepository {
  const MockPersonsRepository();
  @override
  // TODO: implement getPersons
  Future<PersonResponse> get getPersons async => throw '';
}
