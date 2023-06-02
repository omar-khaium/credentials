import '../../../model/credential.dart';
import '../../../utils/services/api_service.dart';
import '../../../utils/services/auth_service.dart';
import 'package:flutter/material.dart';

class WebAddCredentialForm extends StatefulWidget {
  @override
  _WebAddCredentialFormState createState() => _WebAddCredentialFormState();
}

class _WebAddCredentialFormState extends State<WebAddCredentialForm> {
  final AuthService _authService = AuthService();
  final ApiService _apiService = ApiService();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _urlController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _remarksController = TextEditingController();

  bool _isObscure = true;
  bool _isActive = true;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhysicalModel(
        color: Colors.white,
        shadowColor: Colors.grey,
        elevation: 4,
        borderRadius: BorderRadius.circular(6),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          constraints: BoxConstraints(
            minWidth: 0,
            maxWidth: 320,
            minHeight: 0,
            maxHeight: MediaQuery.of(context).size.height,
          ),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.all(16),
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                Text("Url *"),
                SizedBox(height: 4),
                TextFormField(
                  controller: _urlController,
                  keyboardType: TextInputType.url,
                  validator: (val) => val?.isEmpty ?? true ? "required" : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: EdgeInsets.all(12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.red),
                    ),
                    errorStyle: TextStyle(fontSize: 9, height: .5),
                  ),
                ),
                SizedBox(height: 16),
                Text("Username *"),
                SizedBox(height: 4),
                TextFormField(
                  controller: _usernameController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (val) => val?.isEmpty ?? true ? "required" : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: EdgeInsets.all(12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.red),
                    ),
                    errorStyle: TextStyle(fontSize: 9, height: .5),
                  ),
                ),
                SizedBox(height: 16),
                Text("Password *"),
                SizedBox(height: 4),
                TextFormField(
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  validator: (val) => val?.isEmpty ?? true ? "required" : null,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: EdgeInsets.all(12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.blue),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.red),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.red),
                    ),
                    errorStyle: TextStyle(fontSize: 9, height: .5),
                    suffixIcon: IconButton(
                      padding: EdgeInsets.zero,
                      visualDensity: VisualDensity.compact,
                      splashRadius: 24,
                      icon: Icon(_isObscure ? Icons.visibility_rounded : Icons.visibility_off_rounded),
                      onPressed: () {
                        setState(() {
                          _isObscure = !_isObscure;
                        });
                      },
                    ),
                  ),
                  obscureText: _isObscure,
                ),
                SizedBox(height: 16),
                Text("Remarks"),
                SizedBox(height: 4),
                TextFormField(
                  controller: _remarksController,
                  keyboardType: TextInputType.multiline,
                  minLines: 3,
                  maxLines: 8,
                  decoration: InputDecoration(
                    isDense: true,
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    contentPadding: EdgeInsets.all(12),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(4),
                      borderSide: BorderSide(width: .5, color: Colors.blue),
                    ),
                  ),
                ),
                SizedBox(height: 4),
                CheckboxListTile(
                  value: _isActive,
                  onChanged: (flag) {
                    if (flag != null) {
                      setState(() {
                        _isActive = flag;
                      });
                    }
                  },
                  title: Text("Active"),
                  controlAffinity: ListTileControlAffinity.trailing,
                  contentPadding: EdgeInsets.zero,
                ),
                SizedBox(height: 4),
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _urlController.text = "";
                      _usernameController.text = "";
                      _passwordController.text = "";
                      _remarksController.text = "";
                      _isObscure = true;
                      _isActive = true;
                      _formKey.currentState?.reset();
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.all(20),
                    side: BorderSide(color: Colors.black, width: 1),
                  ),
                  icon: Icon(Icons.refresh, color: Colors.black),
                  label: Text(
                    "Reset",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.black),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton.icon(
                  onPressed: () async {
                    if (_formKey.currentState?.validate() ?? false) {
                      final Credential _credential = Credential(
                        username: _usernameController.text,
                        password: _passwordController.text,
                        url: _urlController.text,
                        remarks: _remarksController.text,
                        createdAt: DateTime.now().subtract(DateTime.now().timeZoneOffset).millisecondsSinceEpoch,
                        createdBy: _authService.currentUser.uid,
                        lastUpdatedAt: DateTime.now().subtract(DateTime.now().timeZoneOffset).millisecondsSinceEpoch,
                        isActive: _isActive,
                      );
                      showDialog(
                          context: context,
                          builder: (context) => Center(
                                child: CircularProgressIndicator(),
                              ),
                          barrierDismissible: false);
                      bool status = await _apiService.addCredential(_credential);
                      Navigator.of(context).pop();
                      if (status) {
                        Navigator.of(context).pop();
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Successfully added"), backgroundColor: Colors.green));
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(20),
                  ),
                  icon: Icon(Icons.save_outlined),
                  label: Text(
                    "Save",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
