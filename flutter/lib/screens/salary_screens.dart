// lib/screens/salary/salary_screen.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 숫자 포맷 (1,000,000원)

class SalaryScreen extends StatefulWidget {
  const SalaryScreen({super.key});

  @override
  State<SalaryScreen> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen> {
  // 나중에 API에서 받아올 데이터 (임시 더미데이터)
  final Map<String, dynamic> salaryData = {
    'year': '2026',
    'month': '03',
    'empNo': '20070426',
    'empName': '강계수',
    'birthDate': '1963-07-21',
    'hireDate': '2007-04-26',
    'workDays': 25,
    'paidItems': [
      {'name': '기본급', 'amount': 2297144},
      {'name': '직책수당', 'amount': 400710},
      {'name': '연장근로수당', 'amount': 430715},
      {'name': '야간근로수당', 'amount': 143572},
      {'name': '휴일근로수당', 'amount': 398175},
      {'name': '기타수당', 'amount': 155057},
      {'name': '식대', 'amount': 270000},
      {'name': '교통비', 'amount': 60000},
    ],
    'deductItems': [
      {'name': '소득세', 'amount': 40070},
      {'name': '지방소득세', 'amount': 202820},
      {'name': '국민연금', 'amount': 30000},
      {'name': '건강보험', 'amount': 37670},
      {'name': '고용보험', 'amount': 52920},
    ],
    'totalPaid': 4186035,
    'totalDeduct': 770110,
    'netPay': 3415925,
  };

  final formatter = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('${salaryData['year']}년 ${salaryData['month']}월 급여명세서'),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: InteractiveViewer(
        // =====================================================
        // InteractiveViewer: 핀치줌/확대/축소/이동 가능하게 해주는 위젯
        // minScale: 최소 축소 비율
        // maxScale: 최대 확대 비율
        // =====================================================
        minScale: 0.5,
        maxScale: 3.0,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _buildHeaderTable(),       // 기본 정보
              const SizedBox(height: 4),
              _buildPayTable(),          // 지급/공제 내역
              const SizedBox(height: 4),
              _buildSummaryTable(),      // 합계
            ],
          ),
        ),
      ),
    );
  }

  // ── 기본 정보 표 ───────────────────────────────────────
  Widget _buildHeaderTable() {
    return Table(
      border: TableBorder.all(color: Colors.black, width: 0.5),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(2),
      },
      children: [
        _tableRow(['귀속연월', '${salaryData['year']}년 ${salaryData['month']}월',
          '발행일', '2026-04-08'], isHeader: true),
        _tableRow(['사원번호', salaryData['empNo'], '생년월일', salaryData['birthDate']]),
        _tableRow(['성명', salaryData['empName'], '입사일', salaryData['hireDate']]),
        _tableRow(['근무일수', '${salaryData['workDays']}일', '', '']),
      ],
    );
  }

  // ── 지급/공제 내역 표 ──────────────────────────────────
  Widget _buildPayTable() {
    final paidItems = salaryData['paidItems'] as List;
    final deductItems = salaryData['deductItems'] as List;
    final maxRows = paidItems.length > deductItems.length
        ? paidItems.length
        : deductItems.length;

    return Table(
      border: TableBorder.all(color: Colors.black, width: 0.5),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        // 헤더
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFD9E1F2)),
          children: [
            _headerCell('지급항목'),
            _headerCell('지급금액'),
            _headerCell('공제항목'),
            _headerCell('공제금액'),
          ],
        ),
        // 데이터 행
        for (int i = 0; i < maxRows; i++)
          TableRow(
            children: [
              _cell(i < paidItems.length ? paidItems[i]['name'] : ''),
              _cell(i < paidItems.length
                  ? '${formatter.format(paidItems[i]['amount'])}원' : '',
                  align: TextAlign.right),
              _cell(i < deductItems.length ? deductItems[i]['name'] : ''),
              _cell(i < deductItems.length
                  ? '${formatter.format(deductItems[i]['amount'])}원' : '',
                  align: TextAlign.right),
            ],
          ),
      ],
    );
  }

  // ── 합계 표 ────────────────────────────────────────────
  Widget _buildSummaryTable() {
    return Table(
      border: TableBorder.all(color: Colors.black, width: 0.5),
      columnWidths: const {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          decoration: const BoxDecoration(color: Color(0xFFD9E1F2)),
          children: [
            _headerCell('지급합계'),
            _headerCell('공제합계'),
            _headerCell('실수령액'),
            _headerCell(''),
          ],
        ),
        TableRow(
          children: [
            _cell('${formatter.format(salaryData['totalPaid'])}원',
                align: TextAlign.right, bold: true),
            _cell('${formatter.format(salaryData['totalDeduct'])}원',
                align: TextAlign.right, bold: true),
            _cell('${formatter.format(salaryData['netPay'])}원',
                align: TextAlign.right,
                bold: true,
                color: Colors.blueAccent),
            _cell(''),
          ],
        ),
      ],
    );
  }

  // ── 공통 위젯 헬퍼 ─────────────────────────────────────
  TableRow _tableRow(List<String> cells, {bool isHeader = false}) {
    return TableRow(
      decoration: isHeader
          ? const BoxDecoration(color: Color(0xFFD9E1F2))
          : null,
      children: cells.map((text) => _cell(text, bold: isHeader)).toList(),
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _cell(String text, {
    TextAlign align = TextAlign.left,
    bool bold = false,
    Color? color,
  }) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Text(text,
        textAlign: align,
        style: TextStyle(
          fontSize: 11,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          color: color,
        ),
      ),
    );
  }
}