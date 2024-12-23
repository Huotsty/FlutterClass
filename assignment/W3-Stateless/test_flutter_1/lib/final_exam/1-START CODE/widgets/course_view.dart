import 'package:flutter/material.dart';

import '../models/course.dart';
import 'score_form.dart';

class CourseView extends StatefulWidget {
  final List<StudentScore> students;

  const CourseView({super.key, required this.students});

  @override
  State<CourseView> createState() => _CourseViewState();
}

class _CourseViewState extends State<CourseView> {
  late List<StudentScore>? cureentstudents;

  @override
  void initState() {
    super.initState();
    cureentstudents = widget.students;
  }

  Future<void> _addNewStudent(StudentScore student) async {
    final newStudent = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => AddStudentForm(
          inputedStudent: student,
        ),
      ),
    );
    if (context.mounted && newStudent != null) return;

    setState(() {
      cureentstudents?.add(newStudent);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course View each course'),
        actions: [
          IconButton(
              onPressed: () => _addNewStudent, icon: const Icon(Icons.plus_one))
        ],
      ),
      body: ListView.builder(
        itemCount: cureentstudents!.length,
        itemBuilder: (ctx, index) => Student(
          student: cureentstudents![index],
        ),
      ),
    );
  }
}

Color getScoreColor(dynamic student) {
  if (student.score > 50) {
    return Colors.green;
  } else if (student.score >= 30 && student.score <= 50) {
    return Colors.orange;
  } else if (student.score < 30) {
    return Colors.red;
  } else {
    return const Color.fromARGB(255, 28, 120, 31);
  }
}

class Student extends StatelessWidget {
  const Student({super.key, required this.student});
  final StudentScore student;
  @override
  Widget build(BuildContext context) {
    return Placeholder(
      child: Row(
        children: [
          Text(student.name),
          Text(
            student.score as String,
            style: TextStyle(color: getScoreColor(student)),
          )
        ],
      ),
    );
  }
}
