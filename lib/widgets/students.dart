import 'package:flutter/material.dart';
import '../models/student.dart';
import 'student_item.dart';

class StudentsScreen extends StatelessWidget {
  StudentsScreen({Key? key}) : super(key: key);

  final List<Student> students = [
    Student(
      firstName: 'Іван',
      lastName: 'Петров',
      department: Department.it,
      grade: 95,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Марія',
      lastName: 'Іваненко',
      department: Department.finance,
      grade: 88,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Олександр',
      lastName: 'Коваль',
      department: Department.law,
      grade: 76,
      gender: Gender.male,
    ),
    Student(
      firstName: 'Наталія',
      lastName: 'Шевченко',
      department: Department.medical,
      grade: 92,
      gender: Gender.female,
    ),
    Student(
      firstName: 'Андрій',
      lastName: 'Сидоренко',
      department: Department.it,
      grade: 60,
      gender: Gender.male,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Студенти'),
      ),
      body: ListView.builder(
        itemCount: students.length,
        itemBuilder: (context, index) {
          return StudentItem(student: students[index]);
        },
      ),
    );
  }
}
