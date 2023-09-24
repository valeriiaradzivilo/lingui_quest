part of 'tutors_bloc.dart';

enum TutorSearchStatus { initial, progress, error, success }

class TutorSearchState extends Equatable {
  final TutorSearchStatus status;
  final String? errorMessage;
  final Stream<List<TutorModel>> allTutors;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const TutorSearchState({required this.status, this.errorMessage, required this.allTutors});
  factory TutorSearchState.initial() {
    return const TutorSearchState(status: TutorSearchStatus.initial, allTutors: Stream.empty());
  }

  @override
  List<Object?> get props => [status, _time, allTutors];

  TutorSearchState copyWith({TutorSearchStatus? status, String? errorMessage, Stream<List<TutorModel>>? allTutors}) {
    return TutorSearchState(
        status: status ?? this.status,
        errorMessage: errorMessage ?? this.errorMessage,
        allTutors: allTutors ?? this.allTutors);
  }
}
