import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:workbridge/core/network/dio_client.dart';
import 'package:workbridge/core/utils/secure_storage_service.dart';
import 'package:workbridge/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:workbridge/features/auth/domain/repositories/auth_repository.dart';
import 'package:workbridge/features/jobs/domain/repositories/job_repository.dart';
import 'package:workbridge/features/jobs/domain/repositories/mock_job_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Core - External & Services (Dio, SecureStorage, Hive, etc.)
  sl.registerLazySingleton<FlutterSecureStorage>(() => const FlutterSecureStorage());

  sl.registerLazySingleton<SecureStorageService>(() => SecureStorageService(sl()));

  sl.registerLazySingleton<Dio>(() => Dio());

  sl.registerLazySingleton<DioClient>(() => DioClient(sl(), sl()));

  //! Features - Injection Registration (Will be added per feature)
  // Auth
  sl.registerLazySingleton<AuthRepository>(() => MockAuthRepository());

  // Jobs
  sl.registerLazySingleton<JobRepository>(() => MockJobRepository());
}