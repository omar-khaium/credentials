import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../model/credential.dart';
import '../../utils/constants.dart';
import '../../utils/services/api_service.dart';
import '../../utils/services/auth_service.dart';
import '../widgets/widget_add_credential.dart';
import '../widgets/widget_credential_details.dart';
import '../widgets/widget_edit_credential.dart';
import 'route_archive.dart';
import 'route_auth.dart';

class DashboardRoute extends StatelessWidget {
  final String route = "/dashboard";
  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
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
                              onPressed: () async {
                                showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                          child: CircularProgressIndicator(),
                                        ),
                                    barrierDismissible: false);
                                bool status = await _authService.signOut();
                                Navigator.of(context).pop();
                                if (status) {
                                  Navigator.of(context).pushReplacementNamed(AuthRoute().route);
                                }
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
      body: StreamBuilder<QuerySnapshot>(
        stream: _apiService.instance
            .collection(credentialCollection)
            .where("createdBy", isEqualTo: _authService.currentUser.uid)
            .where("isActive", isEqualTo: true)
            .orderBy("url")
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Icon(Icons.error));
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final List<Credential> list = (snapshot.data?.docs ?? []).map((e) => Credential.fromSnapshot(e)).toList();
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchableList<Credential>(
              initialList: list,
              builder: (_, __, Credential credential) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Tooltip(
                  message: 'Logo',
                  child: Image.network(
                    "${credential.url.startsWith("http") ? "" : "http://"}${credential.url}/favicon.ico",
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Icon(Icons.public),
                    width: 24,
                    height: 24,
                  ),
                ),
                horizontalTitleGap: 0,
                title: Tooltip(
                  message: 'URL',
                  child: Text(credential.url, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                subtitle: Tooltip(
                  message: 'Username',
                  child: Text(credential.username, maxLines: 1, overflow: TextOverflow.ellipsis),
                ),
                trailing: Tooltip(
                  message: 'Edit',
                  child: IconButton(
                    icon: Icon(Icons.edit_outlined, color: Colors.blue),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => EditCredentialWidget(credential),
                        ),
                      );
                    },
                    padding: EdgeInsets.zero,
                    visualDensity: VisualDensity.compact,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => CredentialDetailsWidget(credential),
                  );
                },
              ),
              filter: (value) => list
                  .where(
                    (element) => element.url.toLowerCase().contains(value.toLowerCase()),
                  )
                  .toList(),
              spaceBetweenSearchAndList: 16,
              emptyWidget: Center(child: Icon(Icons.grid_off)),
              displayClearIcon: false,
              inputDecoration: InputDecoration(
                labelText: "Search",
                filled: true,
                fillColor: Colors.grey.shade200,
                border: InputBorder.none,
              ),
            ),
          );
        },
      ),
      floatingActionButton: Tooltip(
        message: 'Add new credential',
        child: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => AddCredentialWidget(),
              ),
            );
          },
        ),
      ),
    );
  }
}
