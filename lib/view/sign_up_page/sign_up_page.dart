import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lingui_quest/core/extensions/app_localization_context.dart';
import 'package:lingui_quest/shared/constants/key_constants.dart';
import 'package:lingui_quest/shared/constants/padding_constants.dart';
import 'package:lingui_quest/shared/widgets/lin_main_button.dart';
import 'package:lingui_quest/shared/widgets/lin_text_editing_field.dart';
import 'package:lingui_quest/start/routes.dart';
import 'package:lingui_quest/view/sign_up_page/bloc/sign_up_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignUpPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final SignUpCubit bloc = BlocProvider.of<SignUpCubit>(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(PaddingConst.large),
        child: BlocBuilder<SignUpCubit, SignUpState>(
            bloc: bloc,
            builder: (context, state) {
              if (state.status == SignUpStatus.initial) {
                return Form(
                  key: _formKey,
                  onChanged: () {
                    if ((_emailController.text.isNotEmpty &&
                            _lastNameController.text.isNotEmpty &&
                            _firstNameController.text.isNotEmpty &&
                            _passwordController.text.isNotEmpty) ||
                        _passwordController.text.isNotEmpty) {
                      setState(() => _formKey.currentState?.validate());
                    }
                  },
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              allowDrawingOutsideViewBox: true,
                              "assets/logo/logo.svg",
                              width: 100,
                              height: 100,
                            ),
                            SizedBox(width: PaddingConst.large),
                            Text(
                              context.loc.signUp,
                              style: theme.textTheme.displayLarge,
                            ),
                          ],
                        ),
                        SizedBox(height: PaddingConst.large),
                        Wrap(
                          spacing: PaddingConst.large,
                          runSpacing: PaddingConst.medium,
                          runAlignment: WrapAlignment.start,
                          children: [
                            LinTextField(
                              controller: _firstNameController,
                              label: context.loc.firstName,
                              option: TextFieldOption.name,
                            ),
                            LinTextField(
                              controller: _lastNameController,
                              label: context.loc.lastName,
                              option: TextFieldOption.name,
                            ),
                          ],
                        ),
                        SizedBox(height: PaddingConst.medium),
                        LinTextField(
                          key: ValueKey(KeyConstants.emailSignUpField),
                          controller: _emailController,
                          label: context.loc.email,
                          option: TextFieldOption.email,
                        ),
                        SizedBox(height: PaddingConst.medium),
                        LinTextField(
                          key: ValueKey(KeyConstants.passwordSignUpField),
                          controller: _passwordController,
                          label: context.loc.password,
                          option: TextFieldOption.password,
                        ),
                        SizedBox(height: PaddingConst.medium),
                        LinTextField(
                          controller: _confirmPasswordController,
                          label: context.loc.confirmPassword,
                          option: TextFieldOption.password,
                          textToMatch: _passwordController.text,
                        ),
                        SizedBox(height: PaddingConst.large),
                        LinMainButton(
                          key: ValueKey(KeyConstants.signUpButton),
                          label: context.loc.signUp,
                          onTap: () async {
                            final validated = _formKey.currentState?.validate() ?? false;
                            if (validated) {
                              final res = await bloc.signUp(_firstNameController.text, _lastNameController.text,
                                  _emailController.text, _passwordController.text);
                              if (res) {
                                Navigator.of(context).pushReplacementNamed(AppRoutes.initial);
                              }
                            }
                          },
                        ),
                        if (state.status == SignUpStatus.error) ...[
                          Text(state.errorMessage ?? context.loc.errorOccurredSignUp)
                        ]
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
