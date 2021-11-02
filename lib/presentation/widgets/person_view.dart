import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sofico_task/data/models/person_model.dart';
import 'package:sofico_task/routes/routes_constants.dart';
import 'package:sofico_task/utils/date_time_utils.dart';

class PersonView extends StatelessWidget {
  final PersonModel person;

  PersonView(this.person);

  @override
  Widget build(BuildContext context) {
    Widget fieldTile({required String value, required IconData icon}) {
      return Row(
        children: [
          Icon(
            icon,
            color: Colors.grey.shade600,
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.lato(color: Colors.black, fontSize: 15),
            ),
          ),
        ],
      );
    }

    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, Routes.addOrEditPersonScreen,
            arguments: person);
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Container(
                width: 120.0,
                height: 120.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(person.avatar))),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                person.name,
                style: GoogleFonts.arimaMadurai(
                    fontSize: 20, fontWeight: FontWeight.w800),
              ),
              SizedBox(
                height: 15,
              ),
              fieldTile(value: person.email, icon: Icons.email),
              SizedBox(
                height: 10,
              ),
              fieldTile(value: person.country, icon: Icons.location_on),
              SizedBox(
                height: 10,
              ),
              fieldTile(
                  value: DateTimeUtils.calculateAgeFromDateOfBirth(person.dob)
                      .toString(),
                  icon: Icons.people),
            ],
          ),
        ),
      ),
    );
  }
}
