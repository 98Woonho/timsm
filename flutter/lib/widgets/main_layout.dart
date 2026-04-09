import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainLayout extends StatelessWidget {
  // 화면마다 바뀔 '알맹이'를 child로 받음
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 공통 상단바
      appBar: AppBar(
        title: const Text('TIMS-M'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueGrey,
      ),

      // 화면 알맹이 (Home, Payslip 등 넘어오는 위젯이 여기에 꽂힘)
      body: child,

      // 공통 하단바
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _calculateSelectedIndex(context), // 현재 선택된 탭 계산
        onTap: (int index) => _onItemTapped(index, context), // 탭 클릭 시 이동
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt_long), label: '급여조회'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '마이페이지'),
        ],
      ),
    );
  }

  // 현재 URL 경로를 보고 하단바의 몇 번째 탭에 불을 켤지 결정하는 함수
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/payslip')) return 1;
    if (location.startsWith('/mypage')) return 2;
    return 0;
  }

  // 하단바 아이콘을 눌렀을 때 해당 화면으로 이동하는 함수
  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/payslip');
        break;
      case 2:
        context.go('/mypage');
        break;
    }
  }
}