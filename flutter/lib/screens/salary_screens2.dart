import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:timsm/models/salary_model.dart';
import 'package:timsm/services/api_service.dart';
import 'package:timsm/widgets/common_dialogs.dart';
import 'package:timsm/providers/user_provider.dart';

class SalaryScreen2 extends StatefulWidget {
  const SalaryScreen2({super.key});

  @override
  State<SalaryScreen2> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen2> {
  List<SalaryModel> _salaryList = [];
  String? _selectedYear;
  String? _selectedMonth;
  bool _isLoading = true;

  List<String> get _yearList =>
      _salaryList.map((e) => e.payYm.substring(0, 4)).toSet().toList()
        ..sort((a, b) => b.compareTo(a));

  List<String> get _monthList =>
      _salaryList
          .where((e) => e.payYm.substring(0, 4) == _selectedYear)
          .map((e) => e.payYm.substring(4, 6))
          .toList()
        ..sort((a, b) => b.compareTo(a));

  SalaryModel? get _currentSalary {
    try {
      return _salaryList.firstWhere(
            (e) => e.payYm == '$_selectedYear$_selectedMonth',
      );
    } catch (_) {
      return null;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadAll());
  }

  Future<void> _loadAll() async {
    setState(() => _isLoading = true);

    final empNo = context.read<UserProvider>().user?.empNo;

    try {
      final response = await ApiService.dio.get(
        '/salary',
        queryParameters: {'empNo': empNo},
      );

      if (response.statusCode == 200) {
        final list = (response.data as List)
            .map((e) => SalaryModel.fromJson(e))
            .toList();

        setState(() {
          _salaryList = list;
          if (list.isNotEmpty) {
            _selectedYear = _yearList.first;
            _selectedMonth = _monthList.first;
          }
          _isLoading = false;
        });
      }
    } on DioException catch (e) {
      setState(() => _isLoading = false);

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

      if (context.mounted) {
        CommonDialogs.showAlert(
          context: context,
          title: '급여 조회 실패',
          message: errorMsg,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;

    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_salaryList.isEmpty) {
      return const Center(child: Text('급여 데이터가 없습니다.'));
    }

    final salary = _currentSalary;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. 드롭다운 조회 조건
            _buildSearchCondition(),
            const SizedBox(height: 16),

            if (salary == null)
              const Center(child: Text('해당 월 데이터가 없습니다.'))
            else ...[
              // 2. 실수령액 카드
              _buildTotalAmountCard(salary),
              const SizedBox(height: 20),

              // 3. 아코디언
              _buildExpansionTile(
                title: '1. 기본정보',
                icon: Icons.person_outline,
                children: [
                  _buildInfoRow('귀속연월', salary.payYm),
                  _buildInfoRow('사원번호', user?.empNo ?? ''),
                  _buildInfoRow('성명', user?.korNm ?? ''),
                ],
              ),

              _buildExpansionTile(
                title: '2. 세부내역 (지급/공제)',
                icon: Icons.receipt_long,
                children: [
                  const Text('지급항목',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  const Divider(),
                  _buildAmountRow('기본급', _fmt(salary.supply01)),
                  const SizedBox(height: 15),
                  const Text('공제항목',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  const Divider(),
                  _buildAmountRow('소득세', '394058345'),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  // 드롭다운 조회 조건
  Widget _buildSearchCondition() {
    return Row(
      children: [
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedYear,
            decoration: _dropdownDecoration(),
            items: _yearList
                .map((y) => DropdownMenuItem(value: y, child: Text('$y년')))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() {
                _selectedYear = value;
                _selectedMonth = _monthList.first;
              });
            },
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: DropdownButtonFormField<String>(
            value: _selectedMonth,
            decoration: _dropdownDecoration(),
            items: _monthList
                .map((m) => DropdownMenuItem(
              value: m,
              child: Text('${m.toString().padLeft(2, '0')}월'),
            ))
                .toList(),
            onChanged: (value) {
              if (value == null) return;
              setState(() => _selectedMonth = value);
            },
          ),
        ),
      ],
    );
  }

  // 실수령액 카드
  Widget _buildTotalAmountCard(SalaryModel salary) {
    // SalaryModel 완성 후 실제 supply/deduct 전체 합산으로 교체
    /*
    final totalSupply = (salary.supply01 ?? 0) + (salary.supply02 ?? 0) +
        (salary.supply03 ?? 0) + (salary.supply04 ?? 0) + (salary.supply05 ?? 0);
    final totalDeduct = (salary.deduct01 ?? 0) + (salary.deduct02 ?? 0) +
        (salary.deduct03 ?? 0) + (salary.deduct04 ?? 0) + (salary.deduct05 ?? 0);
    final netPay = totalSupply - totalDeduct;*/

    final netPay = 933942234;

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [
          Text('${salary.payYm} 실수령액',
              style: const TextStyle(color: Colors.white70, fontSize: 16)),
          const SizedBox(height: 10),
          Text(
            '${_fmt(netPay)}',
            style: const TextStyle(
                color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: ExpansionTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        iconColor: Colors.blueAccent,
        childrenPadding: const EdgeInsets.all(15),
        children: children,
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildAmountRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(amount, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  String _fmt(num? value) {
    if (value == null || value == 0) return '-';
    return '${NumberFormat('#,###').format(value)}원';
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      filled: true,
      fillColor: Colors.white,
    );
  }
}