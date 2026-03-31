import 'package:flutter/material.dart';
import 'package:training_note/core/ui/empty_screen.dart';
import 'package:training_note/trainings/list/trainings_list_notifier.dart';

class TrainingsListWidget extends StatelessWidget {
  final TrainingsState state;
  final void Function(TrainingViewModel) onSelect;
  const TrainingsListWidget(
      {required this.state, required this.onSelect, super.key});

  @override
  Widget build(BuildContext context) {
    final state = this.state; //FIXME:
    return switch (state) {
      TrainingsEmptyState() => const EmptyScreen.training(),
      TrainingsListState() => ListView.separated(
          itemCount: state.list.length,
          separatorBuilder: (_, __) => const SizedBox(height: 16),
          itemBuilder: (context, index) => _Training(
            model: state.list[index],
            onTap: () => onSelect(state.list[index]),
          ),
        )
    };
  }
}

class _Training extends StatelessWidget {
  final TrainingViewModel model;
  final VoidCallback onTap;

  const _Training({
    required this.model,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(model.date),
              SizedBox(height: 8),
              Text(model.approaches),
            ],
          ),
        ),
      ),
    );
  }
}
