import 'package:dartz/dartz.dart';
import 'package:workbridge/core/errors/failures.dart';
import 'package:workbridge/features/jobs/domain/entities/job_entity.dart';

abstract class JobRepository {
  Future<Either<Failure, List<JobEntity>>> getJobs();

  Future<Either<Failure, JobEntity>> getJobById(String id);
}