import 'package:flutter/material.dart';

import '../models/course.dart';

class CoursesView extends StatefulWidget {
  const CoursesView({
    super.key,
  });

  @override
  State<CoursesView> createState() => _CoursesViewState();
}

class _CoursesViewState extends State<CoursesView> {
  List<Course> courses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Score App')),
        body: ListView.builder(
          itemCount: courses.length,
           itemBuilder: (BuildContext context, int index) {
           
            CourseCard(courses: courses);
            return null;
              })
            );
           }
      
}

class CourseCard extends StatelessWidget {
  const CourseCard({
    super.key,
    required this.courses,
  });
  
  final List<Course> courses;
  
  get index => index.value;

  @override
  Widget build(BuildContext context) {
    return Row(
      
      children: [
         Text(courses[index].name),
      
      if (courses[index].students!.isNotEmpty) Column(
        children: [
          Text(courses[index].students!.length as String),
          const Text('Avg'),
          // Text(courses[index].students.)
        ],
      )
      ],
    );
  }
}



