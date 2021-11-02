import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:sofico_task/bloc/persons_cubit/persons_cubit.dart';
import 'package:sofico_task/data/models/person_model.dart';
import 'package:sofico_task/data/repository/persons_repository.dart';
part 'add_or_edit_person_state.dart';


class AddOrEditPersonCubit extends Cubit<AddOrEditPersonState> {
  final PersonsRepository repository;
  final PersonsCubit personsCubit;

  AddOrEditPersonCubit({required this.personsCubit, required this.repository})
      : super(AddOrEditPersonInitial());

  Future addPerson(PersonModel person) async {
    emit(AddOrEditPersonLoading());
    int response = await repository.addPerson(person);
    if(response ==1){
      personsCubit.fetchPersons();
      emit(AddOrEditPersonFinished());
    }
    else{
      emit(AddOrEditPersonError("Error when Adding person"));
    }
  }

  Future updatePerson(PersonModel person , int id)async{
    emit(AddOrEditPersonLoading());
    bool response = await repository.updatePerson(person , id);
    if(response){
      personsCubit.updatePerson(person , id);
      emit(AddOrEditPersonFinished());
    }
    else{
      emit(AddOrEditPersonError("Error when updating person"));
    }
  }

  Future deletePerson(int id)async{
    emit(AddOrEditPersonLoading());
    bool response = await repository.deletePerson(id);
    if(response){
      personsCubit.deletePerson(id);
      emit(AddOrEditPersonFinished());
    }
    else{
      print("Error when deleting person");
      emit(AddOrEditPersonError("Error when deleting person"));
    }
  }


}
