import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extentions/app_localization_context.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/view/home_page/home_page.dart';
import 'package:lingui_quest/view/sign_up_page/bloc/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final SignUpCubit bloc = BlocProvider.of<SignUpCubit>(context);
    return Scaffold(
      body: BlocBuilder<SignUpCubit, SignUpState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.status == SignUpStatus.initial) {
              return Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 600),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinTextField(
                          key: const ValueKey('emailSignUpField'),
                          controller: emailController,
                          label: context.loc.email,
                          option: TextFieldOption.email,
                        ),
                        LinTextField(
                          key: const ValueKey('passwordSignUpField'),
                          controller: passwordController,
                          label: context.loc.password,
                          option: TextFieldOption.password,
                        ),
                        LinMainButton(
                          key: const ValueKey('signUpButton'),
                          label: context.loc.signUp,
                          onTap: () => bloc.signUp(
                              emailController.text, passwordController.text),
                          isEnabled: _formKey.currentState?.validate() ?? false,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else if (state.status == SignUpStatus.success) {
              return const HomePage();
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
