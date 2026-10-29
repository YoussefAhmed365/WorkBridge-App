import 'package:flutter_test/flutter_test.dart';
import 'package:workbridge/core/errors/failures.dart';
import 'package:workbridge/features/jobs/data/models/job_model.dart';
import 'package:workbridge/features/jobs/domain/repositories/mock_job_repository.dart';

void main() {
  late MockJobRepository repository;

  setUp(() {
    repository = MockJobRepository();
  });

  group('MockJobRepository', () {
    group('getJobs', () {
      test('returns Right list of mock jobs', () async {
        final result = await repository.getJobs();

        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not fail'),
          (jobs) {
            expect(jobs.length, equals(3));
            expect(jobs.first, isA<JobModel>());
            expect(jobs.first.id, equals('job_1'));
          },
        );
      });
    });

    group('getJobById', () {
      test('returns Right(JobModel) when job with existing ID is found', () async {
        final result = await repository.getJobById('job_2');

        expect(result.isRight(), isTrue);
        result.fold(
          (failure) => fail('Should not fail'),
          (job) {
            expect(job, isA<JobModel>());
            expect(job.id, equals('job_2'));
            expect(job.title, equals('Flutter Mobile Developer'));
          },
        );
      });

      test('returns Left(ServerFailure) when job ID is not found', () async {
        final result = await repository.getJobById('non_existing_job');

        expect(result.isLeft(), isTrue);
        result.fold(
          (failure) {
            expect(failure, isA<ServerFailure>());
            expect(failure.message, equals('الوظيفة غير موجودة'));
          },
          (job) => fail('Should not return job'),
        );
      });
    });
  });
}
