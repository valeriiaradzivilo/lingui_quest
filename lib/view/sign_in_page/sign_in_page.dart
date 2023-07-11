import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/start/routes.dart';
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
    return Scaffold(
      body: BlocBuilder<SignInCubit, SignInState>(builder: (context, state) {
        if (state.status == SignInStatus.initial) {
          return Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LinTextField(
                      controller: emailController,
                      label: context.loc.email,
                    ),
                    LinTextField(
                      controller: passwordController,
                      label: context.loc.password,
                    ),
                    LinMainButton(label: context.loc.signIn, onTap: () {}),
                    InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(AppRoutes.signUp);
                        },
                        child: Text(
                          context.loc.noProfileYet,
                          style: const TextStyle(decoration: TextDecoration.underline),
                        ))
                  ],
                ),
              ),
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),
    );
  }
}
