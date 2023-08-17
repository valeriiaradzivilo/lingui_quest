enum EnglishLevel {
  a1,
  a2,
  b1,
  b2,
  c1,
  c2;

  factory EnglishLevel.levelFromString(String level) {
    try {
      return EnglishLevel.values.firstWhere((element) => element.name.toLowerCase() == level.toLowerCase());
    } catch (e) {
      return EnglishLevel.a1;
    }
  }
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

  EnglishLevel? get nextLevel {
    return index + 1 < EnglishLevel.values.length ? EnglishLevel.values.elementAt(index + 1) : null;
  }

  EnglishLevel? get previousLevel {
    return index - 1 >= 0 ? EnglishLevel.values.elementAt(index - 1) : null;
  }
}
