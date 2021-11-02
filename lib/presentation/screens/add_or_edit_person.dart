import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sofico_task/bloc/add_or_edit_person_cubit/add_or_edit_person_cubit.dart';
import 'package:sofico_task/data/models/person_model.dart';
import 'package:sofico_task/presentation/widgets/custom_button.dart';
import 'package:sofico_task/presentation/widgets/loading_dialogue.dart';
import 'package:sofico_task/res/app_colors.dart';
import 'package:sofico_task/res/strings_constants.dart';
import 'package:sofico_task/utils/date_time_utils.dart';
import 'package:sofico_task/utils/validator.dart';
import '../widgets/custom_text_field.dart';

class AddOrEditPerson extends StatefulWidget {
  final PersonModel? person;

  AddOrEditPerson({this.person});

  @override
  _AddOrEditPersonState createState() => _AddOrEditPersonState();
}

class _AddOrEditPersonState extends State<AddOrEditPerson> {
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<State> _keyLoader = GlobalKey<State>();
  late DateTime initialDate = DateTime.utc(2014, 1,1);
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController dateOfBirthController;
  late TextEditingController countryController;
  late TextEditingController avatarController;
  Validator validator = Validator();
  bool isAvatarAvailable = false;

  @override
  void initState() {
    super.initState();
    initializeTextFields();
    if (widget.person != null) {
      initialDate = DateTime.parse(widget.person!.dob);
    }
    avatarController.addListener(() {
      setState(() {
        isAvatarAvailable = Uri.parse(avatarController.text).isAbsolute;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(StringsConstants.addPerson),
        actions: [
         widget.person !=null ? IconButton(onPressed: deleteFunction, icon: Icon(Icons.delete)) : Container()
        ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                    backgroundColor: AppColors.lightGrey,

                    backgroundImage: isAvatarAvailable || widget.person != null
                        ? NetworkImage(avatarController.text,)
                        : null,
                    radius: 50,
                    child: Container()),
                const SizedBox(
                  height: 50,
                ),
                CustomTextField(
                    validator: validator.validateAvatar,
                    hintText: StringsConstants.avatar,
                    controller: avatarController),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    validator: validator.validateName,
                    hintText: StringsConstants.name,
                    controller: nameController),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    validator: validator.validateEmail,
                    hintText: StringsConstants.email,
                    keyboardType: TextInputType.emailAddress,
                    controller: emailController),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                    validator: validator.validateDateOfBirth,
                    hintText: StringsConstants.dateOfBirth,
                    onTap: pickDate,
                    controller: dateOfBirthController),
                const SizedBox(
                  height: 15,
                ),
                CustomTextField(
                  validator: validator.validateCountry,
                  hintText: StringsConstants.country,
                  controller: countryController,
                  onTap: pickCountry,
                ),
                const SizedBox(
                  height: 30,
                ),
                BlocConsumer<AddOrEditPersonCubit, AddOrEditPersonState>(
                  listener: (context, state) async {
                    if (state is AddOrEditPersonFinished) {
                      // clearTextFields();
                      Navigator.of(_keyLoader.currentContext!,
                              rootNavigator: true)
                          .pop();
                      Navigator.pop(context);
                    } else if (state is Error) {
                      Navigator.of(_keyLoader.currentContext!,
                              rootNavigator: true)
                          .pop();
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                        onPressed: addOrEditFunction,
                        title: widget.person == null
                            ? StringsConstants.submit
                            : StringsConstants.edit);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addOrEditFunction() async {
    if (_formKey.currentState!.validate()) {
      showLoadingDialog(context, _keyLoader);
      PersonModel person = PersonModel(
          name: nameController.text,
          country: countryController.text,
          dob: initialDate.toIso8601String(),
          email: emailController.text,
          avatar: avatarController.text);
      if (widget.person == null) {
        await BlocProvider.of<AddOrEditPersonCubit>(context).addPerson(person);
      } else {
        await BlocProvider.of<AddOrEditPersonCubit>(context)
            .updatePerson(person, widget.person!.id!);
      }
    }
  }

  void deleteFunction() async {
    showLoadingDialog(context, _keyLoader);
    await BlocProvider.of<AddOrEditPersonCubit>(context)
        .deletePerson(widget.person!.id!);
  }

  Future pickDate() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: DateTime.utc(1910, 1),
        lastDate: DateTime.utc(2014, 1,1));
    if (pickedDate != null) {
      initialDate = pickedDate;
      setState(() {
        dateOfBirthController.text =
            DateTimeUtils.convertDateTimeToDateOfBirth(pickedDate);
      });
    }
  }

  initializeTextFields() {
    nameController = TextEditingController(text: widget.person?.name);
    emailController = TextEditingController(text: widget.person?.email);
    dateOfBirthController = TextEditingController(
        text: widget.person?.dob != null
            ? DateTimeUtils.convertIsoDateTimeToDateOfBirth(widget.person!.dob)
            : null);
    countryController = TextEditingController(text: widget.person?.country);
    avatarController = TextEditingController(text: widget.person?.avatar);
  }

  void pickCountry() {
    showCountryPicker(
      context: context,
      onSelect: (Country country) {
        setState(() {
          countryController.text = country.name;
        });
      },
      countryListTheme: CountryListThemeData(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
        ),
        // Optional. Styles the search field.
        inputDecoration: InputDecoration(
          labelText: StringsConstants.search,
          hintText: StringsConstants.startTypingToSearch,
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: const Color(0xFF8C98A8).withOpacity(0.2),
            ),
          ),
        ),
      ),
    );
  }
}
