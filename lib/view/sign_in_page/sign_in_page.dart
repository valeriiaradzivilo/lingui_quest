import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/key_constants.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
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
    final SignInCubit bloc = BlocProvider.of<SignInCubit>(context);
    final StartCubit blocStart = BlocProvider.of<StartCubit>(context);
    return Scaffold(
        body: BlocConsumer<SignInCubit, SignInState>(listener: (context, state) {
      if (state.status == SignInStatus.success) {
        blocStart.setLoggedIn();
        Navigator.of(context).pushNamed(AppRoutes.initial.path);
      }
    }, builder: (context, state) {
      return Padding(
        padding: EdgeInsets.all(PaddingConst.large),
        child: Center(
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
                    option: TextFieldOption.email,
                  ),
                  LinTextField(
                    controller: passwordController,
                    label: context.loc.password,
                    option: TextFieldOption.password,
                  ),
                  if (state.status == SignInStatus.error)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Error occured. Try again'),
                        Text(state.errorMessage ?? ''),
                      ],
                    ),
                  LinMainButton(
                      label: context.loc.signIn,
                      onTap: () async {
                        await bloc.login(emailController.text, passwordController.text);
                      }),
                  InkWell(
                      key: ValueKey(KeyConstants.noProfileYet),
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.signUp.path);
                      },
                      child: Text(
                        context.loc.noProfileYet,
                        style: const TextStyle(decoration: TextDecoration.underline),
                      ))
                ],
              ),
            ),
          ),
        ),
      );
    }));
  }
}
