import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final String name;
  final String email;
  final String role; // 'JOB_SEEKER', 'BUSINESS_OWNER', 'SERVICE_REQUESTER'
  final String? avatarUrl;

  const UserEntity({required this.id, required this.name, required this.email, required this.role, this.avatarUrl});

  @override
  List<Object?> get props => [id, name, email, role, avatarUrl];
}
