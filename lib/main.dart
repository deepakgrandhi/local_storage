import 'package:flutter/material.dart';
import 'package:local_storage/screens/add_employee.dart';
import 'package:local_storage/screens/employee_list_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Realtime Innovations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: "Poppins",
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => const EmployeeListPage(),
        "/add_employee": (context) => const EmployeeAddPage(),
      }
    );
  }
}