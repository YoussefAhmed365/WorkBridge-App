import 'package:equatable/equatable.dart';

class JobEntity extends Equatable {
  final String id;
  final String title;
  final String companyName;
  final String companyLogo;
  final String location;
  final String jobType; // 'Full-time', 'Part-time', 'Remote'
  final String salary;
  final int matchPercentage;
  final List<String> tags;

  const JobEntity({required this.id, required this.title, required this.companyName, required this.companyLogo, required this.location, required this.jobType, required this.salary, required this.matchPercentage, required this.tags});

  @override
  List<Object?> get props => [id, title, companyName, companyLogo, location, jobType, salary, matchPercentage, tags];
}