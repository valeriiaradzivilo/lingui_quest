import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/view/search_tutor/bloc/tutors_bloc.dart';
import 'package:lingui_quest/view/search_tutor/widgets/tutor_container.dart';

class TutorSearch extends StatelessWidget {
  const TutorSearch({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TutorsSearchBloc>(context);
    return Center(
      child: BlocBuilder<TutorsSearchBloc, TutorSearchState>(
          bloc: bloc..add(FindAllTutors()),
          builder: (context, state) {
            if (state.status == TutorSearchStatus.success) {
              return StreamBuilder(
                  stream: state.allTutors,
                  builder: (context, result) {
                    if (result.hasData && result.data != null) {
                      return CustomScrollView(
                        slivers: [
                          SliverGrid(
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10,
                              ),
                              delegate: SliverChildBuilderDelegate(childCount: result.data?.length, (context, i) {
                                return TutorContainer(tutor: result.data![i]);
                              }))
                        ],
                      );
                    }
                    return const Text('No tutors were found');
                  });
            } else if (state.status == TutorSearchStatus.initial || state.status == TutorSearchStatus.progress) {
              return const CircularProgressIndicator();
            } else {
              return const Text('Error');
            }
          }),
    );
  }
}
