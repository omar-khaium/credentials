import 'dart:math';

import 'package:credentials/core/shared/extension/context.dart';
import 'package:credentials/core/shared/extension/theme.dart';
import 'package:credentials/core/shared/shared.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/loading_indicator.dart';
import '../../../../core/shared/theme/theme_bloc.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/credential.dart';
import '../bloc/create_credential_bloc.dart';

class CreateCredentialWidget extends StatefulWidget {
  @override
  _CreateCredentialWidgetState createState() => _CreateCredentialWidgetState();
}

class _CreateCredentialWidgetState extends State<CreateCredentialWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _logoController = TextEditingController();

  bool _isObscure = true;
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Container(
          width: context.width * 0.3,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 8,
              color: theme.tertiary,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.add_moderator, color: theme.primary),
                      SizedBox(width: 4),
                      Text(
                        "New Credential",
                        style: TextStyles.miniHeadline(context: context, color: theme.primary)
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(height: 32),
                  Text(
                    "Url *",
                    style: TextStyles.caption(context: context, color: theme.text).copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: _urlController,
                    keyboardType: TextInputType.url,
                    validator: (val) => val?.isEmpty ?? true ? "required" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Logo",
                    style: TextStyles.caption(context: context, color: theme.text).copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: _logoController,
                    keyboardType: TextInputType.url,
                    onChanged: (value) => setState(() {}),
                  ),
                  if (_logoController.text.isNotEmpty) ...[
                    SizedBox(height: 8),
                    Image.network(_logoController.text, width: 64, height: 64),
                  ],
                  SizedBox(height: 16),
                  Text(
                    "Username *",
                    style: TextStyles.caption(context: context, color: theme.text).copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) => val?.isEmpty ?? true ? "required" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Password *",
                    style: TextStyles.caption(context: context, color: theme.text).copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    validator: (val) => val?.isEmpty ?? true ? "required" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    autofillHints: [AutofillHints.newPassword, AutofillHints.password],
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                        splashRadius: 24,
                        icon: Icon(_isObscure ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        },
                      ),
                    ),
                    obscureText: _isObscure,
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: suggestPassword,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.security_rounded, color: theme.primary),
                        SizedBox(width: 4),
                        Text(
                          "Suggest password",
                          style: TextStyles.body(context: context, color: theme.primary).copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Remarks",
                    style: TextStyles.caption(context: context, color: theme.text).copyWith(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  TextField(
                    controller: _remarksController,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: 8,
                  ),
                  SizedBox(height: 4),
                  CheckboxListTile(
                    value: _isActive,
                    onChanged: (flag) {
                      if (flag != null) {
                        setState(() {
                          _isActive = flag;
                        });
                      }
                    },
                    title: Text("Active"),
                    controlAffinity: ListTileControlAffinity.trailing,
                    contentPadding: EdgeInsets.zero,
                  ),
                  SizedBox(height: 4),
                  SizedBox(
                    width: double.infinity,
                    height: kToolbarHeight,
                    child: BlocConsumer<CreateCredentialBloc, CreateCredentialState>(
                      listener: (context, state) {
                        if (state is CreateCredentialDone) {
                          context.pop();
                          context.successNotification(message: "Credential added successfully");
                        } else if (state is CreateCredentialError) {
                          context.errorNotification(message: state.failure.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is CreateCredentialLoading) {
                          return ElevatedButton(
                            onPressed: () {},
                            child: NetworkingIndicator(dimension: 24, color: Colors.white),
                          );
                        }
                        return ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final String userId = sl<FirebaseAuth>().currentUser!.uid;
                              final CredentialEntity _credential = CredentialEntity(
                                id: "",
                                username: _usernameController.text,
                                password: _passwordController.text,
                                url: _urlController.text,
                                remarks: _remarksController.text,
                                createdAt: DateTime.now().subtract(DateTime.now().timeZoneOffset),
                                createdBy: userId,
                                lastUpdatedAt: DateTime.now().subtract(DateTime.now().timeZoneOffset),
                                isActive: _isActive,
                                logo: _logoController.text,
                                hitCount: 0,
                              );

                              context.read<CreateCredentialBloc>().add(CreateCredential(credential: _credential));
                            }
                          },
                          icon: Icon(Icons.save_outlined, color: Colors.white),
                          label: Text(
                            "Save",
                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                          ),
                        );
                      },
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

  void suggestPassword() {
    final random = Random();
    final characters = 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#\$%^&*()_+';
    String password = '';
    for (int i = 0; i < 12; i++) {
      password += characters[random.nextInt(characters.length)];
    }
    setState(() {
      // Update the displayed password
      _passwordController.text = password;
      _isObscure = false;
    });
  }
}
