import 'package:flutter_test/flutter_test.dart';
import 'package:workbridge/features/jobs/data/models/job_model.dart';
import 'package:workbridge/features/jobs/domain/entities/job_entity.dart';

void main() {
  group('JobModel', () {
    const tJobModel = JobModel(
      id: 'job_1',
      title: 'Senior UI/UX Designer',
      companyName: 'Vodafone Egypt',
      companyLogo: 'https://via.placeholder.com/150',
      location: 'New Cairo, Cairo',
      jobType: 'Full-time',
      salary: '25,000 EGP / Month',
      matchPercentage: 92,
      tags: ['Figma', 'UI/UX', 'User Research'],
    );

    test('is a subclass of JobEntity', () {
      expect(tJobModel, isA<JobEntity>());
    });

    group('fromJson', () {
      test('deserializes valid JSON with tags and match percentage correctly', () {
        final Map<String, dynamic> jsonMap = {
          'id': 'job_1',
          'title': 'Senior UI/UX Designer',
          'companyName': 'Vodafone Egypt',
          'companyLogo': 'https://via.placeholder.com/150',
          'location': 'New Cairo, Cairo',
          'jobType': 'Full-time',
          'salary': '25,000 EGP / Month',
          'matchPercentage': 92,
          'tags': ['Figma', 'UI/UX', 'User Research'],
        };

        final result = JobModel.fromJson(jsonMap);

        expect(result, equals(tJobModel));
      });

      test('applies default fallback values when fields are missing', () {
        final Map<String, dynamic> jsonMap = {};

        final result = JobModel.fromJson(jsonMap);

        expect(result.id, equals(''));
        expect(result.title, equals(''));
        expect(result.companyName, equals(''));
        expect(result.companyLogo, equals(''));
        expect(result.location, equals(''));
        expect(result.jobType, equals(''));
        expect(result.salary, equals(''));
        expect(result.matchPercentage, equals(0));
        expect(result.tags, isEmpty);
      });
    });

    group('toJson', () {
      test('serializes JobModel to Map matching contract', () {
        final result = tJobModel.toJson();

        final expectedMap = {
          'id': 'job_1',
          'title': 'Senior UI/UX Designer',
          'companyName': 'Vodafone Egypt',
          'companyLogo': 'https://via.placeholder.com/150',
          'location': 'New Cairo, Cairo',
          'jobType': 'Full-time',
          'salary': '25,000 EGP / Month',
          'matchPercentage': 92,
          'tags': ['Figma', 'UI/UX', 'User Research'],
        };

        expect(result, equals(expectedMap));
      });
    });
  });
}
