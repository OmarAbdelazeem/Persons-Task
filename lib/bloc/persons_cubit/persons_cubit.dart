import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sofico_task/data/models/person_model.dart';
import 'package:sofico_task/data/repository/persons_repository.dart';
part 'persons_state.dart';

class PersonsCubit extends Cubit<PersonsState> {

  final PersonsRepository repository;
  PersonsCubit({required this.repository}) : super(PersonsInitial());

  void fetchPersons() async{
    print('fetch persons function');
    emit(PersonsLoading());
    try{
      final persons = await repository.fetchPersons();
      emit(PersonsLoaded(persons: persons));
    }catch(e){
      emit(PersonsError("Error when fetching persons"));
    }
  }


  updatePerson(PersonModel person , int id){
    final currentState = state;
    if (currentState is PersonsLoaded) {
      final persons = currentState.persons;
    int index = persons.indexWhere((element) => element.id == id);
    persons[index] = person;
    persons[index].id = id;
      emit(PersonsLoaded(persons: persons));
  }}

  void deletePerson(int id) {
    final currentState = state;
    if (currentState is PersonsLoaded) {
      List<PersonModel> persons = currentState.persons;
      persons.removeWhere((element) => element.id == id);
      emit(PersonsLoaded(persons: persons));
    }
  }

}
