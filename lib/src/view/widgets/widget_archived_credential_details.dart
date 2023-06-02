import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../model/credential.dart';
import '../../utils/services/api_service.dart';

class ArchivedCredentialDetailsWidget extends StatelessWidget {
  final Credential credential;
  final ApiService _apiService = ApiService();

  ArchivedCredentialDetailsWidget(this.credential);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(vertical: 8),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center,
            child: CachedNetworkImage(
              imageUrl: "https://www.google.com/s2/favicons?domain=${credential.url}",
              placeholder: (context, url) => Icon(Icons.image_outlined, color: Colors.blue),
              errorWidget: (context, url, error) => Icon(Icons.public, color: Colors.blue),
              fit: BoxFit.cover,
              filterQuality: FilterQuality.low,
              width: 42,
              height: 42,
            ),
          ),
          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            horizontalTitleGap: 0,
            leading: Icon(Icons.person_outline_rounded),
            title: Text(credential.username),
          ),
          Divider(height: 1),
          ListTile(
            dense: true,
            visualDensity: VisualDensity.compact,
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            horizontalTitleGap: 0,
            leading: Icon(Icons.lock_outline_rounded),
            title: Text("********"),
          ),
          Divider(height: 1),
          SizedBox(height: 8),
          ElevatedButton.icon(
            icon: Icon(Icons.restore, color: Colors.white, size: 16),
            label: Text(
              "Restore",
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (confirmationContext) => AlertDialog(
                  title: Text(
                    "Confirmation",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  content: Text(
                    "Are you sure?",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(backgroundColor: Colors.black),
                      child: Text("Cancel"),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        Navigator.of(context).pop();
                        showDialog(
                            context: context,
                            builder: (deleteContext) => Center(
                                  child: CircularProgressIndicator(),
                                ),
                            barrierDismissible: false);
                        bool status = await _apiService.editCredential(credential);
                        Navigator.of(context).pop();
                        if (status) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(content: Text("Successfully restored"), backgroundColor: Colors.black));
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                      child: Text(
                        "Restore",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
