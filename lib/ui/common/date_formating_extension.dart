extension DateFormating on DateTime {
  String formatData() {
    return ' ${day.toString().padLeft(2, '0')}.${month.toString().padLeft(2, '0')}.$year';
  }
}
