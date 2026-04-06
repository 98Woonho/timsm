class EmployeeModel {
  final String empNo;
  final String korNm;

  EmployeeModel({required this.empNo, required this.korNm});

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      empNo: json['empNo'] ?? '',
      korNm: json['korNm'] ?? '',
    );
  }
}