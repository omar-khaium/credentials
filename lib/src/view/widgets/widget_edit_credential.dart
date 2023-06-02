import '../../model/credential.dart';
import 'dashboard/form_web_edit_credential.dart';
import 'package:flutter/material.dart';

class EditCredentialWidget extends StatefulWidget {
  final Credential credential;

  EditCredentialWidget(this.credential);

  @override
  _EditCredentialWidgetState createState() => _EditCredentialWidgetState();
}

class _EditCredentialWidgetState extends State<EditCredentialWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Edit credential"),
      ),
      body: WebEditCredentialForm(widget.credential),
    );
  }
}
