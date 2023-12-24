import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/key_constants.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/start/app_routes.dart';
import 'package:lingui_quest/start/bloc/start_cubit.dart';
import 'package:lingui_quest/start/components/home_icon_button.dart';
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
    final theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: HomeIconButton(
            onTap: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: BlocConsumer<SignInCubit, SignInState>(
            listener: (context, state) {},
            builder: (context, state) {
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
                          Text(
                            context.loc.signIn.toUpperCase(),
                            style: theme.textTheme.displayMedium,
                          ),
                          Gap(PaddingConst.medium),
                          LinTextField(
                            controller: emailController,
                            label: context.loc.email,
                            option: TextFieldOption.email,
                          ),
                          Gap(PaddingConst.small),
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
                          Gap(PaddingConst.medium),
                          LinMainButton(
                              label: context.loc.signIn,
                              onTap: () async {
                                final res = await bloc.login(emailController.text, passwordController.text);
                                if (res) {
                                  blocStart.setLoggedIn();
                                  Navigator.of(context).pushNamed(AppRoutes.initial.path);
                                }
                              }),
                          Gap(PaddingConst.small),
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
