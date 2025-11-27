import 'dart:convert';

class Tenant {
  int? id;
  String? designation;

  Tenant({this.id, this.designation});

  factory Tenant.fromMap(Map<dynamic, dynamic> data) => Tenant(
    id: data['id'] as int?,
    designation: data['designation'] as String?,
  );

  Map<String, dynamic> toMap() => {'id': id, 'designation': designation};

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Tenant].
  factory Tenant.fromJson(String data) {
    return Tenant.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Tenant] to a JSON string.
  String toJson() => json.encode(toMap());
}
