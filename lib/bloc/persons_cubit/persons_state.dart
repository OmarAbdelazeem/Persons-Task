part of 'persons_cubit.dart';

@immutable
abstract class PersonsState {}

class PersonsInitial extends PersonsState {}

class PersonsLoading extends PersonsState {}

class PersonsLoaded extends PersonsState {
  List<PersonModel> persons;

  PersonsLoaded({required this.persons});
}

class PersonsError extends PersonsState{
  String error;
  PersonsError(this.error);
}
