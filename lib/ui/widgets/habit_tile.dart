import 'package:flutter/material.dart';
import 'package:physique_os/models/habit.dart';

class HabitTile extends StatelessWidget {
  const HabitTile({
    super.key,
    required this.habit,
    required this.remindersEnabled,
    required this.onReminderToggle,
  });

  final Habit habit;
  final bool remindersEnabled;
  final ValueChanged<bool> onReminderToggle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(habit.name, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 6),
            Text(habit.description),
            const SizedBox(height: 6),
            Text(
              habit.why,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black54),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Reminder: ${habit.reminderTimes.join(', ')}',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(color: Colors.black54),
                  ),
                ),
                Switch(
                  value: remindersEnabled,
                  onChanged: onReminderToggle,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
