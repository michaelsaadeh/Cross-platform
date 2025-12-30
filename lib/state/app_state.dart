import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physique_os/data/seed_data.dart';
import 'package:physique_os/models/habit.dart';
import 'package:physique_os/models/phase.dart';

final phasesProvider = Provider<List<Phase>>((ref) => SeedData.phases());

final habitsProvider = Provider<List<Habit>>((ref) => SeedData.habits());

final currentPhaseProvider = Provider<Phase>((ref) {
  final phases = ref.watch(phasesProvider);
  final today = DateTime.now();
  return phases.firstWhere(
    (phase) => !today.isBefore(phase.startDate) && !today.isAfter(phase.endDate),
    orElse: () => phases.last,
  );
});

final activeHabitsProvider = Provider<List<Habit>>((ref) {
  final habits = ref.watch(habitsProvider);
  final currentPhase = ref.watch(currentPhaseProvider);
  return habits.where((habit) => habit.phaseId <= currentPhase.id).toList();
});

final backgroundHabitsProvider = Provider<List<Habit>>((ref) {
  final habits = ref.watch(habitsProvider);
  final currentPhase = ref.watch(currentPhaseProvider);
  return habits
      .where((habit) => habit.phaseId < currentPhase.id)
      .map((habit) => Habit(
            id: habit.id,
            name: habit.name,
            description: habit.description,
            why: habit.why,
            phaseId: habit.phaseId,
            reminderTimes: habit.reminderTimes,
            isActive: false,
            isBackground: true,
          ))
      .toList();
});

final upcomingHabitsProvider = Provider<List<Habit>>((ref) {
  final habits = ref.watch(habitsProvider);
  final currentPhase = ref.watch(currentPhaseProvider);
  return habits.where((habit) => habit.phaseId > currentPhase.id).toList();
});

final todayChecklistProvider = Provider<List<Habit>>((ref) {
  final habits = ref.watch(activeHabitsProvider);
  final today = DateTime.now();
  const gymDays = <int>{1, 2, 4, 6}; // Mon, Tue, Thu, Sat

  return habits.where((habit) {
    if (habit.id == 'gym-4-days') {
      return gymDays.contains(today.weekday);
    }
    return true;
  }).take(5).toList();
});

final completedHabitsProvider = StateProvider<Set<String>>((ref) => {});

final reminderSettingsProvider =
    StateProvider<Map<String, bool>>((ref) => {});
