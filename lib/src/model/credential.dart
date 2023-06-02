import 'package:cloud_firestore/cloud_firestore.dart';
import '../utils/encrypter.dart';

class Credential {
  final String id;
  final String username;
  final String password;
  final String url;
  final String remarks;
  final int createdAt;
  final String createdBy;
  final int lastUpdatedAt;
  final bool isActive;

  Credential({
    this.id = "",
    required this.username,
    required this.password,
    required this.url,
    required this.remarks,
    required this.createdAt,
    required this.createdBy,
    required this.lastUpdatedAt,
    required this.isActive,
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

  factory Credential.fromSnapshot(QueryDocumentSnapshot snapshot) {
    return Credential(
      id: snapshot.id,
      username: snapshot.get("username"),
      password: Encrypted.from(
        snapshot.get("password"),
      ),
      url: snapshot.get("url"),
      remarks: snapshot.get("remarks") ?? "",
      createdAt: snapshot.get("createdAt"),
      createdBy: snapshot.get("createdBy"),
      lastUpdatedAt: snapshot.get("lastUpdatedAt"),
      isActive: snapshot.get("isActive"),
    );
  }
}
