class SalaryModel {
  final String payYm;
  final String empNo;
  final num supply01;
  final num supply02;
  final num supply03;
  final num supply04;
  final num supply05;
  final num supply06;
  final num supply07;
  final num supply08;
  final num supply09;
  final num supply10;
  final num supply11;
  final num supply12;
  final num supply13;
  final num supply14;
  final num supply15;
  final num supply16;
  final num supply17;
  final num supply18;
  final num supply19;
  final num supply20;
  final num supply21;
  final num supply22;
  final num supply23;
  final num supply24;
  final num supply25;
  final num supply26;
  final num supply27;
  final num supply28;
  final num supply29;
  final num supply30;
  final num supply31;
  final num supply32;
  final num supply33;
  final num supply34;
  final num supply35;
  final num supply36;
  final num supply37;
  final num supply38;
  final num supply39;
  final num supply40;
  final num supply41;
  final num supply42;
  final num supply43;
  final num supply44;
  final num supply45;
  final num supply46;
  final num supply47;
  final num supply48;
  final num supply49;
  final num supply50;
  final num supply51;
  final num supply52;
  final num supply53;
  final num supply54;
  final num supply55;
  final num payAmt;
  final num deduct01;
  final num deduct02;
  final num deduct03;
  final num deduct04;
  final num deduct05;
  final num deduct06;
  final num deduct07;
  final num deduct08;
  final num deduct09;
  final num deduct10;
  final num deduct11;
  final num deduct12;
  final num deduct13;
  final num deduct14;
  final num deduct15;
  final num deduct16;
  final num deduct17;
  final num deduct18;
  final num deduct19;
  final num deduct20;
  final num deduct21;
  final num deduct22;
  final num deduct23;
  final num deduct24;
  final num deduct25;
  final num deduct26;
  final num deduct27;
  final num deduct28;
  final num deductAmt;
  final num workCnt;
  final num workAmCnt;
  final num workPmCnt;
  final num extenCnt;
  final num midntCnt;
  final num holiWorkCnt;
  final num timePay;
  final num workTimeCnt;
  final num holiAmDay;
  final num holiPmDay;
  final String monthName;
  final num holiCnt;
  final num vacUseCnt;
  final num vacCnt;
  final num eduCnt;
  final num acctCnt;

  SalaryModel({
    required this.payYm,
    required this.empNo,
    required this.supply01,
    required this.supply02,
    required this.supply03,
    required this.supply04,
    required this.supply05,
    required this.supply06,
    required this.supply07,
    required this.supply08,
    required this.supply09,
    required this.supply10,
    required this.supply11,
    required this.supply12,
    required this.supply13,
    required this.supply14,
    required this.supply15,
    required this.supply16,
    required this.supply17,
    required this.supply18,
    required this.supply19,
    required this.supply20,
    required this.supply21,
    required this.supply22,
    required this.supply23,
    required this.supply24,
    required this.supply25,
    required this.supply26,
    required this.supply27,
    required this.supply28,
    required this.supply29,
    required this.supply30,
    required this.supply31,
    required this.supply32,
    required this.supply33,
    required this.supply34,
    required this.supply35,
    required this.supply36,
    required this.supply37,
    required this.supply38,
    required this.supply39,
    required this.supply40,
    required this.supply41,
    required this.supply42,
    required this.supply43,
    required this.supply44,
    required this.supply45,
    required this.supply46,
    required this.supply47,
    required this.supply48,
    required this.supply49,
    required this.supply50,
    required this.supply51,
    required this.supply52,
    required this.supply53,
    required this.supply54,
    required this.supply55,
    required this.payAmt,
    required this.deduct01,
    required this.deduct02,
    required this.deduct03,
    required this.deduct04,
    required this.deduct05,
    required this.deduct06,
    required this.deduct07,
    required this.deduct08,
    required this.deduct09,
    required this.deduct10,
    required this.deduct11,
    required this.deduct12,
    required this.deduct13,
    required this.deduct14,
    required this.deduct15,
    required this.deduct16,
    required this.deduct17,
    required this.deduct18,
    required this.deduct19,
    required this.deduct20,
    required this.deduct21,
    required this.deduct22,
    required this.deduct23,
    required this.deduct24,
    required this.deduct25,
    required this.deduct26,
    required this.deduct27,
    required this.deduct28,
    required this.deductAmt,
    required this.workCnt,
    required this.workAmCnt,
    required this.workPmCnt,
    required this.extenCnt,
    required this.midntCnt,
    required this.holiWorkCnt,
    required this.timePay,
    required this.workTimeCnt,
    required this.holiAmDay,
    required this.holiPmDay,
    required this.monthName,
    required this.holiCnt,
    required this.vacUseCnt,
    required this.vacCnt,
    required this.eduCnt,
    required this.acctCnt
  });


  factory SalaryModel.fromJson(Map<String, dynamic> json) {
    return SalaryModel(
      payYm: json['payYm']?.toString() ?? '',
      empNo: json['empNo']?.toString() ?? '',
      supply01: json['supply01'] ?? 0,
      supply02: json['supply02'] ?? 0,
      supply03: json['supply03'] ?? 0,
      supply04: json['supply04'] ?? 0,
      supply05: json['supply05'] ?? 0,
      supply06: json['supply06'] ?? 0,
      supply07: json['supply07'] ?? 0,
      supply08: json['supply08'] ?? 0,
      supply09: json['supply09'] ?? 0,
      supply10: json['supply10'] ?? 0,
      supply11: json['supply11'] ?? 0,
      supply12: json['supply12'] ?? 0,
      supply13: json['supply13'] ?? 0,
      supply14: json['supply14'] ?? 0,
      supply15: json['supply15'] ?? 0,
      supply16: json['supply16'] ?? 0,
      supply17: json['supply17'] ?? 0,
      supply18: json['supply18'] ?? 0,
      supply19: json['supply19'] ?? 0,
      supply20: json['supply20'] ?? 0,
      supply21: json['supply21'] ?? 0,
      supply22: json['supply22'] ?? 0,
      supply23: json['supply23'] ?? 0,
      supply24: json['supply24'] ?? 0,
      supply25: json['supply25'] ?? 0,
      supply26: json['supply26'] ?? 0,
      supply27: json['supply27'] ?? 0,
      supply28: json['supply28'] ?? 0,
      supply29: json['supply29'] ?? 0,
      supply30: json['supply30'] ?? 0,
      supply31: json['supply31'] ?? 0,
      supply32: json['supply32'] ?? 0,
      supply33: json['supply33'] ?? 0,
      supply34: json['supply34'] ?? 0,
      supply35: json['supply35'] ?? 0,
      supply36: json['supply36'] ?? 0,
      supply37: json['supply37'] ?? 0,
      supply38: json['supply38'] ?? 0,
      supply39: json['supply39'] ?? 0,
      supply40: json['supply40'] ?? 0,
      supply41: json['supply41'] ?? 0,
      supply42: json['supply42'] ?? 0,
      supply43: json['supply43'] ?? 0,
      supply44: json['supply44'] ?? 0,
      supply45: json['supply45'] ?? 0,
      supply46: json['supply46'] ?? 0,
      supply47: json['supply47'] ?? 0,
      supply48: json['supply48'] ?? 0,
      supply49: json['supply49'] ?? 0,
      supply50: json['supply50'] ?? 0,
      supply51: json['supply51'] ?? 0,
      supply52: json['supply52'] ?? 0,
      supply53: json['supply53'] ?? 0,
      supply54: json['supply54'] ?? 0,
      supply55: json['supply55'] ?? 0,
      payAmt: json['payAmt'] ?? 0,
      deduct01: json['deduct01'] ?? 0,
      deduct02: json['deduct02'] ?? 0,
      deduct03: json['deduct03'] ?? 0,
      deduct04: json['deduct04'] ?? 0,
      deduct05: json['deduct05'] ?? 0,
      deduct06: json['deduct06'] ?? 0,
      deduct07: json['deduct07'] ?? 0,
      deduct08: json['deduct08'] ?? 0,
      deduct09: json['deduct09'] ?? 0,
      deduct10: json['deduct10'] ?? 0,
      deduct11: json['deduct11'] ?? 0,
      deduct12: json['deduct12'] ?? 0,
      deduct13: json['deduct13'] ?? 0,
      deduct14: json['deduct14'] ?? 0,
      deduct15: json['deduct15'] ?? 0,
      deduct16: json['deduct16'] ?? 0,
      deduct17: json['deduct17'] ?? 0,
      deduct18: json['deduct18'] ?? 0,
      deduct19: json['deduct19'] ?? 0,
      deduct20: json['deduct20'] ?? 0,
      deduct21: json['deduct21'] ?? 0,
      deduct22: json['deduct22'] ?? 0,
      deduct23: json['deduct23'] ?? 0,
      deduct24: json['deduct24'] ?? 0,
      deduct25: json['deduct25'] ?? 0,
      deduct26: json['deduct26'] ?? 0,
      deduct27: json['deduct27'] ?? 0,
      deduct28: json['deduct28'] ?? 0,
      deductAmt: json['deductAmt'] ?? 0,
      workCnt: json['workCnt'] ?? 0,
      workAmCnt: json['workAmCnt'] ?? 0,
      workPmCnt: json['workPmCnt'] ?? 0,
      extenCnt: json['extenCnt'] ?? 0,
      midntCnt: json['midntCnt'] ?? 0,
      holiWorkCnt: json['holiWorkCnt'] ?? 0,
      timePay: json['timePay'] ?? 0,
      workTimeCnt: json['workTimeCnt'] ?? 0,
      holiAmDay: json['holiAmDay'] ?? 0,
      holiPmDay: json['holiPmDay'] ?? 0,
      monthName: json['monthName']?.toString() ?? '',
      holiCnt: json['holiCnt'] ?? 0,
      vacUseCnt: json['vacUseCnt'] ?? 0,
      vacCnt: json['vacCnt'] ?? 0,
      eduCnt: json['eduCnt'] ?? 0,
      acctCnt: json['acctCnt'] ?? 0,
    );
  }
}