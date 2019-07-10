import 'package:equatable/equatable.dart';

class NahalShopInfoResponse {
  int status;
  List<NahalOb> nahal;
  List<HemayatOb> hemayat;
  String message;

  NahalShopInfoResponse({
    this.status,
    this.message,
    this.nahal,
    this.hemayat,
  });

  factory NahalShopInfoResponse.fromJson(Map<String, dynamic> json) {
    return NahalShopInfoResponse(
      status: json['status'],
      message: json['message'],
      nahal: (json['nahal'] as List).map((i) => NahalOb.fromJson(i)).toList(),
      hemayat: (json['hemayat'] as List).map((i) => HemayatOb.fromJson(i)).toList(),
    );
  }
}

class NahalOb extends Equatable {
  int id;
  String name;

  NahalOb({
    this.id,
    this.name,
  });

  factory NahalOb.fromJson(Map<String, dynamic> json) {
    return NahalOb(
      id: json['id'],
      name: json['name'],
    );
  }
}

class HemayatOb extends Equatable {
  int id;
  String name;

  HemayatOb({
    this.id,
    this.name,
  });

  factory HemayatOb.fromJson(Map<String, dynamic> json) {
    return HemayatOb(
      id: json['id'],
      name: json['name'],
    );
  }
}
