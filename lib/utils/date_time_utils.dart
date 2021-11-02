class DateTimeUtils {

  static int calculateAgeFromDateOfBirth(String dob) {
    DateTime dateTime = DateTime.parse(dob);
    int age =  DateTime.now().year - dateTime.year;
    return age;
  }

  static String convertDateTimeToDateOfBirth(DateTime dateTime) {
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }

  static String convertIsoDateTimeToDateOfBirth(String isoDateTime){
    DateTime dateTime = DateTime.parse(isoDateTime);
    return "${dateTime.year}-${dateTime.month}-${dateTime.day}";
  }
}
