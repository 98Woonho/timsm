class EmployeeModel {
  final String empNo;
  final String korNm;
  final String birthDt;
  final String enterDt;
  final String chikcNm;
  final String positionNm;
  final String hobCd;
  final String corpNm;
  final String deptNm;

  EmployeeModel({required this.empNo,
                required this.korNm,
                required this.birthDt,
                required this.enterDt,
                required this.chikcNm,
                required this.positionNm,
                required this.hobCd,
                required this.corpNm,
                required this.deptNm,});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      empNo: json['empNo'] ?? '',
      korNm: json['korNm'] ?? '',
      birthDt: json['birthDt'] ?? '',
      enterDt: json['enterDt'] ?? '',
      chikcNm: json['chikcNm'] ?? '',
      positionNm: json['positionNm'] ?? '',
      hobCd: json['hobCd'] ?? '',
      corpNm: json['corpNm'] ?? '',
      deptNm: json['deptNm'] ?? '',
    );
  }
}