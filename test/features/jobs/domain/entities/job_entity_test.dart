import 'package:flutter_test/flutter_test.dart';
import 'package:workbridge/features/jobs/domain/entities/job_entity.dart';

void main() {
  group('JobEntity', () {
    test('supports value equality including companyLogo and tags', () {
      const job1 = JobEntity(
        id: 'job_1',
        title: 'Senior UI/UX Designer',
        companyName: 'Vodafone Egypt',
        companyLogo: 'https://via.placeholder.com/150',
        location: 'New Cairo, Cairo',
        jobType: 'Full-time',
        salary: '25,000 EGP / Month',
        matchPercentage: 92,
        tags: ['Figma', 'UI/UX'],
      );

      const job2 = JobEntity(
        id: 'job_1',
        title: 'Senior UI/UX Designer',
        companyName: 'Vodafone Egypt',
        companyLogo: 'https://via.placeholder.com/150',
        location: 'New Cairo, Cairo',
        jobType: 'Full-time',
        salary: '25,000 EGP / Month',
        matchPercentage: 92,
        tags: ['Figma', 'UI/UX'],
      );

      const job3WithDifferentTags = JobEntity(
        id: 'job_1',
        title: 'Senior UI/UX Designer',
        companyName: 'Vodafone Egypt',
        companyLogo: 'https://via.placeholder.com/150',
        location: 'New Cairo, Cairo',
        jobType: 'Full-time',
        salary: '25,000 EGP / Month',
        matchPercentage: 92,
        tags: ['DifferentTag'],
      );

      const job4WithDifferentLogo = JobEntity(
        id: 'job_1',
        title: 'Senior UI/UX Designer',
        companyName: 'Vodafone Egypt',
        companyLogo: 'https://via.placeholder.com/200',
        location: 'New Cairo, Cairo',
        jobType: 'Full-time',
        salary: '25,000 EGP / Month',
        matchPercentage: 92,
        tags: ['Figma', 'UI/UX'],
      );

      expect(job1, equals(job2));
      expect(job1, isNot(equals(job3WithDifferentTags)));
      expect(job1, isNot(equals(job4WithDifferentLogo)));
    });

    test('props contains all fields including companyLogo and tags', () {
      const job = JobEntity(
        id: 'job_1',
        title: 'Senior UI/UX Designer',
        companyName: 'Vodafone Egypt',
        companyLogo: 'https://via.placeholder.com/150',
        location: 'New Cairo, Cairo',
        jobType: 'Full-time',
        salary: '25,000 EGP / Month',
        matchPercentage: 92,
        tags: ['Figma', 'UI/UX'],
      );

      expect(
        job.props,
        equals([
          'job_1',
          'Senior UI/UX Designer',
          'Vodafone Egypt',
          'https://via.placeholder.com/150',
          'New Cairo, Cairo',
          'Full-time',
          '25,000 EGP / Month',
          92,
          ['Figma', 'UI/UX'],
        ]),
      );
    });
  });
}
