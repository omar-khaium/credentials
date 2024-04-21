import 'package:credentials/core/shared/extension/context.dart';
import 'package:credentials/core/shared/extension/theme.dart';
import 'package:credentials/features/credential/presentation/bloc/hit_credential_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/shared.dart';
import '../../../../core/shared/theme/theme_bloc.dart';
import '../../domain/entities/credential.dart';
import '../bloc/archive_credential_bloc.dart';
import '../bloc/update_credential_bloc.dart';
import 'update.dart';

class ViewCredentialWidget extends StatefulWidget {
  final CredentialEntity credential;
  const ViewCredentialWidget({
    super.key,
    required this.credential,
  });

  @override
  State<ViewCredentialWidget> createState() => _ViewCredentialWidgetState();
}

class _ViewCredentialWidgetState extends State<ViewCredentialWidget> {
  @override
  void initState() {
    super.initState();
    context.read<HitCredentialBloc>().add(HitCredential(credential: widget.credential));
  }

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
                  child: widget.credential.logo != null
                      ? Image.network(
                          widget.credential.logo!,
                          fit: BoxFit.contain,
                          width: 54,
                          height: 54,
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
                  widget.credential.url,
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
                      widget.credential.username,
                      style: TextStyles.subTitle(context: context, color: theme.link).copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.copy, color: theme.link),
                    onTap: () async {
                      await Clipboard.setData(ClipboardData(text: widget.credential.username));
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
                      await Clipboard.setData(ClipboardData(text: widget.credential.password));
                      context.successNotification(message: "password copied");
                    },
                  ),
                ),
              ),
              Divider(thickness: 1, color: theme.accent.shade50, height: 32),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (_) => AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              scrollable: true,
                              content: BlocProvider(
                                create: (_) => sl<UpdateCredentialBloc>(),
                                child: UpdateCredentialWidget(
                                  credential: widget.credential,
                                ),
                              ),
                              contentPadding: EdgeInsets.zero,
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent.shade700,
                        ),
                        icon: Icon(Icons.edit_outlined, color: theme.background),
                        label: Text(
                          "Edit",
                          style: TextStyles.body(context: context, color: theme.background),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: BlocProvider(
                        create: (context) => sl<ArchiveCredentialBloc>(),
                        child: BlocConsumer<ArchiveCredentialBloc, ArchiveCredentialState>(
                          listener: (_, state) {
                            if (state is ArchiveCredentialDone) {
                              context.successNotification(message: "Credential archived");
                              context.pop();
                            } else if (state is ArchiveCredentialError) {
                              context.errorNotification(message: state.failure.message);
                            }
                          },
                          builder: (builderContext, state) {
                            if (state is ArchiveCredentialLoading) {
                              return ElevatedButton(
                                onPressed: () {},
                                child: CircularProgressIndicator(),
                              );
                            }
                            return ElevatedButton.icon(
                              onPressed: () {
                                builderContext
                                    .read<ArchiveCredentialBloc>()
                                    .add(ArchiveCredential(credential: widget.credential));
                              },
                              icon: Icon(Icons.archive_outlined, color: theme.background),
                              label: Text(
                                "Archive",
                                style: TextStyles.body(context: context, color: theme.background),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
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
