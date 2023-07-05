import 'package:flutter/material.dart';
import 'package:lingui_quest/view/sign_in_page/sign_in_page.dart';

class LinDialogue {
  Future<void> showSignInDialogue(BuildContext context) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return const AlertDialog(
            content: SignInPage(),
          );
        });
  }
}
