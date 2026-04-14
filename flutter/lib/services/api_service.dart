// lib/services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://localhost:8080/api/', // 기본 주소 설정
      connectTimeout: const Duration(seconds: 5), // 서버 연결 대기 시간
      receiveTimeout: const Duration(seconds: 3), // 응답 받는 대기 시간
      contentType: 'application/json', // 기본 헤더 설정
    ),
  )..interceptors.add(
      InterceptorsWrapper(
        onError: (DioException e, handler) {
          String errorMsg;

          switch (e.type) {
            case DioExceptionType.connectionTimeout:
            case DioExceptionType.receiveTimeout:
              errorMsg = '서버 연결 시간이 초과되었습니다.';
              break;
            case DioExceptionType.connectionError:
              errorMsg = '서버에 연결할 수 없습니다. 관리자에게 문의하세요.';
              break;
            case DioExceptionType.badResponse:
              errorMsg = e.response?.data['message'] ?? '오류가 발생했습니다.';
              break;
            default:
              errorMsg = '알 수 없는 오류가 발생했습니다.';
          }

          handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              error: errorMsg,
            ),
          );
        },
      ),
  );
}