import 'package:intl/intl.dart';

extension NumberFormatExtension on num? {
  // 3자리 단위 콤마(,) 적용
  String toComma() {
    if (this == null || this == 0) {
      return '-';
    }
    return NumberFormat('#,###').format(this);
  }
}