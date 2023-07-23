enum EnglishLevel {
  a1,
  a2,
  b1,
  b2,
  c1,
  c2,
}

extension EnglishLevelExtension on EnglishLevel {
  String get levelName {
    switch (this) {
      case EnglishLevel.a1:
        return 'Elementary';
      case EnglishLevel.a2:
        return 'Pre-Intermediate';
      case EnglishLevel.b1:
        return 'Intermediate';
      case EnglishLevel.b2:
        return 'Upper-Intermediate';
      case EnglishLevel.c1:
        return 'Advanced';
      case EnglishLevel.c2:
        return 'Proficient';
      default:
        return '';
    }
  }
}
