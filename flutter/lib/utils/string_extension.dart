extension StringFormatExtension on String {

  // yyyymmdd -> yyyy-mm-dd 형식으로 변환
  String toFormattedDate() {
    if (this.length != 8) {
      return this;
    }
    return '${substring(0, 4)}-${substring(4, 6)}-${substring(6, 8)}';
  }
}