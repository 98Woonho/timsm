class SalaryFormulaModel {
  final String corpCd;
  final String chikcCd;
  final String positionCd;
  final String salaryCd;
  final String salaryNm;
  final String formula;

  SalaryFormulaModel({
    required this.corpCd,
    required this.chikcCd,
    required this.positionCd,
    required this.salaryCd,
    required this.salaryNm,
    required this.formula});

  factory SalaryFormulaModel.fromJson(Map<String, dynamic> json) {
    return SalaryFormulaModel(
      corpCd: json['corpCd'] ?? '',
      chikcCd: json['chikcCd'] ?? '',
      positionCd: json['positionCd'] ?? '',
      salaryCd: json['salaryCd'] ?? '',
      salaryNm: json['salaryNm'] ?? '',
      formula: json['formula'] ?? '',
    );
  }
}