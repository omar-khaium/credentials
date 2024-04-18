class CredentialEntity {
  final String id;
  final String username;
  final String password;
  final String url;
  final String remarks;
  final DateTime createdAt;
  final String createdBy;
  final DateTime lastUpdatedAt;
  final bool isActive;

  CredentialEntity({
    required this.id,
    required this.username,
    required this.password,
    required this.url,
    required this.remarks,
    required this.createdAt,
    required this.createdBy,
    required this.lastUpdatedAt,
    required this.isActive,
  });
}
