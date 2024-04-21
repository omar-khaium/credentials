import 'package:credentials/core/shared/extension/context.dart';
import 'package:credentials/core/shared/extension/theme.dart';
import 'package:credentials/core/shared/shared.dart';
import 'package:credentials/features/authentication/presentation/pages/authentication.dart';
import 'package:credentials/features/credential/domain/entities/credential.dart';
import 'package:credentials/features/credential/presentation/bloc/create_credential_bloc.dart';
import 'package:credentials/features/credential/presentation/bloc/credential_bloc.dart';
import 'package:credentials/features/credential/presentation/bloc/hit_credential_bloc.dart';
import 'package:credentials/features/credential/presentation/widgets/add.dart';
import 'package:credentials/features/credential/presentation/widgets/view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../core/config/config.dart';
import '../../../../core/shared/theme/theme_bloc.dart';

part '../widgets/all.dart';
part '../widgets/all_item.dart';
part '../widgets/popular.dart';
part '../widgets/popular_item.dart';

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
      if (user == null && mounted) {
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
            scrolledUnderElevation: 1,
            shadowColor: theme.shadow,
            leading: Container(
              margin: EdgeInsets.only(left: 16, right: 8),
              child: Image.asset("assets/icon.png"),
            ),
            title: Text(
              "Dashboard",
              style: TextStyles.headline(context: context, color: theme.text),
            ),
            actions: [
              SizedBox(
                width: context.width * 0.3,
                child: TextField(
                  onChanged: (value) {
                    if (value.isEmpty)
                      context.credentialBloc.add(FetchCredentials());
                    else
                      context.credentialBloc.add(SearchCredentials(query: value));
                  },
                  decoration: InputDecoration(
                    hintText: "Search",
                    hintStyle: TextStyles.caption(context: context, color: theme.hint),
                    prefixIcon: Icon(Icons.search_rounded, color: theme.hint),
                    filled: true,
                    fillColor: theme.accent.shade50,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(100),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Tooltip(
                message: 'Archives',
                child: IconButton(
                  icon: Icon(Icons.archive_outlined),
                  onPressed: () async {},
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
          body: ListView(
            shrinkWrap: true,
            children: [
              _Popular(),
              _All(),
            ],
          ),
          floatingActionButton: Tooltip(
            message: 'Add new credential',
            child: FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    insetPadding: EdgeInsets.zero,
                    scrollable: true,
                    content: BlocProvider(
                      create: (_) => sl<CreateCredentialBloc>(),
                      child: CreateCredentialWidget(),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
