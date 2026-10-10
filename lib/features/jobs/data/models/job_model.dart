import '../../domain/entities/job_entity.dart';

class JobModel extends JobEntity {
  const JobModel({required super.id, required super.title, required super.companyName, required super.companyLogo, required super.location, required super.jobType, required super.salary, required super.matchPercentage, required super.tags});

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(id: json['id'] ?? '', title: json['title'] ?? '', companyName: json['companyName'] ?? '', companyLogo: json['companyLogo'] ?? '', location: json['location'] ?? '', jobType: json['jobType'] ?? '', salary: json['salary'] ?? '', matchPercentage: json['matchPercentage'] ?? 0, tags: List<String>.from(json['tags'] ?? []));
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'title': title, 'companyName': companyName, 'companyLogo': companyLogo, 'location': location, 'jobType': jobType, 'salary': salary, 'matchPercentage': matchPercentage, 'tags': tags};
  }
}