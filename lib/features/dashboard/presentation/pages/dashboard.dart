import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/shared/theme/theme_bloc.dart';
import '../../../../src/view/routes/route_archive.dart';

class DashboardPage extends StatelessWidget {
  static const String path = "/";
  static const String tag = "DashboardPage";
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
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
                                  onPressed: () async {},
                                  child: Text("Logout"),
                                ),
                              ],
                            ));
                  },
                ),
              ),
            ],
          ),
          body: Container(),
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
