import 'package:fitsaw/features/active_routine/presentation/presentation.dart';
import 'package:fitsaw/features/history/domain/history.dart';
import 'package:fitsaw/features/history/services/services.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:realm/realm.dart';

/// Visual representation of the exercise list.
class HistoryList extends ConsumerStatefulWidget {
  const HistoryList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HistoryListState();
}

class _HistoryListState extends ConsumerState<HistoryList> {
  List<Widget> _pageElements() {
    List<Widget> list = [];

    for (int i = 0; i < ref.read(historyListProvider).length(); i++) {
      History history = ref.read(historyListProvider)[i];

      list.add(
        ExpandableSection(
          header: SectionHeader(
            key: UniqueKey(),
            title: DateParser.intToString(history.date),
          ),
          isExpanded: false,
          children: _routineSummaries(history.summaries),
        ),
      );
    }

    return list;
  }

  List<Widget> _routineSummaries(RealmList<RoutineSummary> summaries) {
    List<Widget> list = [];

    for (int i = summaries.length - 1; i >= 0; i--) {
      final summary = summaries[i];

      list.add(
        RoutineSummaryDisplay(
          elapsedTime: summary.elapsedTime!,
          historyRoutine: summary.historyRoutine!,
          isHistory: true,
        ),
      );
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    final historyList = ref.watch(historyListProvider);

    return historyList.length() == 0
        ? const Center(child: Text('No Workout History'))
        : StreamBuilder(
            stream: historyList.changes(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }

              return ListView(children: _pageElements());
            },
          );
  }
}
