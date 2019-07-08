class LoginResponse {
  int status;
  LoginOb data;
  String message;

  LoginResponse({
    this.status,
    this.message,
    this.data,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'].map((value) => LoginOb.fromJson(value)),
    );
  }
}

class LoginOb {
  String token;
  String status;
  String username;
  String email;
  String avatarUrl;
  int plantedNumber;
  int waitingPlantedNumber;


  LoginOb({
    this.token = '',
    this.status = '',
    this.username = '',
    this.email = '',
    this.avatarUrl = 'assets/images/ic_logo.png',
    this.plantedNumber = 0,
    this.waitingPlantedNumber = 0,
  });

  factory LoginOb.fromJson(Map<String, dynamic> json) {
    return LoginOb(
      token: json['token'],
      status: json['status'],
      username: json['username'],
      email: json['email'],
      avatarUrl: json['avatarUrl'],
      plantedNumber: json['plantedNumber'],
      waitingPlantedNumber: json['waitingPlantedNumber'],
    );
  }
}
