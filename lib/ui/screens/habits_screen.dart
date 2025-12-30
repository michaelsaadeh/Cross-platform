import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physique_os/models/habit.dart';
import 'package:physique_os/state/app_state.dart';
import 'package:physique_os/ui/widgets/habit_tile.dart';
import 'package:physique_os/ui/widgets/section_header.dart';

class HabitsScreen extends ConsumerWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeHabits = ref.watch(activeHabitsProvider);
    final backgroundHabits = ref.watch(backgroundHabitsProvider);
    final upcomingHabits = ref.watch(upcomingHabitsProvider);
    final reminderSettings = ref.watch(reminderSettingsProvider);

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Habits', style: Theme.of(context).textTheme.headlineSmall),
          const SectionHeader(
            title: 'Active habits',
            subtitle: 'Daily reminders while this phase is active.',
          ),
          ...activeHabits.map(
            (habit) => _buildHabitTile(ref, habit, reminderSettings),
          ),
          const SectionHeader(
            title: 'Background habits',
            subtitle: 'Weekly reminders to keep the base strong.',
          ),
          ...backgroundHabits.map(
            (habit) => _buildHabitTile(ref, habit, reminderSettings),
          ),
          const SectionHeader(
            title: 'Upcoming habits',
            subtitle: 'These will unlock in future phases.',
          ),
          ...upcomingHabits.map(
            (habit) => _buildHabitTile(ref, habit, reminderSettings),
          ),
        ],
      ),
    );
  }

  Widget _buildHabitTile(
    WidgetRef ref,
    Habit habit,
    Map<String, bool> reminderSettings,
  ) {
    final isEnabled = reminderSettings[habit.id] ?? true;
    return HabitTile(
      habit: habit,
      remindersEnabled: isEnabled,
      onReminderToggle: (value) {
        final notifier = ref.read(reminderSettingsProvider.notifier);
        notifier.state = {...notifier.state, habit.id: value};
      },
    );
  }
}
