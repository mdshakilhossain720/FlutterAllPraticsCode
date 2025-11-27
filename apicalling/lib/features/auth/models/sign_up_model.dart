class SignUpModel {
  String? name;
  String? email;
  String? phone;
  String? password;

  SignUpModel({this.name, this.email, this.password, this.phone});

  SignUpModel copyWith({
    String? name,
    String? email,
    String? password,
    String? phone,
  }) {
    return SignUpModel(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
      "phone": phone,
    };
  }
}
