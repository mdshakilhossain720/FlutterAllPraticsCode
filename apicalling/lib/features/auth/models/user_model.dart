import 'dart:convert';

import 'package:rentalmanagement/features/auth/models/tenant_model.dart';

class UserModel {
  int? id;
  String? thumbnail;
  String? name;
  String? email;
  String? phone;
  bool? isApproved;
  String? emailVerifiedAt;
  Tenant? tenant;

  UserModel({
    this.id,
    this.thumbnail,
    this.name,
    this.email,
    this.phone,
    this.isApproved,
    this.emailVerifiedAt,
    this.tenant,
  });

  factory UserModel.fromMap(Map<dynamic, dynamic> data) => UserModel(
    id: data['id'] as int?,
    thumbnail: data['thumbnail'] as String?,
    name: data['name'] as String?,
    email: data['email'] as String?,
    phone: data['phone'] as String?,
    isApproved: data['is_approved'] as bool?,
    emailVerifiedAt: data['email_verified_at'] as String?,
    tenant: data['tenant'] == null
        ? null
        : Tenant.fromMap(data['tenant'] as Map<dynamic, dynamic>),
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'thumbnail': thumbnail,
    'name': name,
    'email': email,
    'phone': phone,
    'is_approved': isApproved,
    'email_verified_at': emailVerifiedAt,
    'tenant': tenant?.toMap(),
  };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [UserModel].
  factory UserModel.fromJson(String data) {
    return UserModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [UserModel] to a JSON string.
  String toJson() => json.encode(toMap());
}
