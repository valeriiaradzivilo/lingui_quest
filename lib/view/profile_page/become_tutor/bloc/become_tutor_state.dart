part of 'become_tutor_cubit.dart';

enum BecomeTutorStatus { initial, progress, error, success }

class BecomeTutorState extends Equatable {
  final BecomeTutorStatus status;
  final String? errorMessage;
  final String about;
  final Map<String, String> contacts;
  final Currency? currency;
  final Map<String, double> price;
  final String preferences;
  final String userId;

  int get _time => DateTime.now().microsecondsSinceEpoch;

  const BecomeTutorState(
      {required this.status,
      this.errorMessage,
      required this.about,
      required this.contacts,
      required this.currency,
      required this.preferences,
      required this.price,
      required this.userId});
  factory BecomeTutorState.initial() {
    return const BecomeTutorState(
      status: BecomeTutorStatus.initial,
      about: '',
      currency: null,
      contacts: {},
      preferences: '',
      price: {},
      userId: '',
    );
  }

  @override
  List<Object?> get props => [status, _time, about, currency, contacts, preferences, price, userId];

  BecomeTutorState copyWith({
    BecomeTutorStatus? status,
    String? errorMessage,
    String? about,
    Currency? currency,
    Map<String, String>? contacts,
    String? preferences,
    Map<String, double>? price,
    String? userId,
  }) {
    return BecomeTutorState(
        status: status ?? this.status,
        errorMessage: errorMessage,
        about: about ?? this.about,
        contacts: contacts ?? this.contacts,
        currency: currency ?? this.currency,
        preferences: preferences ?? this.preferences,
        price: price ?? this.price,
        userId: userId ?? this.userId);
  }
}
