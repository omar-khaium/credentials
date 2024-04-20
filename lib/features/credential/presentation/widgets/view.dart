import 'package:credentials/core/shared/extension/context.dart';
import 'package:credentials/core/shared/extension/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/shared.dart';
import '../../../../core/shared/theme/theme_bloc.dart';
import '../../domain/entities/credential.dart';

class ViewCredentialWidget extends StatelessWidget {
  final CredentialEntity credential;
  const ViewCredentialWidget({
    super.key,
    required this.credential,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: theme.background,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              width: 8,
              color: theme.accent.shade50,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PhysicalModel(
                color: theme.background,
                child: AspectRatio(
                  aspectRatio: 2,
                  child: credential.logo != null
                      ? Image.network(
                          credential.logo!,
                          fit: BoxFit.cover,
                        )
                      : Center(
                          child: Image.asset(
                            "assets/icon.png",
                            fit: BoxFit.cover,
                            width: 54,
                            height: 54,
                          ),
                        ),
                ),
              ),
              Divider(thickness: 1, color: theme.accent.shade50, height: 24),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  credential.url,
                  style: TextStyles.title(context: context, color: theme.text),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Divider(thickness: 1, color: theme.accent.shade50, height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PhysicalModel(
                  color: theme.accent.shade50,
                  borderRadius: BorderRadius.circular(16),
                  child: ListTile(
                    leading: Icon(Icons.account_circle_outlined, color: theme.link),
                    title: Text(
                      credential.username,
                      style: TextStyles.subTitle(context: context, color: theme.link).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.copy, color: theme.link),
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: credential.username));
                      context.successNotification(message: "username copied");
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: PhysicalModel(
                  color: theme.accent.shade50,
                  borderRadius: BorderRadius.circular(16),
                  child: ListTile(
                    leading: Icon(Icons.lock_outline_rounded, color: theme.link),
                    title: Text(
                      "**********",
                      style: TextStyles.subTitle(context: context, color: theme.link).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.copy, color: theme.link),
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: credential.password));
                      context.successNotification(message: "password copied");
                    },
                  ),
                ),
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }
}
