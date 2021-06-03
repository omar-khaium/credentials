import 'package:credentials/src/view/widgets/dashboard/form_web_add_credential.dart';
import 'package:flutter/material.dart';

class AddCredentialWidget extends StatefulWidget {
  @override
  _AddCredentialWidgetState createState() => _AddCredentialWidgetState();
}

class _AddCredentialWidgetState extends State<AddCredentialWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text("Add credential"),
      ),
      body: WebAddCredentialForm(),
    );
  }
}
