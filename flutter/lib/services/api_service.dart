// lib/services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/api', // 기본 주소 설정
      connectTimeout: const Duration(seconds: 5), // 서버 연결 대기 시간
      receiveTimeout: const Duration(seconds: 3), // 응답 받는 대기 시간
      contentType: 'application/json', // 기본 헤더 설정
    ),
  );
}