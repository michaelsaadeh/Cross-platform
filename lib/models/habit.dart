class Habit {
  const Habit({
    required this.id,
    required this.name,
    required this.description,
    required this.why,
    required this.phaseId,
    required this.reminderTimes,
    required this.isActive,
    required this.isBackground,
  });

  final String id;
  final String name;
  final String description;
  final String why;
  final int phaseId;
  final List<String> reminderTimes;
  final bool isActive;
  final bool isBackground;
}
