import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofico_task/bloc/persons_cubit/persons_cubit.dart';
import 'package:sofico_task/presentation/widgets/custom_gridview.dart';
import 'package:sofico_task/res/app_colors.dart';
import 'package:sofico_task/res/strings_constants.dart';
import 'package:sofico_task/routes/routes_constants.dart';

class PersonsScreen extends StatefulWidget {
  const PersonsScreen({Key? key}) : super(key: key);

  @override
  _PersonsScreenState createState() => _PersonsScreenState();
}

class _PersonsScreenState extends State<PersonsScreen> {
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PersonsCubit>(context).fetchPersons();
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsConstants.persons),
      ),
      body: BlocBuilder<PersonsCubit, PersonsState>(
        builder: (context, state) {
          if (state is PersonsLoaded) {
            final persons = (state as PersonsLoaded).persons;

            return CustomGridView(
              persons: persons,
            );
          } else if (state is PersonsError)
            return Center(
              child: Text(state.error),
            );
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        label: Text("Add person"),
        onPressed: () {
          Navigator.pushNamed(context, Routes.addOrEditPersonScreen);
        },
        backgroundColor: AppColors.primaryColor,
      ),
    );
  }
}
