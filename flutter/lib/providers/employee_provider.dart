import 'package:flutter/material.dart';
import '../models/employee_model.dart'; // 아까 만든 모델 임포트

class UserProvider extends ChangeNotifier {
  EmployeeModel? _user;

  // 외부에서 유저 정보를 읽을 때 사용하는 getter
  EmployeeModel? get user => _user;

  // 로그인 여부 확인
  bool get isAuthenticated => _user != null;

  // 로그인 성공 시 유저 데이터를 저장하는 함수
  void setUser(EmployeeModel newUser) {
    _user = newUser;
    notifyListeners(); // 이 함수가 호출되면 이 데이터를 쓰는 모든 UI가 자동 빌드됨
  }

  // 로그아웃 시 데이터 초기화
  void logout() {
    _user = null;
    notifyListeners();
  }
}