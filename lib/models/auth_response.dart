class AuthOb {
  int status;
  UserOb data;
  String message;

  AuthOb({
    this.status,
    this.message,
    this.data,
  });

  factory AuthOb.fromJson(Map<String, dynamic> json) {
    return AuthOb(
      status: json['status'],
      message: json['message'],
      data: json['data'].map((value) => UserOb.fromJson(value)),
    );
  }
}

class UserOb {
  bool isValid;
  String username;
  String email;
  String avatarUrl;
  int plantedNumber;
  int waitingPlantedNumber;

  UserOb({
    this.isValid = false,
    this.username = 'guest',
    this.email = '',
    this.avatarUrl = 'assets/images/ic_logo.png',
    this.plantedNumber = 0,
    this.waitingPlantedNumber = 0,
  });

  factory UserOb.fromJson(Map<String, dynamic> json) {
    return UserOb(
      isValid: json['isValid'],
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      plantedNumber: json['plantedNumber'],
      waitingPlantedNumber: json['waitingPlantedNumber'],
    );
  }
}
