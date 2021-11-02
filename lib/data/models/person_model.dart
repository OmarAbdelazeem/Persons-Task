class PersonModel {
  int? id;
  String name;
  String email;
  String dob;
  String country;
  String avatar;

  PersonModel(
      { this.id,
      required this.name,
      required this.country,
      required this.dob,
      required this.email,
      required this.avatar});

  factory PersonModel.fromJson( json) {
    return PersonModel(
        id: json["id"],
        name: json["name"],
        country: json["country"],
        dob: json["dob"],
        email: json["email"],
        avatar: json["avatar"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "dob": dob,
      "country": country,
      "avatar": avatar
    };
  }
}
