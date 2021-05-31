import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:credentials/src/model/credential.dart';
import 'package:credentials/src/utils/constants.dart';
import 'package:credentials/src/utils/services/api_service.dart';
import 'package:credentials/src/utils/services/auth_service.dart';
import 'package:credentials/src/view/routes/route_archive.dart';
import 'package:credentials/src/view/routes/route_auth.dart';
import 'package:credentials/src/view/widgets/widget_add_credential.dart';
import 'package:credentials/src/view/widgets/widget_credential_details.dart';
import 'package:credentials/src/view/widgets/widget_edit_credential.dart';
import 'package:flutter/material.dart';

class DashboardRoute extends StatelessWidget {
  final String route = "/dashboard";
  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Dashboard"),
        actions: [
          IconButton(
            icon: Icon(Icons.archive_outlined),
            onPressed: () async {
              Navigator.of(context).pushNamed(ArchiveRoute().route);
            },
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
              bool status = await _authService.signOut();
              Navigator.of(context).pop();
              if (status) {
                Navigator.of(context).pushReplacementNamed(AuthRoute().route);
              }
            },
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _apiService.instance
            .collection(credentialCollection)
            .where("createdBy", isEqualTo: _authService.currentUser.uid)
            .where("isActive", isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Icon(Icons.error));
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          return snapshot.data.docs.isEmpty
              ? Center(child: Icon(Icons.grid_off))
              : ListView.builder(
                  padding: EdgeInsets.all(0),
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    final Credential credential = Credential.fromSnapshot(snapshot.data.docs[index]);
                    return ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: "https://www.google.com/s2/favicons?domain=${credential.url}",
                        placeholder: (context, url) => Icon(Icons.image_outlined, color: Colors.blue),
                        errorWidget: (context, url, error) => Icon(Icons.public, color: Colors.blue),
                        fit: BoxFit.cover,
                        filterQuality: FilterQuality.low,
                        width: 24,
                        height: 24,
                      ),
                      horizontalTitleGap: 0,
                      title: Text(credential.url, maxLines: 1, overflow: TextOverflow.ellipsis),
                      trailing: IconButton(
                        icon: Icon(Icons.edit_outlined, color: Colors.blue),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => EditCredentialWidget(credential),
                          ));
                        },
                        padding: EdgeInsets.zero,
                        visualDensity: VisualDensity.compact,
                      ),
                      onTap: () {
                        showDialog(context: context, builder: (context) => CredentialDetailsWidget(credential));
                      },
                    );
                  },
                  itemCount: snapshot.data.docs.length,
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AddCredentialWidget(),
          ));
        },
      ),
    );
  }
}
