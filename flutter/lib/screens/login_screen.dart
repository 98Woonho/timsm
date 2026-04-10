import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timsm/models/employee_model.dart';
import 'package:timsm/widgets/common_dialogs.dart';
import 'package:timsm/services/api_service.dart';
import 'package:dio/dio.dart';

import '../providers/employee_provider.dart';


// StatefulWidget : 화면의 상태(데이터)가 변할 수 있는 위젯
// 사용자가 글자를 입력하면 화면이 변해야 하므로 Stateful 사용
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // 입력을 제어하기 위한 컨트롤러
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();

  // dispose(): 이 화면이 사라질 때 자동으로 호출되는 메서드
  // Controller 같은 자원을 여기서 해제해줘야 메모리 누수 방지
  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: 앱 화면의 기본 뼈대 위젯
    // appBar(상단바), body(본문), bottomNavigationBar(하단바) 등 기본 레이아웃 구조를 제공
    return Scaffold(
      backgroundColor: Colors.white,

      // Padding : 자식 위젯 주변에 여백을 주는 위젯
      body: Padding(
        // symmetric(horizontal: 30.0) -> 좌우 30px 여백
        padding: const EdgeInsets.symmetric(horizontal: 30.0),

        // Center : 자식 위젯을 화면의 정중앙에 배치하는 위젯
        child: Center(

          // SingleChildScrollView: 내용이 화면을 넘칠 때 스크롤 가능하게 해주는 위젯
          // 키보드가 올라올 때 입력창이 가려지는 것을 방지
          child: SingleChildScrollView(

            // Column: 자식 위젯들을 세로(↓)로 나열하는 위젯
            // 반대로 Row는 가로(→)로 나열
            child: Column(

              // mainAxisAlignment: 세로 방향 정렬 방식 설정
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // Image.asset: 앱 내부에 저장된 이미지를 표시하는 위젯
                // pubspec.yaml의 assets 섹션에 경로 등록 필요
                Image.asset(
                  'assets/images/bus.jpg',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                ),

                // SizedBox: 고정된 크기의 빈 공간을 만드는 위젯
                // 위젯 사이 간격 조절할 때 주로 사용
                const SizedBox(height: 30),

                // 1. 상단 타이틀
                // Text: 텍스트를 화면에 표시하는 위젯
                // TextStyle로 글자 크기, 굵기, 색상 등 스타일 지정
                const Text(
                  'TIMS-M',
                  style: TextStyle(
                    fontSize: 40,                // 글자 크기
                    fontWeight: FontWeight.bold, // 글자 굵기
                    color: Colors.blueAccent,    // 글자 색상
                  ),
                ),
                const SizedBox(height: 50), // 간격 조절

                // 2. ID 입력창
                // TextField: 사용자 텍스트 입력을 받는 위젯
                TextField(
                  controller: _idController,          // 입력값을 _idController로 관리
                  decoration: const InputDecoration(
                    labelText: 'ID',         // 입력창 위에 표시되는 라벨
                    border: OutlineInputBorder(),     // 사각형 테두리 스타일
                    prefixIcon: Icon(Icons.person),   // 입력창 왼쪽 아이콘
                  ),
                ),
                const SizedBox(height: 20),

                // 3. PW 입력창
                TextField(
                  controller: _pwController,
                  obscureText: true, // 비밀번호 가리기
                  decoration: const InputDecoration(
                    labelText: 'PW',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                  ),
                ),
                const SizedBox(height: 30),

                // 4. 로그인 버튼
                SizedBox(
                  width: double.infinity, // 부모 위젯의 최대 너비로 꽉 채움
                  height: 55,

                  // ElevatedButton: 입체감(그림자) 있는 버튼 위젯
                  child: ElevatedButton(

                    // onPressed: 버튼 클릭 시 실행할 함수
                    onPressed: () async {
                      final id = _idController.text;
                      final pw = _pwController.text;

                      if (id.isEmpty || pw.isEmpty) {
                        CommonDialogs.showAlert(
                          context: context,
                          title: '로그인 실패',
                          message: '아이디 또는 비밀번호를 입력해주세요.',
                        );
                        return;
                      }

                      try {
                        final response = await ApiService.dio.post(
                          '/login',
                          data: {'userId': id, 'userPass': pw},
                        );

                        if (response.statusCode == 200) {
                          Provider.of<EmployeeProvider>(context, listen: false).setEmployee(EmployeeModel.fromJson(response.data));

                          if (context.mounted) context.go('/salary2');
                        }
                      } on DioException catch (e) {
                        if (context.mounted) {
                          CommonDialogs.showAlert(
                            context: context,
                            title: '로그인 실패',
                            message: e.error.toString(),  // 인터셉터에서 가공된 메시지
                          );
                        }
                      }
                    },

                    // styleFrom: 버튼 스타일 설정 위젯
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,         // 버튼 배경색
                      foregroundColor: Colors.white,              // 버튼 텍스트/아이콘 색상
                      shape: RoundedRectangleBorder(              // 버튼 모양
                        borderRadius: BorderRadius.circular(10),  // 모서리 둥근 정도
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