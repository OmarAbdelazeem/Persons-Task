
import 'package:sofico_task/data/models/person_model.dart';
import 'package:sofico_task/data/web_services/persons_web_services.dart';

class PersonsRepository {
  final PersonsWebServices personsWebServices;

  PersonsRepository({required this.personsWebServices});

  Future<List<PersonModel>> fetchPersons() async {
    final personsRaw = await personsWebServices.getPersons();
    return personsRaw.map((e) => PersonModel.fromJson(e)).toList();
  }


  Future<int> addPerson(PersonModel person) async {
    final todoMap = await personsWebServices.postPerson(person.toJson());
    if (todoMap == null) return 0;
    return 1;
  }

  Future<bool> deletePerson(int id) async {
    return await personsWebServices.deletePerson(id);
  }

  Future<bool> updatePerson(PersonModel person,int id) async {
    return await personsWebServices.patchPerson(person.toJson(), id);
  }
}

