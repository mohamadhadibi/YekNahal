class AuthResponse {
  int status;
  UserOb data;
  String message;

  AuthResponse({
    this.status,
    this.message,
    this.data,
  });

  factory AuthResponse.fromJson(Map<String, dynamic> json) {
    return AuthResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'].map((value) => UserOb.fromJson(value)),
    );
  }
}

class UserOb {
  String username;
  String email;
  String avatarUrl;
  int plantedNumber;
  int waitingPlantedNumber;

  UserOb({
    this.username = 'guest',
    this.email = '',
    this.avatarUrl = 'assets/images/ic_logo.png',
    this.plantedNumber = 0,
    this.waitingPlantedNumber = 0,
  });

  factory UserOb.fromJson(Map<String, dynamic> json) {
    return UserOb(
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      plantedNumber: json['plantedNumber'],
      waitingPlantedNumber: json['waitingPlantedNumber'],
    );
  }
}
