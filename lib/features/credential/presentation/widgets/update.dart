import 'dart:math';

import 'package:credentials/core/shared/extension/context.dart';
import 'package:credentials/core/shared/extension/credential.dart';
import 'package:credentials/core/shared/extension/theme.dart';
import 'package:credentials/core/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/shared/loading_indicator.dart';
import '../../../../core/shared/theme/theme_bloc.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/credential.dart';
import '../bloc/update_credential_bloc.dart';

class UpdateCredentialWidget extends StatefulWidget {
  final CredentialEntity credential;

  const UpdateCredentialWidget({
    super.key,
    required this.credential,
  });

  @override
  _UpdateCredentialWidgetState createState() => _UpdateCredentialWidgetState();
}

class _UpdateCredentialWidgetState extends State<UpdateCredentialWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _logoController = TextEditingController();

  bool _isObscure = true;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();

    _urlController.text = widget.credential.url;
    _usernameController.text = widget.credential.username;
    _passwordController.text = widget.credential.password;
    _remarksController.text = widget.credential.remarks;
    _logoController.text = widget.credential.logo ?? "";
    _isActive = widget.credential.isActive;
  }

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
              color: theme.accent.shade50,
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
                      Icon(Icons.add_moderator, color: theme.accent),
                      SizedBox(width: 4),
                      Text(
                        "Modify Credential",
                        style: TextStyles.miniHeadline(context: context, color: theme.accent)
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
                        Icon(Icons.security_rounded, color: theme.accent),
                        SizedBox(width: 4),
                        Text(
                          "Suggest password",
                          style: TextStyles.body(context: context, color: theme.accent).copyWith(fontWeight: FontWeight.bold),
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
                    child: BlocConsumer<UpdateCredentialBloc, UpdateCredentialState>(
                      listener: (context, state) {
                        if (state is UpdateCredentialDone) {
                          context.pop();
                          context.successNotification(message: "Credential modified successfully");
                        } else if (state is UpdateCredentialError) {
                          context.errorNotification(message: state.failure.message);
                        }
                      },
                      builder: (context, state) {
                        if (state is UpdateCredentialLoading) {
                          return ElevatedButton(
                            onPressed: () {},
                            child: NetworkingIndicator(dimension: 24, color: Colors.white),
                          );
                        }
                        return ElevatedButton.icon(
                          onPressed: () async {
                            if (_formKey.currentState?.validate() ?? false) {
                              final CredentialEntity _credential = widget.credential.copyWith(
                                username: _usernameController.text,
                                password: _passwordController.text,
                                url: _urlController.text,
                                remarks: _remarksController.text,
                                lastUpdatedAt: DateTime.now().subtract(DateTime.now().timeZoneOffset),
                                isActive: _isActive,
                                logo: _logoController.text,
                              );

                              context.read<UpdateCredentialBloc>().add(UpdateCredential(credential: _credential));
                            }
                          },
                          icon: Icon(Icons.save_outlined, color: Colors.white),
                          label: Text(
                            "Update",
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
