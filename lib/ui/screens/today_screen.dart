import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:physique_os/state/app_state.dart';
import 'package:physique_os/ui/widgets/section_header.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPhase = ref.watch(currentPhaseProvider);
    final checklist = ref.watch(todayChecklistProvider);
    final completed = ref.watch(completedHabitsProvider);
    final dateLabel = DateFormat('EEEE, MMM d').format(DateTime.now());

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Today', style: Theme.of(context).textTheme.headlineSmall),
          Text(dateLabel, style: Theme.of(context).textTheme.bodySmall),
          const SectionHeader(title: 'Current phase'),
          Text(
            'Phase ${currentPhase.id} of 6 · ${currentPhase.name}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 6),
          Text(currentPhase.focusText),
          const SectionHeader(title: 'Do NOT worry about'),
          ...currentPhase.ignoreText.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(child: Text(item)),
                ],
              ),
            ),
          ),
          const SectionHeader(title: 'Your checklist'),
          ...checklist.map(
            (habit) => Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: CheckboxListTile(
                value: completed.contains(habit.id),
                onChanged: (_) {
                  final notifier = ref.read(completedHabitsProvider.notifier);
                  final next = {...notifier.state};
                  if (next.contains(habit.id)) {
                    next.remove(habit.id);
                  } else {
                    next.add(habit.id);
                  }
                  notifier.state = next;
                },
                title: Text(habit.name),
                subtitle: Text('Stay consistent, not perfect.'),
              ),
            ),
          ),
          const SectionHeader(title: 'Identity reminder'),
          Text(
            'I am the kind of person who protects my energy and shows up calmly.',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
