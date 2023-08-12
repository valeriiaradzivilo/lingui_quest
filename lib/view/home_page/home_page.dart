import 'package:flutter/material.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(PaddingConst.immense),
        child: const Text(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pulvinar tellus risus, in aliquet mauris aliquet feugiat. Morbi eget sapien ornare, dictum enim non, sodales odio. Nunc posuere purus vitae risus egestas dictum. Proin aliquet vel magna nec ullamcorper. Donec tortor ex, faucibus sed lacus id, consectetur pulvinar neque. Vestibulum in malesuada quam. Nulla consequat, ligula pharetra feugiat sodales, leo nibh finibus mauris, vitae ornare nulla justo nec sem. Aliquam non posuere dolor, quis faucibus tellus. Donec non ultrices massa, quis dictum nisi. Curabitur dictum enim ut gravida posuere. Suspendisse lectus urna, facilisis quis tortor ut, elementum accumsan velit.'),
      ),
    );
  }
}
