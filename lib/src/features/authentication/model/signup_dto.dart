import 'dart:convert';

class SignupDTO {
  final String email;
  final String password;
  final String marketName;
  final String fullName;
  SignupDTO({
    required this.email,
    required this.password,
    required this.marketName,
    required this.fullName,
  });

  SignupDTO copyWith({
    String? email,
    String? password,
    String? marketName,
    String? fullName,
  }) {
    return SignupDTO(
      email: email ?? this.email,
      password: password ?? this.password,
      marketName: marketName ?? this.marketName,
      fullName: fullName ?? this.fullName,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'marketName': marketName,
      'fullName': fullName,
    };
  }

  factory SignupDTO.fromMap(Map<String, dynamic> map) {
    return SignupDTO(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      marketName: map['marketName'] ?? '',
      fullName: map['fullName'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory SignupDTO.fromJson(String source) => SignupDTO.fromMap(json.decode(source));
}
