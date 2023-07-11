import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/view/sign_in_page/bloc/sign_in_bloc.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
      if (state.status == SignInStatus.success) {
        return Column(
          children: [
            LinTextField(
              controller: emailController,
              label: 'Email',
            ),
            LinTextField(
              controller: passwordController,
              label: 'Password',
            ),
            LinButton(label: 'Sign in', onTap: () {}),
            InkWell(
                onTap: () {},
                child: const Text(
                  'no profile yet, sign up',
                  style: TextStyle(decoration: TextDecoration.underline),
                ))
          ],
        );
      } else {
        return const CircularProgressIndicator();
      }
    });
  }
}
