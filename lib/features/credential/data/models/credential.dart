import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials/features/credential/domain/entities/credential.dart';

class CredentialModel extends CredentialEntity {
  CredentialModel({
    required super.id,
    required super.username,
    required super.password,
    required super.url,
    required super.remarks,
    required super.createdAt,
    required super.createdBy,
    required super.lastUpdatedAt,
    required super.isActive,
    required super.logo,
    required super.hitCount,
  });

  factory CredentialModel.parse({
    required QueryDocumentSnapshot<Map<String, dynamic>> doc,
  }) {
    final Map<String, dynamic> map = Map<String, dynamic>.from(doc.data());
    return CredentialModel(
      id: doc.id,
      username: map['username'],
      password: map['password'],
      url: map['url'],
      remarks: map['remarks'],
      createdAt: DateTime.fromMillisecondsSinceEpoch(map['createdAt']).add(DateTime.now().timeZoneOffset),
      createdBy: map['createdBy'],
      lastUpdatedAt: DateTime.fromMillisecondsSinceEpoch(map['lastUpdatedAt']).add(DateTime.now().timeZoneOffset),
      isActive: map['isActive'],
      logo: map['logo'],
      hitCount: map['hitCount'],
    );
  }
}
