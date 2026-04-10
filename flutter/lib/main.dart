import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:timsm/providers/employee_provider.dart';
import 'package:timsm/screens/login_screen.dart';
import 'package:timsm/screens/salary_screens.dart';
import 'package:timsm/screens/salary_screens2.dart';
import 'package:timsm/widgets/main_layout.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => EmployeeProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // 💡 라우팅 설정 (지도 그리기)
    return MaterialApp.router(
        title: 'TIMS-M',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        routerConfig: GoRouter(
          initialLocation: '/login',
          redirect: (context, state) {
            final employee = context.read<EmployeeProvider>().employee;
            final isLoggedIn = employee != null;
            final isLoginPage = state.matchedLocation == '/login';

            if (!isLoggedIn && !isLoginPage) return '/login';
            if (isLoggedIn && isLoginPage) return '/salary2';

            return null;
          },
        routes: [
          GoRoute(
            path: '/login',
            builder: (context, state) => const LoginScreen(),
          ),
          ShellRoute(
            builder: (context, state, child) {
              return MainLayout(child: child);
            },
            routes: [
              GoRoute(
                path: '/salary',
                builder: (context, state) => const SalaryScreen(),
              ),
              GoRoute(
                path: '/salary2',
                builder: (context, state) => const SalaryScreen2(),
              ),
            ],
          )
        ],
      ),
    );
  }
}