class Phase {
  const Phase({
    required this.id,
    required this.name,
    required this.startDate,
    required this.endDate,
    required this.focusText,
    required this.ignoreText,
    required this.habitIds,
  });

  final int id;
  final String name;
  final DateTime startDate;
  final DateTime endDate;
  final String focusText;
  final List<String> ignoreText;
  final List<String> habitIds;
}
