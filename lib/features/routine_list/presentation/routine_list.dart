import 'package:fitsaw/features/routine_list/domain/domain.dart';
import 'package:fitsaw/features/routine_list/services/services.dart';
import 'package:fitsaw/shared/classes/classes.dart';
import 'package:fitsaw/shared/providers/providers.dart';
import 'package:fitsaw/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Visual representation of the routine list.
class RoutineList extends ConsumerStatefulWidget {
  const RoutineList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RoutineListState();
}

class _RoutineListState extends ConsumerState<RoutineList> {
  List<Widget> generateWidgetList(dynamic routineList) {
    final searchQuery = ref.watch(searchQueryProvider);
    List<Widget> list = [];

    for (int i = 0; i < routineList.length(); i++) {
      bool containsSearchQuery = false;
      Routine routine = routineList[i];

      if (routine.name.toLowerCase().contains(searchQuery)) {
        containsSearchQuery = true;
      }

      for (String tag in routine.tags) {
        if (tag.toLowerCase().contains(searchQuery)) {
          containsSearchQuery = true;
          break;
        }
      }

      if (containsSearchQuery) {
        list.add(
          Dismissible(
            // Generates a unique key from the routine's id.
            key: ValueKey(routine.id),
            background: Container(
              color: Palette.fitsawRed,
              child: const Center(
                child: Icon(
                  Icons.delete_outline,
                  color: Palette.darkText,
                ),
              ),
            ),
            onDismissed: (DismissDirection direction) =>
                ref.read(routineListProvider).delete(routine),
            child: GestureDetector(
              onTap: () => Navigator.pushNamed(
                context,
                'view_routine',
                arguments: PageArguments(isNew: false, routine: routine),
              ),
              child: TaggedContainer(
                tags: routine.tags,
                child: Text(routine.name),
              ),
            ),
          ),
        );

        list.add(const SizedBox(
          height: 10,
        ));
      }
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    final routineList = ref.watch(routineListProvider);

    return StreamBuilder(
      stream: routineList.changes(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        return ExpandableSection(
          title: 'Your Routines',
          children: generateWidgetList(routineList),
        );
      },
    );
  }
}
