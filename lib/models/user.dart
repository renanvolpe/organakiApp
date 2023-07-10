// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String? token;
  String? id;
  String name;
  String email;
  String? password;
  User(
    this.token,
    this.id,
    this.name,
    this.email,
    this.password,
  );

  User copyWith({
    String? token,
    String? id,
    String? name,
    String? email,
    String? password,
  }) {
    return User(
      token ?? this.token,
      id ?? this.id,
      name ?? this.name,
      email ?? this.email,
      password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'token': token,
      'id': id,
      'name': name,
      'email': email,
      'password': password,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      map['token'] != null ? map['token'] as String : null,
      map['id'] != null ? map['id'] as String : null,
      map['name'] as String,
      map['email'] as String,
      map['password'] != null ? map['password'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(token: $token, id: $id, name: $name, email: $email, password: $password)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;
  
    return 
      other.token == token &&
      other.id == id &&
      other.name == name &&
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode {
    return token.hashCode ^
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      password.hashCode;
  }
}
