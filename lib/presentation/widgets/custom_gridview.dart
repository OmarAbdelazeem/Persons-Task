import 'package:flutter/material.dart';
import 'package:sofico_task/data/models/person_model.dart';
import 'package:sofico_task/presentation/widgets/person_view.dart';

class CustomGridView extends StatelessWidget {
  final List<PersonModel> persons;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final double childAspectRatio;
  final double padding;

  CustomGridView(
      {required this.persons,
      this.crossAxisCount = 2,
      this.crossAxisSpacing = 4.0,
      this.childAspectRatio = 0.55,
      this.mainAxisSpacing = 4.0,
      this.padding = 5.0});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: persons.length,
      itemBuilder: (_, int index) {
        return PersonView(persons[index]);
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: crossAxisSpacing,
        mainAxisSpacing: mainAxisSpacing,
        childAspectRatio: childAspectRatio,
      ),
      padding: EdgeInsets.all(padding),
    );
  }
}
