part of 'add_or_edit_person_cubit.dart';

@immutable
abstract class AddOrEditPersonState {}

class AddOrEditPersonInitial extends AddOrEditPersonState {}
class AddOrEditPersonLoading extends AddOrEditPersonState {}
class AddOrEditPersonFinished extends AddOrEditPersonState {}
class AddOrEditPersonError extends AddOrEditPersonState {
 final String error;
  AddOrEditPersonError(this.error);
}
