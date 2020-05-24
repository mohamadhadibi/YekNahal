import 'package:equatable/equatable.dart';

class OurTeamResponse {
  int status;
  List<OurTeam> data;
  String message;

  OurTeamResponse({
    this.status,
    this.message,
    this.data,
  });

  factory OurTeamResponse.fromJson(Map<String, dynamic> json) {
    return OurTeamResponse(
        status: json['status'],
        message: json['message'],
        data: (json['data'] as List).map((i) => OurTeam.fromJson(i)).toList()
    );
  }
}

class OurTeam extends Equatable {
  int id;
  String name;
  String position;
  String avatar;
  String link;

  OurTeam({
    this.id,
    this.name,
    this.position,
    this.avatar,
    this.link,
  });

  factory OurTeam.fromJson(Map<String, dynamic> json) {
    return OurTeam(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      avatar: json['avatar'],
      link: json['link'],
    );
  }

  @override
  String toString() => 'OurTeam { id: $id }';

}
