// ignore_for_file: public_member_api_docs, sort_constructors_first


class Course {
  final String name;
  List<StudentScore> ? students;
  Course({
    required this.name,
    required this.students,
  });
  
}

// class StudentScore {
//   final Course course;
//   final String name;
//   final double score;
//   StudentScore({required this.name, required this.score, required this.course});
// }


class StudentScore {
  // final Course course;
  final String name;
  final double score;
  StudentScore({required this.name, required this.score});
}