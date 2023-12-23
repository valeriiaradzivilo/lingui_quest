class WeakPasswordException implements Exception {
  final String? message;
  WeakPasswordException({this.message});
}

class AccountAlreadyExistsException implements Exception {
  final String? message;
  AccountAlreadyExistsException({this.message});
}

class NoUserFoundException implements Exception {
  final String? message;
  NoUserFoundException({this.message});
}
