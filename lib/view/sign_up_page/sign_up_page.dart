import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/key_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/view/sign_up_page/bloc/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final SignUpCubit bloc = BlocProvider.of<SignUpCubit>(context);
    return AlertDialog(
      title: Text(context.loc.signUp),
      content: BlocBuilder<SignUpCubit, SignUpState>(
          bloc: bloc,
          builder: (context, state) {
            if (state.status == SignUpStatus.initial) {
              return Center(
                child: Container(
                  constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width, minWidth: 600),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LinTextField(
                          controller: firstNameController,
                          label: context.loc.firstName,
                          option: TextFieldOption.email,
                        ),
                        LinTextField(
                          controller: lastNameController,
                          label: context.loc.lastName,
                          option: TextFieldOption.email,
                        ),
                        LinTextField(
                          key: ValueKey(KeyConstants.emailSignUpField),
                          controller: emailController,
                          label: context.loc.email,
                          option: TextFieldOption.email,
                        ),
                        LinTextField(
                          key: ValueKey(KeyConstants.passwordSignUpField),
                          controller: passwordController,
                          label: context.loc.password,
                          option: TextFieldOption.password,
                        ),
                        LinButton(
                          key: ValueKey(KeyConstants.signUpButton),
                          label: context.loc.signUp,
                          onTap: () async {
                            final res = await bloc.signUp(firstNameController.text, lastNameController.text,
                                emailController.text, passwordController.text);
                            if (res) {
                              Navigator.of(context).maybePop();
                            }
                          },
                          isEnabled: _formKey.currentState?.validate() ?? false,
                        ),
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
