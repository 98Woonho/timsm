import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 입력을 제어하기 위한 컨트롤러
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Center(
          child: SingleChildScrollView( // 키보드가 올라올 때 화면 가림 방지
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. 상단 타이틀
                const Text(
                  'TIMS-M',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 50), // 간격 조절

                // 2. ID 입력창
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: '사원번호(ID)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                ),
                const SizedBox(height: 20),

                // 3. PW 입력창
                TextField(
                  controller: _pwController,
                  obscureText: true, // 비밀번호 가리기
                  decoration: const InputDecoration(
                    labelText: '비밀번호(PW)',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 30),

                // 4. 로그인 버튼
                SizedBox(
                  width: double.infinity, // 버튼 너비를 꽉 채우기
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // 나중에 여기서 Backend API(Spring Boot)와 통신합니다.
                      print('ID: ${_idController.text}, PW: ${_pwController.text}');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      '로그인',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}