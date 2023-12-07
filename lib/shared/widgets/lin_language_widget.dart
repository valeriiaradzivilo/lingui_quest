import 'package:flutter/material.dart';

//TODO: Maybe delete it
class LinLanguage extends StatelessWidget {
  const LinLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Ukr'),
        SizedBox(
          width: 20,
          child: Divider(
            color: Theme.of(context).colorScheme.onBackground,
            height: 10,
          ),
        ),
        const Text('Eng')
      ],
    );
  }
}
