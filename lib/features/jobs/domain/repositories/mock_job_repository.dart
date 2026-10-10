import 'package:dartz/dartz.dart';
import 'package:workbridge/core/errors/failures.dart';
import 'package:workbridge/features/jobs/data/models/job_model.dart';
import 'package:workbridge/features/jobs/domain/entities/job_entity.dart';
import 'package:workbridge/features/jobs/domain/repositories/job_repository.dart';

class MockJobRepository implements JobRepository {
  final List<JobModel> _mockJobs = const [
    JobModel(id: 'job_1', title: 'Senior UI/UX Designer', companyName: 'Vodafone Egypt', companyLogo: 'https://via.placeholder.com/150', location: 'New Cairo, Cairo', jobType: 'Full-time', salary: '25,000 EGP / Month', matchPercentage: 92, tags: ['Figma', 'UI/UX', 'User Research']),
    JobModel(id: 'job_2', title: 'Flutter Mobile Developer', companyName: 'Paymob', companyLogo: 'https://via.placeholder.com/150', location: 'Maadi, Cairo', jobType: 'Full-time', salary: '30,000 EGP / Month', matchPercentage: 88, tags: ['Flutter', 'Dart', 'BLoC', 'Clean Architecture']),
    JobModel(id: 'job_3', title: 'Digital Marketing Specialist', companyName: 'Swvl', companyLogo: 'https://via.placeholder.com/150', location: 'Alexandria', jobType: 'Remote', salary: '18,000 EGP / Month', matchPercentage: 79, tags: ['SEO', 'Google Ads', 'Social Media']),
  ];

  @override
  Future<Either<Failure, List<JobEntity>>> getJobs() async {
    await Future.delayed(const Duration(seconds: 1));
    return Right(_mockJobs);
  }

  @override
  Future<Either<Failure, JobEntity>> getJobById(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final job = _mockJobs.firstWhere((element) => element.id == id);
      return Right(job);
    } catch (_) {
      return const Left(ServerFailure('الوظيفة غير موجودة'));
    }
  }
}