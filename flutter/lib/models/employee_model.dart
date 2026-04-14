class EmployeeModel {
  final String empNo;
  final String korNm;
  final String birthDt;
  final String enterDt;
  final String chikcCd;
  final String chikcNm;
  final String positionCd;
  final String positionNm;
  final String hobCd;
  final String corpCd;
  final String corpNm;
  final String deptNm;

  EmployeeModel({required this.empNo,
                required this.korNm,
                required this.birthDt,
                required this.enterDt,
                required this.chikcCd,
                required this.chikcNm,
                required this.positionCd,
                required this.positionNm,
                required this.hobCd,
                required this.corpCd,
                required this.corpNm,
                required this.deptNm,});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      empNo: json['empNo'] ?? '',
      korNm: json['korNm'] ?? '',
      birthDt: json['birthDt'] ?? '',
      enterDt: json['enterDt'] ?? '',
      chikcCd: json['chikcCd'] ?? '',
      chikcNm: json['chikcNm'] ?? '',
      positionCd: json['positionCd'] ?? '',
      positionNm: json['positionNm'] ?? '',
      hobCd: json['hobCd'] ?? '',
      corpCd: json['corpCd'] ?? '',
      corpNm: json['corpNm'] ?? '',
      deptNm: json['deptNm'] ?? '',
    );
  }
}