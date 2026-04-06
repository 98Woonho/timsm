import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/employee_model.dart'; // 모델 파일 임포트

class EmployeeService {
  // 서버 주소 (안드로이드 에뮬레이터는 10.0.2.2, 실제 기기는 노트북 IP)
  static const String baseUrl = 'http://localhost:8080/api/employee';

  Future<List<EmployeeModel>> fetchEmployees() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        // 한글 깨짐 방지를 위해 utf8.decode 사용
        List<dynamic> body = json.decode(utf8.decode(response.bodyBytes));

        // JSON 리스트를 EmployeeModel 리스트로 변환
        return body.map((json) => EmployeeModel.fromJson(json)).toList();
      } else {
        throw Exception('서버 응답 에러: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('네트워크 연결 실패: $e');
    }
  }
}