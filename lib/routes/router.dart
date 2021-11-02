import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofico_task/bloc/add_or_edit_person_cubit/add_or_edit_person_cubit.dart';
import 'package:sofico_task/bloc/persons_cubit/persons_cubit.dart';
import 'package:sofico_task/data/models/person_model.dart';
import 'package:sofico_task/data/repository/persons_repository.dart';
import 'package:sofico_task/data/web_services/persons_web_services.dart';
import 'package:sofico_task/presentation/screens/add_or_edit_person.dart';
import 'package:sofico_task/presentation/screens/persons_screen.dart';
import 'package:sofico_task/presentation/screens/un_defined_view_screen.dart';
import 'package:sofico_task/routes/routes_constants.dart';

class AppRouter {
  late PersonsRepository repository;
  late PersonsCubit personsCubit;

  AppRouter() {
    repository = PersonsRepository(personsWebServices: PersonsWebServices());
    personsCubit = PersonsCubit(repository: repository);
  }

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return MaterialPageRoute(
          builder: (_) => BlocProvider.value(
            value: personsCubit,
            child: const PersonsScreen(),
          ),
        );

      case Routes.addOrEditPersonScreen:
        var arguments = settings.arguments != null ? settings.arguments as PersonModel : null;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (BuildContext context) => AddOrEditPersonCubit(
              repository: repository,
              personsCubit: personsCubit,
            ),
            child: AddOrEditPerson(person:  arguments,),
          ),
        );
      default:
        var arguments =
            settings.arguments != null ? settings.arguments as String : null;
        return MaterialPageRoute(
            builder: (context) => UndefinedViewScreen(
                  name: arguments,
                ));
    }
  }
}
