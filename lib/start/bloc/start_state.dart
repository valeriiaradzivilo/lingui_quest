part of 'start_cubit.dart';

enum StartStatus { initial, progress, error }

class StartState extends Equatable {
  final StartStatus status;
  final String? errorMessage;
  final UserModel currentUser;
  final bool isLoggedIn;
  final TabBarOption currentTab;
  final TutorModel tutorModel;
  int get _time => DateTime.now().microsecondsSinceEpoch;

  const StartState({
    required this.status,
    this.errorMessage,
    required this.currentUser,
    required this.isLoggedIn,
    required this.currentTab,
    required this.tutorModel,
  });
  factory StartState.initial() {
    return StartState(
      status: StartStatus.progress,
      currentUser: UserModel.empty(),
      isLoggedIn: false,
      currentTab: TabBarOption.level,
      tutorModel: TutorModel.empty(),
    );
  }

  @override
  List<Object?> get props => [status, _time, currentUser, isLoggedIn, currentTab, tutorModel];

  StartState copyWith({
    StartStatus? status,
    String? errorMessage,
    UserModel? currentUser,
    bool? isLoggedIn,
    TabBarOption? currentTab,
    TutorModel? tutorModel,
  }) {
    return StartState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      currentUser: currentUser ?? this.currentUser,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      currentTab: currentTab ?? this.currentTab,
      tutorModel: tutorModel ?? this.tutorModel,
    );
  }
}
