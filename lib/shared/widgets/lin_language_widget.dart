import 'package:flutter/material.dart';

class LinLanguage extends StatelessWidget {
  const LinLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        const Text('Ukr'),
        SizedBox(
          width: 20,
          child: Divider(
            color: Theme.of(context).colorScheme.onBackground,
            height: 10,
          ),
        ),
        const Text("Eng")
      ],
    );
  }
}
