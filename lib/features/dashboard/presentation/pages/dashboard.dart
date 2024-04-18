import 'package:credentials/core/shared/extension/context.dart';
import 'package:credentials/core/shared/extension/theme.dart';
import 'package:credentials/core/shared/shared.dart';
import 'package:credentials/features/authentication/presentation/pages/authentication.dart';
import 'package:credentials/features/credential/presentation/bloc/credential_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/theme/theme_bloc.dart';
import '../../../../src/view/routes/route_archive.dart';

class DashboardPage extends StatefulWidget {
  static const String path = "/";
  static const String tag = "DashboardPage";
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  void initState() {
    super.initState();

    sl<FirebaseAuth>().authStateChanges().listen((user) {
      if (user == null) {
        context.goNamed(AuthenticationPage.tag);
      }
    });

    context.credentialBloc.add(FetchCredentials());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (_, state) {
        final theme = state.scheme;
        return Scaffold(
          backgroundColor: theme.background,
          appBar: AppBar(
            backgroundColor: theme.background,
            automaticallyImplyLeading: true,
            leading: Tooltip(
              message: 'Profile',
              child: IconButton(
                icon: CircleAvatar(
                  child: Icon(Icons.person_outline_rounded, color: Colors.white),
                  backgroundColor: Colors.blue.shade600,
                ),
                onPressed: () {},
              ),
            ),
            title: Text("Dashboard"),
            actions: [
              Tooltip(
                message: 'Archives',
                child: IconButton(
                  icon: Icon(Icons.archive_outlined),
                  onPressed: () async {
                    Navigator.of(context).pushNamed(ArchiveRoute().route);
                  },
                ),
              ),
              Tooltip(
                message: 'Sign out',
                child: IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                              title: Text("Confirmation"),
                              content: Text("Are you sure ?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await sl<FirebaseAuth>().signOut();
                                  },
                                  child: Text("Logout"),
                                ),
                              ],
                            ));
                  },
                ),
              ),
            ],
          ),
          body: BlocBuilder<CredentialBloc, CredentialState>(
            builder: (context, state) {
              if (state is CredentialLoading) {
                return Center(child: CircularProgressIndicator());
              } else if (state is CredentialDone) {
                return MasonryGridView.count(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  crossAxisCount: 4,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  padding: EdgeInsets.all(24),
                  clipBehavior: Clip.none,
                  itemCount: state.credentials.length,
                  itemBuilder: (_, index) {
                    final credential = state.credentials[index];
                    return Container(
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: theme.background,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          width: 3,
                          color: theme.accent.shade50,
                          strokeAlign: BorderSide.strokeAlignOutside,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PhysicalModel(
                            color: theme.accent.shade50,
                            child: AspectRatio(
                              aspectRatio: 3,
                              child: Stack(
                                children: [
                                  Positioned.fill(
                                    child: credential.logo != null
                                        ? Image.network(
                                            credential.logo!,
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(Icons.lock_outline_rounded, size: 48),
                                  ),
                                  if (credential.hitCount != null && credential.hitCount! > 10)
                                    Positioned(
                                      right: 0,
                                      top: 0,
                                      child: Icon(
                                        Icons.trending_up_rounded,
                                        color: theme.warning,
                                        weight: 700,
                                        grade: 200,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  credential.url,
                                  style: TextStyles.title(context: context, color: theme.link),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  credential.username,
                                  style: TextStyles.subTitle(context: context, color: theme.text),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  "Last updated: ${DateFormat("h:mm a d MMM, yy").format(credential.lastUpdatedAt.toLocal())}",
                                  style: TextStyles.caption(context: context, color: theme.hint),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
              } else if (state is CredentialError) {
                return Center(child: Text(state.failure.message));
              }
              return Container();
            },
          ),
          floatingActionButton: Tooltip(
            message: 'Add new credential',
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {},
            ),
          ),
        );
      },
    );
  }
}
