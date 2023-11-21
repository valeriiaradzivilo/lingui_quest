import 'package:flutter/material.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/enums/english_level_enum.dart';

class LinChooseLevel extends StatelessWidget {
  const LinChooseLevel({super.key, this.value, this.onChanged});
  final EnglishLevel? value;
  final void Function(EnglishLevel?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(context.loc.difficultyLevel),
        DropdownButton<EnglishLevel>(
          value: value,
          items: EnglishLevel.values.map((level) {
            return DropdownMenuItem<EnglishLevel>(
              value: level,
              child: Text('${level.levelName} (${level.name})'),
            );
          }).toList(),
          onChanged: onChanged,
        )
      ],
    );
  }
}
