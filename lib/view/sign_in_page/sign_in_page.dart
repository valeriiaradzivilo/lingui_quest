import 'package:feather_icons/feather_icons.dart';
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
  bool obscureText = true;

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final SignInCubit bloc = BlocProvider.of<SignInCubit>(context);
    final StartCubit blocStart = BlocProvider.of<StartCubit>(context);
    final theme = Theme.of(context);
    final formKey = GlobalKey<FormState>();
    return Scaffold(
        appBar: AppBar(
          title: HomeIconButton(
            onTap: () => Navigator.of(context).pop(),
          ),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        body: BlocConsumer<SignInCubit, SignInState>(
            bloc: bloc..init(),
            listener: (context, state) {},
            builder: (context, state) {
              return Padding(
                padding: EdgeInsets.all(PaddingConst.large),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Form(
                      key: formKey,
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
                          Container(
                            constraints:
                                BoxConstraints(maxWidth: TextFieldOption.password.maxFieldWidth ?? double.infinity),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: passwordController,
                                    minLines: null,
                                    maxLines: 1,
                                    obscureText: obscureText,
                                    autovalidateMode: AutovalidateMode.onUserInteraction,
                                    validator: (value) =>
                                        value == null || value.isEmpty ? context.loc.fieldShouldNotBeEmpty : null,
                                    decoration: InputDecoration(label: Text(context.loc.password), errorMaxLines: 10),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () => setState(() => obscureText = !obscureText),
                                    icon: Icon(obscureText ? FeatherIcons.eye : FeatherIcons.eyeOff)),
                              ],
                            ),
                          ),
                          if (state.status == SignInStatus.error)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Gap(PaddingConst.medium),
                                Text(
                                  'The account was not found. Check email and password and try again!',
                                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.error),
                                ),
                                Text(state.errorMessage ?? ''),
                              ],
                            ),
                          Gap(PaddingConst.medium),
                          LinMainButton(
                              label: context.loc.signIn,
                              onTap: () async {
                                if (formKey.currentState?.validate() ?? false) {
                                  final res = await bloc.login(emailController.text, passwordController.text);
                                  if (res) {
                                    blocStart.setLoggedIn();
                                    Navigator.of(context).pushNamed(AppRoutes.initial.path);
                                  }
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
