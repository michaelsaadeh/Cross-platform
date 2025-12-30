class DailyCheck {
  const DailyCheck({
    required this.date,
    required this.completedHabitIds,
  });

  final DateTime date;
  final List<String> completedHabitIds;
}
