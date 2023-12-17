enum FirebaseCollection {
  games,
  gameResult,
  groups,
  testTasks,
  tutor,
  userData,
  joinRequest;

  String get collectionName => switch (this) {
        games => 'games',
        groups => 'studentGroups',
        testTasks => 'testTasks',
        tutor => 'tutorInfo',
        userData => 'userData',
        joinRequest => 'joinRequest',
        gameResult => 'gameResult',
      };
}
