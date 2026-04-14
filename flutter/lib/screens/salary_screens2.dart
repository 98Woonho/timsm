import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:provider/provider.dart';
import 'package:timsm/models/salary_model.dart';
import 'package:timsm/models/salary_formula_model.dart';
import 'package:timsm/services/api_service.dart';
import 'package:timsm/widgets/common_dialogs.dart';
import 'package:timsm/providers/employee_provider.dart';
import '../utils/string_extension.dart';
import '../utils/number_extension.dart';


class SalaryScreen2 extends StatefulWidget {
  const SalaryScreen2({super.key});

  @override
  State<SalaryScreen2> createState() => _SalaryScreenState();
}

class _SalaryScreenState extends State<SalaryScreen2> {
  List<SalaryModel> _salaryList = [];
  List<SalaryFormulaModel> _salaryFormulaList = [];
  String? _selectedYear;
  String? _selectedMonth;
  bool _isLoading = true;

  List<String> get _yearList =>
      _salaryList.map((e) => e.payYm.substring(0, 4)).toSet().toList()
        ..sort((a, b) => b.compareTo(a));

  List<String> get _monthList {
    final filtered = _salaryList
        .where((e) => e.payYm.substring(0, 4) == _selectedYear)
        .toList()
      ..sort((a, b) => b.payYm.compareTo(a.payYm));
    return filtered.map((e) => e.monthName).toList();
  }

  SalaryModel? get _currentSalary {
    try {
      return _salaryList.firstWhere(
            (e) => e.payYm.substring(0, 4) == _selectedYear && e.monthName == _selectedMonth,
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
    final employee = context.read<EmployeeProvider>().employee;

    try {
      final results = await Future.wait([
        ApiService.dio.get('/salary',
            queryParameters: {'empNo': employee?.empNo}),
        ApiService.dio.get('/salary/formula',
            queryParameters: {
              'corpCd'    : employee?.corpCd,
              'chikcCd'   : employee?.chikcCd,
              'positionCd': employee?.positionCd,
            }),
      ]);

      final salaryList = (results[0].data as List)
          .map((e) => SalaryModel.fromJson(e))
          .toList();

      final salaryFormulaList = (results[1].data as List)
          .map((e) => SalaryFormulaModel.fromJson(e))
          .toList();

      setState(() {
        _salaryList = salaryList;
        _salaryFormulaList = salaryFormulaList;

        if (salaryList.isNotEmpty) {
          _selectedYear  = _yearList.first;
          _selectedMonth = _monthList.first;
        }

        _isLoading = false;
      });
    } on DioException catch (e) {
      if (context.mounted) {
        CommonDialogs.showAlert(
          context: context,
          title: '급여 조회 실패',
          message: e.error.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final employee = context.watch<EmployeeProvider>().employee;

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
            _buildSearchCondition(),
            const SizedBox(height: 16),

            if (salary == null)
              const Center(child: Text('해당 월 데이터가 없습니다.'))
            else ...[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('실지급액',
                        style: TextStyle(color: Colors.white, fontSize: 15)),
                    Text(
                      (salary.payAmt - salary.deductAmt).toComma(),
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              _buildExpansionTile(
                title: '1. 기본정보',
                icon: Icons.person_outline,
                children: [
                  _buildInfoRow('성명', employee!.korNm),
                  _buildInfoRow('사원번호', employee.empNo),
                  _buildInfoRow('생년월일', employee.birthDt.toFormattedDate()),
                  _buildInfoRow('입사일자', employee.enterDt.toFormattedDate()),
                  _buildInfoRow('부서', employee.chikcNm),
                  _buildInfoRow('직책', employee.positionNm),
                  _buildInfoRow('호봉', employee.hobCd),
                  _buildInfoRow('기본급', salary.timePay.toComma()),
                ],
              ),

              _buildExpansionTile(
                title: '2. 근로정보',
                icon: Icons.person_outline,
                children: [
                  const Text('근로일수',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  const Divider(),
                  _buildInfoRow('총일수', '${salary.workCnt}'),
                  _buildInfoRow('오전', '${salary.workAmCnt}'),
                  _buildInfoRow('오후', '${salary.workPmCnt}'),
                  const SizedBox(height: 15),
                  const Text('근로시간',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  const Divider(),
                  _buildInfoRow('총근무시간', '${salary.workTimeCnt + salary.extenCnt + salary.midntCnt + salary.holiWorkCnt}'),
                  _buildInfoRow('기본시간', '${salary.workTimeCnt}'),
                  _buildInfoRow('연장시간', '${salary.extenCnt}'),
                  _buildInfoRow('야간시간', '${salary.midntCnt}'),
                  _buildInfoRow('주휴시간', '${salary.holiWorkCnt}'),
                  const SizedBox(height: 15),
                  const Text('기타',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
                  const Divider(),
                  _buildInfoRowDouble('유급일수', '${salary.holiCnt}',  '유급근무일수', '${salary.holiAmDay + salary.holiPmDay}'),
                  _buildInfoRowDouble('연차일수', '${salary.vacCnt}',  '연차사용일수', '${salary.vacUseCnt}'),
                  _buildInfoRowDouble('휴가일수', '',  '교육일수', '${salary.eduCnt}'),
                  _buildInfoRowDouble('보수교육일수', '',  '훈련일수', ''),
                  _buildInfoRowDouble('사고일수', '${salary.acctCnt}',  '면제일수', ''),
                  _buildInfoRowDouble('심야일수', '',  '시간급여', ''),
                ],
              ),

              _buildExpansionTile(
                title: '3. 세부내역',
                icon: Icons.receipt_long,
                children: [
                  const Text('지급내역',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                  const Divider(),
                  _buildInfoRowDouble('기본급', salary.supply01.toComma(),  '근로시간면제', salary.supply29.toComma()),
                  _buildInfoRowDouble('연장수당', salary.supply03.toComma(),  '제수당', salary.supply11.toComma()),
                  _buildInfoRowDouble('야간수당', salary.supply04.toComma(),  '운전상여금', salary.supply54.toComma()),
                  _buildInfoRowDouble('주휴수당', salary.supply05.toComma(),  '보수교육비', salary.supply44.toComma()),
                  _buildInfoRowDouble('휴일수당', salary.supply07.toComma(),  '운전자보험', salary.supply26.toComma()),
                  _buildInfoRowDouble('상여금', salary.supply02.toComma(),  '기타상여금', salary.supply06.toComma()),
                  _buildInfoRowDouble('오후야간', salary.supply19.toComma(),  '심야수당', salary.supply38.toComma()),
                  _buildInfoRowDouble('시간급여', '-',  '직무/위험', salary.supply10.toComma()),
                  _buildInfoRowDouble('근무성적수당', salary.supply21.toComma(),  '자격수당', salary.supply09.toComma()),
                  _buildInfoRowDouble('무사고수당', salary.supply16.toComma(),  '기타수당', salary.supply12.toComma()),
                  _buildInfoRowDouble('체력단련비', salary.supply28.toComma(),  '식 대', salary.supply20.toComma()),
                  _buildInfoRowDouble('교육비', salary.supply22.toComma(),  '유급수당', salary.supply34.toComma()),
                  _buildInfoRowDouble('연차수당', salary.supply15.toComma(),  '청원휴가', salary.supply25.toComma()),
                  _buildInfoRowDouble('유급휴가', salary.supply08.toComma(),  '대무수당', salary.supply37.toComma()),
                  const SizedBox(height: 5),
                  _buildTotalRow('지급총액', salary.payAmt.toComma()),
                  const SizedBox(height: 20),
                  const Text('공제내역',
                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                  const Divider(),
                  _buildInfoRowDouble('소득세', salary.deduct01.toComma(),  '지방소득세', salary.deduct02.toComma()),
                  _buildInfoRowDouble('국민연금', salary.deduct04.toComma(),  '건강보험', salary.deduct05.toComma()),
                  _buildInfoRowDouble('요양보험', salary.deduct09.toComma(),  '고용보험', salary.deduct06.toComma()),
                  _buildInfoRowDouble('노조비', salary.deduct07.toComma(),  '가불금', salary.deduct03.toComma()),
                  _buildInfoRowDouble('송별금', salary.deduct11.toComma(),  '상조비', salary.deduct28.toComma()),
                  _buildInfoRowDouble('상조가입', salary.deduct13.toComma(),  '기타공제', (salary.deduct21 + salary.deduct22).toComma()),
                  _buildInfoRowDouble('동호회비', salary.deduct16.toComma(),  '경조비', salary.deduct27.toComma()),
                  _buildInfoRow('교통비공제', '-'),
                  const SizedBox(height: 5),
                  _buildTotalRow('공제총액', salary.deductAmt.toComma()),
                ],
              ),
              _buildExpansionTile(
                title: '4. 산출세부내역',
                icon: Icons.receipt_long,
                children: _salaryFormulaList
                  .map((formula) => _buildFormulaRow(formula.salaryNm, formula.formula))
                  .toList(),
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
                .map((m) => DropdownMenuItem(value: m, child: Text(m)))
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

  // 2개씩 한 행에 표시하는 위젯
  Widget _buildInfoRowDouble(
      String label1, String value1,
      String label2, String value2,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label1, style: const TextStyle(color: Colors.grey)),
                Text(value1, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(width: 16),
          const VerticalDivider(),
          const SizedBox(width: 16),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label2, style: const TextStyle(color: Colors.grey)),
                Text(value2, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 산출세부내역용 row
  Widget _buildFormulaRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              label,
              style: const TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              value,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              softWrap: true,
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalRow(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(220, 215, 215, 0.3215686274509804),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                fontWeight: FontWeight.bold
              )),
          Text(value,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16
              )),
        ],
      ),
    );
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