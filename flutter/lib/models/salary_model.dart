class SalaryModel {
  final String payYm;
  final num supply01;

  SalaryModel({required this.payYm, required this.supply01});

  factory SalaryModel.fromJson(Map<String, dynamic> json) {
    return SalaryModel(
      payYm: json['payYm'] ?? '',
      supply01: json['supply01'] ?? 0,
    );
  }
}