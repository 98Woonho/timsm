import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:timsm/screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // 💡 라우팅 설정 (지도 그리기)
    final GoRouter router = GoRouter(
      initialLocation: '/login', // 앱을 켜면 가장 먼저 갈 주소
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        )
      ],
    );

    return MaterialApp.router(
      title: 'TIMS-M',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: router,
    );
  }
}