import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:physique_os/state/app_state.dart';
import 'package:physique_os/ui/widgets/section_header.dart';

class PhaseScreen extends ConsumerWidget {
  const PhaseScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phase = ref.watch(currentPhaseProvider);
    final phases = ref.watch(phasesProvider);
    final nextPhase = phases.firstWhere(
      (item) => item.id == phase.id + 1,
      orElse: () => phase,
    );
    final dateRange =
        '${DateFormat('MMM d').format(phase.startDate)} – ${DateFormat('MMM d, yyyy').format(phase.endDate)}';
    final daysRemaining = nextPhase == phase
        ? 0
        : nextPhase.startDate.difference(DateTime.now()).inDays;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text('My Phase', style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 12),
          Text(
            phase.name,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Text(dateRange, style: Theme.of(context).textTheme.bodySmall),
          const SectionHeader(title: 'What matters now'),
          Text(phase.focusText),
          const SectionHeader(title: 'What to ignore'),
          ...phase.ignoreText.map(
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
          const SectionHeader(title: 'Why this phase matters'),
          ExpansionTile(
            tilePadding: EdgeInsets.zero,
            title: const Text('Tap to expand'),
            children: const [
              Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'Each phase builds a stable habit before adding the next. '
                  'That keeps the plan simple and sustainable for six months.',
                ),
              ),
            ],
          ),
          const SectionHeader(title: 'Next phase begins in'),
          Text(
            nextPhase == phase
                ? 'You are in the final phase. Keep going.'
                : '$daysRemaining days',
          ),
        ],
      ),
    );
  }
}
