class ServiceAuthUser {
  String email;
  String name;
  String? firstName;
  String? surname;
  String? phone;
  String? pictureUrl;
  String? uid;
  String platform;
  String? identityToken;

  ServiceAuthUser({
    required this.platform,
    required this.email,
    required this.name,
    this.phone,
    this.pictureUrl,
    this.uid,
    this.identityToken,
    this.firstName,
    this.surname,
  });

  String getFirstName() {
    if (firstName != null) {
      return firstName!;
    }

    var userName = name.trim();
    if (userName.contains(" ")) {
      var parts = userName.split(" ");
      return parts[1];
    }
    return userName;
  }

  String getSurname() {
    if (surname != null) {
      return surname!;
    }
    var userName = name.trim();
    if (userName.contains(" ")) {
      var parts = userName.split(" ");

      return parts[0];
    }

    return userName;
  }
}
