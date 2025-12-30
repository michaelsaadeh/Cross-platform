import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:physique_os/state/app_state.dart';
import 'package:physique_os/ui/widgets/section_header.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedHabits = ref.watch(completedHabitsProvider);
    final checklist = ref.watch(todayChecklistProvider);
    final habitCompletion = checklist.isEmpty
        ? 0
        : (completedHabits.length / checklist.length * 100).round();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('Progress', style: Theme.of(context).textTheme.headlineSmall),
          const SectionHeader(title: 'Weekly trend'),
          _ProgressCard(
            title: 'Weekly weight average',
            value: 'Trending steady',
            subtitle: 'Focus on consistency, not daily fluctuations.',
          ),
          _ProgressCard(
            title: 'Gym consistency',
            value: 'On track',
            subtitle: 'Four sessions per week on fixed days.',
          ),
          _ProgressCard(
            title: 'Habit adherence',
            value: '$habitCompletion%',
            subtitle: 'Daily habits completed today.',
          ),
        ],
      ),
    );
  }
}

class _ProgressCard extends StatelessWidget {
  const _ProgressCard({
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final String title;
  final String value;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: Theme.of(context).textTheme.titleSmall),
            const SizedBox(height: 8),
            Text(value, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 6),
            Text(
              subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
