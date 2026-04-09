class EmployeeModel {
  final String message;
  final String empNo;
  final String korNm;
  final String corpCd;
  final String deptCd;

  EmployeeModel({required this.message, required this.empNo, required this.korNm, required this.corpCd, required this.deptCd});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      message: json['message'] ?? '',
      empNo: json['empNo'] ?? '',
      korNm: json['korNm'] ?? '',
      corpCd: json['corpCd'] ?? '',
      deptCd: json['deptCd'] ?? '',
    );
  }
}