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
      body: const Center(child: TeacherInfoButton()), // 使用一個按鈕
    );
  }
}

class TeacherInfoButton extends StatefulWidget {
  const TeacherInfoButton({super.key});

  @override
  _TeacherInfoButtonState createState() => _TeacherInfoButtonState();
}

class _TeacherInfoButtonState extends State<TeacherInfoButton> {
  String teacherName = ''; // 存儲查詢結果

  // 發送請求來查詢老師資料
  Future<void> fetchTeacherName() async {
    print('Fetching teacher name for teacherId 1115526');
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/teachers/1115526')
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        setState(() {
          teacherName = data['teacherName'] ?? 'No name found';
        });
        print('Fetched teacher name: $teacherName');
      } else {
        setState(() {
          teacherName = 'Error fetching name';
        });
        print('Failed to fetch teacher name: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        teacherName = 'Network error';
      });
      print('Failed to fetch teacher name: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Building TeacherInfoButton");

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: fetchTeacherName, // 按下後查詢
          child: const Text('Fetch Teacher Info'),
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
