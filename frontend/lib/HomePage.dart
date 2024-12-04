import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'Navbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    print("Building HomePage");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Navbar(),
      body: const Center(child: TeacherInfoButton()),
    );
  }
}

class TeacherInfoButton extends StatefulWidget {
  const TeacherInfoButton({super.key});

  @override
  _TeacherInfoButtonState createState() => _TeacherInfoButtonState();
}

class _TeacherInfoButtonState extends State<TeacherInfoButton> {
  List<String> teacherNames = []; // 存儲所有老師名字
  String teacherName = ''; // 查詢特定 ID 的老師名字
  String teacherId = ''; // 使用者輸入的老師 ID

  // 查詢所有老師名字
  Future<void> fetchAllTeachers() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/teachers'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          // teacherNames = data.map((teacher) => teacher['teacherName'] ?? 'No name').toList();
          teacherNames = data.map<String>((teacher) => teacher['teacherName'] ?? 'No name').toList();
        });
        print('Fetched all teacher names: $teacherNames');
      } else {
        setState(() {
          teacherNames = ['Error fetching teacher names'];
        });
        print('Failed to fetch all teacher names: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        teacherNames = ['Network error'];
      });
      print('Failed to fetch all teacher names: $e');
    }
  }

  // 查詢特定 ID 的老師名字
  Future<void> fetchTeacherById() async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/teachers/$teacherId'),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(utf8.decode(response.bodyBytes));
        setState(() {
          teacherName = data['teacherName'] ?? 'No name found';
        });
        print('Fetched teacher name: $teacherName');
      } else {
        setState(() {
          teacherName = 'Teacher not found';
        });
        print('Failed to fetch teacher by ID: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        teacherName = 'Network error';
      });
      print('Failed to fetch teacher by ID: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Building TeacherInfoButton");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: fetchAllTeachers,
          child: const Text('Fetch All Teachers'),
        ),
        if (teacherNames.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: teacherNames.map((name) => Text(name, style: const TextStyle(fontSize: 16))).toList(),
            ),
          ),
        const SizedBox(height: 20),
        TextField(
          onChanged: (value) {
            teacherId = value;
          },
          decoration: const InputDecoration(
            labelText: 'Enter Teacher ID',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: fetchTeacherById,
          child: const Text('Fetch Teacher By ID'),
        ),
        if (teacherName.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              teacherName,
              style: const TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
      ],
    );
  }
}
