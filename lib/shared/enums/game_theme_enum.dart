enum GameTheme {
  presentSimple,
  presentContinuous,
  presentPerfect,
  pastSimple,
  pastContinuous,
  pastPerfect,
  futureSimple,
  futureContinuous,
  futurePerfect,
  quantifiers,
  infinitive,
  modalVerbs,
  articles,
  pronouns,
  custom;

  String get label => switch (this) {
        presentSimple => 'Present Simple',
        presentContinuous => 'Present Continuous',
        presentPerfect => 'Present Perfect',
        pastSimple => 'Past Simple',
        pastContinuous => 'Past Continuous',
        pastPerfect => 'Past Perfect',
        futureSimple => 'Future Simple',
        futureContinuous => 'Future Continuous',
        futurePerfect => 'Future Perfect',
        quantifiers => 'Quantifiers',
        infinitive => 'Infinitive',
        modalVerbs => 'Modal Verbs',
        articles => 'Articles',
        pronouns => 'Pronouns',
        custom => 'Custom Theme',
      };
}
