enum GameTheme {
  presentSimple,
  presentContinuous,
  presentPerfect,
  pastSimple,
  pastContinuous,
  pastPerfect,
  custom;

  String get label => switch (this) {
        presentSimple => 'Present Simple',
        presentContinuous => 'Present Continuous',
        presentPerfect => 'Present Perfect',
        pastSimple => 'Past Simple',
        pastContinuous => 'Past Continuous',
        pastPerfect => 'Past Perfect',
        custom => 'Custom Theme',
      };
}
