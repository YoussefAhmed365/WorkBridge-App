import 'package:workbridge/features/auth/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({required super.id, required super.name, required super.email, required super.role, super.avatarUrl});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] ?? '', name: json['name'] ?? '', email: json['email'] ?? '', role: json['role'] ?? 'JOB_SEEKER', avatarUrl: json['avatarUrl']);
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'email': email, 'role': role, 'avatarUrl': avatarUrl};
  }
}
