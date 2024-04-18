import 'package:credentials/core/shared/extension/context.dart';
import 'package:credentials/core/shared/extension/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/loading_indicator.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/shared/theme/theme_bloc.dart';
import '../../../dashboard/presentation/pages/dashboard.dart';
import '../bloc/authentication_bloc.dart';

class AuthenticationPage extends StatefulWidget {
  static const String path = "/authentication";
  static const String tag = "AuthenticationPage";

  const AuthenticationPage({super.key});

  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;

        return KeyboardDismissOnTap(
          child: Scaffold(
            backgroundColor: theme.background,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: false,
              titleSpacing: 32,
              title: Text(
                "Login",
                style: TextStyles.headline(context: context, color: Colors.black),
              ),
            ),
            body: Align(
              alignment: Alignment.bottomCenter,
              child: PhysicalModel(
                color: Colors.lightBlue.shade50,
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
                          TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
                            decoration: const InputDecoration(hintText: "email"),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: passwordController,
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.done,
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (val) => (val?.isNotEmpty ?? false) ? null : "",
                            decoration: const InputDecoration(hintText: "password"),
                            obscureText: true,
                          ),
                          const SizedBox(height: 16),
                        ],
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
                          listener: (_, state) {
                            if (state is AuthenticationDone) {
                              context.goNamed(DashboardPage.tag);
                            } else if (state is AuthenticationError) {
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
                            if (state is AuthenticationLoading) {
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
                            } else if (state is AuthenticationDone) {
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
                                onPressed: () {
                                  if (formKey.currentState?.validate() ?? false) {
                                    context.read<AuthenticationBloc>().add(
                                          Authenticate(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          ),
                                        );
                                  }
                                },
                                child: Text(
                                  "Login".toUpperCase(),
                                  style: TextStyles.miniHeadline(context: context, color: Colors.white).copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
