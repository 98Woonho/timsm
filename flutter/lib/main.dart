import 'package:flutter/material.dart';
import 'package:timsm/models/employee_model.dart';
import 'package:timsm/services/employee_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIMSM',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const EmployeeListScreen(), // 첫 화면을 사원 리스트 화면으로 설정
    );
  }
}

class EmployeeListScreen extends StatefulWidget {
  const EmployeeListScreen({super.key});

  @override
  State<EmployeeListScreen> createState() => _EmployeeListScreenState();
}

class _EmployeeListScreenState extends State<EmployeeListScreen> {
  // 우리가 만든 서비스를 불러옵니다.
  final EmployeeService _employeeService = EmployeeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('사원 정보'),
        backgroundColor: Colors.blue.shade100,
      ),
      // FutureBuilder: 비동기 데이터(Future)를 기다려서 화면을 그려주는 아주 똑똑한 위젯입니다.
      body: FutureBuilder<List<EmployeeModel>>(
        future: _employeeService.fetchEmployees(), // 데이터를 가져오는 함수 실행
        builder: (context, snapshot) {
          // 1. 데이터를 기다리는 중일 때 (로딩 화면)
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          // 2. 에러가 발생했을 때
          if (snapshot.hasError) {
            return Center(
              child: Text('에러 발생: ${snapshot.error}',
                  style: const TextStyle(color: Colors.red)),
            );
          }

          // 3. 데이터가 성공적으로 왔을 때
          if (snapshot.hasData) {
            final employees = snapshot.data!;

            return ListView.builder(
              itemCount: employees.length,
              itemBuilder: (context, index) {
                final emp = employees[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(emp.korNm, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text('사번: ${emp.empNo}'),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            );
          }

          return const Center(child: Text('데이터가 없습니다.'));
        },
      ),
      // 새로고침 버튼
      floatingActionButton: FloatingActionButton(
        onPressed: () => setState(() {}), // 화면을 다시 그려서 데이터를 새로 불러옵니다.
        child: const Icon(Icons.refresh),
      ),
    );
  }
}