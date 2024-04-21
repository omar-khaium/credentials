import 'package:credentials/core/shared/extension/context.dart';
import 'package:credentials/core/shared/extension/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/loading_indicator.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/shared/theme/theme_bloc.dart';
import '../bloc/registration_bloc.dart';

class RegistrationPage extends StatefulWidget {
  static const String path = "/registration";
  static const String tag = "RegistrationPage";

  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;

        final VoidCallback onSubmit = () {
          if (formKey.currentState?.validate() ?? false) {
            context.read<RegistrationBloc>().add(
                  Register(
                    email: emailController.text,
                    password: passwordController.text,
                  ),
                );
          }
        };

        final usernameField = TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
          decoration: const InputDecoration(hintText: "email"),
          onFieldSubmitted: (value) {
            onSubmit();
          },
        );

        final passwordField = TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
          decoration: const InputDecoration(hintText: "password"),
          obscureText: true,
          onFieldSubmitted: (value) {
            onSubmit();
          },
        );

        final submitButton = SizedBox(
          width: MediaQuery.of(context).size.width,
          child: BlocConsumer<RegistrationBloc, RegistrationState>(
            listener: (_, state) {
              if (state is RegistrationDone) {
                context.pop();
                context.successNotification(message: "An email has been sent to ${state.user.email} to verify your account.");
              } else if (state is RegistrationError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      state.failure.message,
                      style: TextStyles.body(context: context, color: Colors.red),
                    ),
                    backgroundColor: Colors.red.shade100,
                  ),
                );
              }
            },
            builder: (_, state) {
              if (state is RegistrationLoading) {
                return ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(
                      top: context.bottomInset / 2 + 16,
                      bottom: context.bottomInset + 16,
                    ),
                  ),
                  child: const NetworkingIndicator(dimension: 24, color: Colors.white),
                );
              } else if (state is RegistrationDone) {
                return ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(
                      top: context.bottomInset / 2 + 16,
                      bottom: context.bottomInset + 16,
                    ),
                  ),
                  child: const Icon(
                    Icons.done_outline_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                );
              } else {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(
                      top: context.bottomInset / 2 + 16,
                      bottom: context.bottomInset + 16,
                    ),
                  ),
                  onPressed: onSubmit,
                  child: Text(
                    "Sign up".toUpperCase(),
                    style: TextStyles.miniHeadline(context: context, color: Colors.white).copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }
            },
          ),
        );

        return KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: theme.background,
            appBar: context.isMobile
                ? AppBar(
                    backgroundColor: Colors.white,
                    elevation: 0,
                    centerTitle: false,
                    titleSpacing: 32,
                    title: Text(
                      "Create an account",
                      style: TextStyles.headline(context: context, color: Colors.black),
                    ),
                  )
                : null,
            body: context.isMobile
                ? Align(
                    alignment: Alignment.bottomCenter,
                    child: PhysicalModel(
                      color: theme.accent.shade50,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
                      child: Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListView(
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(32),
                              children: [
                                const SizedBox(height: 16),
                                usernameField,
                                const SizedBox(height: 16),
                                passwordField,
                                const SizedBox(height: 16),
                              ],
                            ),
                            submitButton,
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.all(context.smallestSide / 8),
                    decoration: BoxDecoration(
                      color: theme.background,
                      borderRadius: const BorderRadius.all(Radius.circular(32)),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: theme.accent.shade100,
                            ),
                            child: Center(
                              child: Image.asset(
                                "assets/icon.png",
                                width: context.smallestSide / 2,
                                height: context.smallestSide / 2,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                        ),
                        VerticalDivider(),
                        Expanded(
                          child: Container(
                            color: theme.accent.shade50,
                            child: Center(
                              child: Form(
                                key: formKey,
                                child: ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(32),
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            context.pop();
                                          },
                                          icon: const Icon(Icons.arrow_back_rounded),
                                          color: theme.text,
                                        ),
                                        Text(
                                          "Create an account",
                                          style: TextStyles.title(context: context, color: theme.text),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 64),
                                    usernameField,
                                    const SizedBox(height: 16),
                                    passwordField,
                                    const SizedBox(height: 16),
                                    submitButton,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
