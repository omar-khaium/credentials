import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials/src/utils/encrypter.dart';
import 'package:flutter/cupertino.dart';

class Credential {
  String id;
  String username;
  String password;
  String url;
  String remarks;
  int createdAt;
  String createdBy;
  int lastUpdatedAt;
  bool isActive;

  Credential({
    this.id,
    @required this.username,
    @required this.password,
    @required this.url,
    @required this.remarks,
    this.createdAt,
    this.createdBy,
    this.lastUpdatedAt,
    @required this.isActive,
  });

  Map<String, dynamic> get toCreateMap => <String, dynamic>{
        "username": username,
        "password": Encrypted.to(password),
        "url": url,
        "remarks": remarks,
        "createdAt": createdAt,
        "createdBy": createdBy,
        "lastUpdatedAt": lastUpdatedAt,
        "isActive": isActive,
      };

  Map<String, dynamic> get toEditMap => <String, dynamic>{
        "id": id,
        "username": username,
        "password": Encrypted.to(password),
        "url": url,
        "remarks": remarks,
        "createdAt": createdAt,
        "createdBy": createdBy,
        "lastUpdatedAt": lastUpdatedAt,
        "isActive": isActive,
      };

  Credential.fromSnapshot(QueryDocumentSnapshot snapshot) {
    id = snapshot.id;
    username = snapshot.get("username");
    password = Encrypted.from(snapshot.get("password"));
    url = snapshot.get("url");
    remarks = snapshot.get("remarks") ?? "";
    createdAt = snapshot.get("createdAt");
    createdBy = snapshot.get("createdBy");
    lastUpdatedAt = snapshot.get("lastUpdatedAt");
    isActive = snapshot.get("isActive");
  }
}
