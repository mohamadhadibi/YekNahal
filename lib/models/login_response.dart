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
  String username;
  String email;
  String avatarUrl;
  int plantedNumber;
  int waitingPlantedNumber;

  LoginOb({
    this.token = '',
    this.username = '',
    this.email = '',
    this.avatarUrl = 'assets/images/ic_logo.png',
    this.plantedNumber = 0,
    this.waitingPlantedNumber = 0,
  });

  factory LoginOb.fromJson(Map<String, dynamic> json) {
    /*return LoginOb(
      token: '',
      username: '',
      email: '',
      avatarUrl: '',
      plantedNumber: 0,
      waitingPlantedNumber: 0,
    );*/
    return LoginOb(
      token: (json.containsKey('token') ? json['token'] : ''),
      username: (json.containsKey('username')) ? json['username'] : '',
      email: (json.containsKey('email')) ? json['email'] : '',
      avatarUrl: (json.containsKey('avatarUrl')) ? json['avatarUrl'] : '',
      plantedNumber: (json.containsKey('plantedNumber')) ? json['plantedNumber'] : 0,
      waitingPlantedNumber: (json.containsKey('waitingPlantedNumber')) ? json['waitingPlantedNumber'] : 0,
    );
  }
}
