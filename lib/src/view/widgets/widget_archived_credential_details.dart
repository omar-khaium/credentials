import 'package:cached_network_image/cached_network_image.dart';
import 'package:credentials/src/model/credential.dart';
import 'package:credentials/src/utils/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ArchivedCredentialDetailsWidget extends StatelessWidget {
  final Credential credential;
  final ApiService _apiService = ApiService();

  ArchivedCredentialDetailsWidget(this.credential);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.only(top: 8),
      content: Container(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width,
          maxWidth: MediaQuery.of(context).size.width,
          minHeight: 0,
          maxHeight: MediaQuery.of(context).size.width,
        ),
        child: ListView(
          padding: EdgeInsets.only(top: 8),
          physics: ScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
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
              title: Text(credential.password),
              onTap: () {
                Clipboard.setData(ClipboardData(text: credential.password));
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("password copied"), duration: Duration(seconds: 1)));
              },
            ),
            Divider(height: 1),
            ElevatedButton.icon(
              icon: Icon(Icons.restore, color: Colors.white, size: 16),
              label: Text("Restore", style: TextStyle(color: Colors.white)),
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero, side: BorderSide.none),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (confirmationContext) => AlertDialog(
                    title: Text("Confirmation", style: TextStyle(color: Colors.black, fontSize: 16)),
                    content: Text("Are you sure?", style: TextStyle(color: Colors.black, fontSize: 14)),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: TextButton.styleFrom(primary: Colors.black),
                        child: Text("Cancel"),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).pop();
                          showDialog(context: context, builder: (deleteContext) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
                          credential.isActive = true;
                          bool status = await _apiService.editCredential(credential);
                          Navigator.of(context).pop();
                          if (status) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Successfully restored"), backgroundColor: Colors.black));
                          }
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        child: Text("Restore", style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
