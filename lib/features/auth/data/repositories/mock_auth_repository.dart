import 'package:dartz/dartz.dart';
import 'package:workbridge/core/errors/failures.dart';
import 'package:workbridge/features/auth/data/models/user_model.dart';
import 'package:workbridge/features/auth/domain/entities/user_entity.dart';
import 'package:workbridge/features/auth/domain/repositories/auth_repository.dart';

class MockAuthRepository implements AuthRepository {
  @override
  Future<Either<Failure, UserEntity>> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'error@workbridge.eg') {
      return const Left(ServerFailure('Credentials Are Not Correct'));
    }
    const user = UserModel(id: 'usr_101', name: 'Youssef Ahmed', email: 'user@workbridge.eg', role: 'JOB_SEEKER');
    return const Right(user);
  }

  @override
  Future<Either<Failure, UserEntity>> register(String name, String email, String password, String role) async {
    await Future.delayed(const Duration(seconds: 1));
    final user = UserModel(id: 'usr_${DateTime.now().millisecondsSinceEpoch}', name: name, email: email, role: role);
    return Right(user);
  }

  @override
  Future<Either<Failure, void>> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const Right(null);
  }
}
