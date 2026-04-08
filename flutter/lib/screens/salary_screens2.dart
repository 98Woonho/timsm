import 'package:flutter/material.dart';

// 💡 요청하신 대로 클래스명을 SalaryScreen2로 변경했습니다.
class SalaryScreen2 extends StatelessWidget {
  // 실제로는 백엔드에서 받은 데이터를 매개변수로 받아서 사용하게 됩니다.
  const SalaryScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 1. 상단 실수령액 요약 카드
            _buildTotalAmountCard(),
            const SizedBox(height: 20),

            // 2. 아코디언 메뉴 5개 시작
            _buildExpansionTile(
              title: '1. 기본정보',
              icon: Icons.person_outline,
              children: [
                _buildInfoRow('귀속연월', '2026년 03월'),
                _buildInfoRow('발행일', '2026-04-08'),
                _buildInfoRow('사원번호', '20070426'),
                _buildInfoRow('성명', '강계수'),
                _buildInfoRow('생년월일', '1963-07-21'),
                _buildInfoRow('입사일', '2007-04-26'),
              ],
            ),

            _buildExpansionTile(
              title: '2. 근로일수',
              icon: Icons.calendar_today,
              children: [
                _buildInfoRow('근무일수', '25일'),
                _buildInfoRow('유급휴일', '4일'),
              ],
            ),

            _buildExpansionTile(
              title: '3. 근로시간',
              icon: Icons.access_time,
              children: [
                _buildInfoRow('기본근로시간', '200시간'),
                _buildInfoRow('연장근로시간', '37.5시간'),
                _buildInfoRow('야간근로시간', '12시간'),
              ],
            ),

            _buildExpansionTile(
              title: '4. 세부내역 (지급/공제)',
              icon: Icons.receipt_long,
              children: [
                const Text('지급항목', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)),
                const Divider(),
                _buildAmountRow('기본급', '2,297,144원'),
                _buildAmountRow('식대', '270,000원'),
                _buildAmountRow('연장근로수당', '430,715원'),
                const SizedBox(height: 15),
                const Text('공제항목', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red)),
                const Divider(),
                _buildAmountRow('소득세', '40,070원'),
                _buildAmountRow('국민연금', '30,000원'),
              ],
            ),

            _buildExpansionTile(
              title: '5. 산출세부내역',
              icon: Icons.calculate_outlined,
              children: [
                _buildCalcRow('기본급', '8H x 52W/12M'),
                _buildCalcRow('연장근로수당', '37.5H x 150%'),
                _buildCalcRow('야간근로수당', '12H x 50%'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalAmountCard() {
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
          )
        ],
      ),
      child: const Column(
        children: [
          Text('2026년 03월 실수령액', style: TextStyle(color: Colors.white70, fontSize: 16)),
          SizedBox(height: 10),
          Text(
            '3,415,925 원',
            style: TextStyle(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildExpansionTile({required String title, required IconData icon, required List<Widget> children}) {
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

  Widget _buildCalcRow(String label, String calcFormula) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: Text(calcFormula, style: TextStyle(color: Colors.grey.shade700)),
          ),
        ],
      ),
    );
  }
}