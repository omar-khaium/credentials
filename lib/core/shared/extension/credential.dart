import '../../../features/credential/domain/entities/credential.dart';
import '../encrypter.dart';

extension CredentialExtension on CredentialEntity {
  CredentialEntity copyWith({
    String? id,
    String? url,
    String? username,
    String? password,
    String? createdBy,
    bool? isActive,
    String? remarks,
    DateTime? createdAt,
    DateTime? lastUpdatedAt,
    String? logo,
    int? hitCount,
  }) {
    return CredentialEntity(
      id: id ?? this.id,
      url: url ?? this.url,
      username: username ?? this.username,
      password: password ?? this.password,
      createdBy: createdBy ?? this.createdBy,
      isActive: isActive ?? this.isActive,
      remarks: remarks ?? this.remarks,
      createdAt: createdAt ?? this.createdAt,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
      logo: logo ?? this.logo,
      hitCount: hitCount ?? this.hitCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "username": username,
      "password": Encrypted.to(password),
      "url": url,
      "remarks": remarks,
      "createdAt": createdAt.millisecondsSinceEpoch,
      "createdBy": createdBy,
      "lastUpdatedAt": lastUpdatedAt.millisecondsSinceEpoch,
      "isActive": isActive,
      "logo": logo,
      "hitCount": hitCount,
    };
  }
}
