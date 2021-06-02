import 'package:credentials/src/utils/services/auth_service.dart';
import 'package:credentials/src/view/routes/route_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class WebAuthForm extends StatefulWidget {
  @override
  _WebAuthFormState createState() => _WebAuthFormState();
}

class _WebAuthFormState extends State<WebAuthForm> {
  final AuthService _authService = AuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
              padding: EdgeInsets.zero,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                SizedBox(height: 16),
                Icon(Icons.lock_outline_rounded, size: 72, color: Colors.blue),
                SizedBox(height: 8),
                Container(
                  child: Text("Welcome to Credentials", textAlign: TextAlign.center, style: Theme.of(context).textTheme.headline6),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                ),
                SizedBox(height: 16),
                Divider(),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
                      bool status = await _authService.signInWithFacebook();
                      Navigator.of(context).pop();
                      if (status) {
                        Navigator.of(context).pushReplacementNamed(DashboardRoute().route);
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.blue.shade800, padding: EdgeInsets.all(16)),
                    icon: Icon(MdiIcons.facebook, color: Colors.white),
                    label: Text("Sign in with Facebook", style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
                      bool status = await _authService.signInAnonymously();
                      Navigator.of(context).pop();
                      if (status) {
                        Navigator.of(context).pushReplacementNamed(DashboardRoute().route);
                      }
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.black, padding: EdgeInsets.all(16)),
                    icon: Icon(Icons.face, color: Colors.white),
                    label: Text("Sign in anonymously", style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(flex: 1, child: Divider()),
                    Container(
                      child: Text("or", textAlign: TextAlign.center, style: Theme.of(context).textTheme.caption),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                    ),
                    Expanded(flex: 1, child: Divider()),
                  ],
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Username *", style: Theme.of(context).textTheme.caption),
                ),
                SizedBox(height: 4),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) => val.isEmpty ? "required" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(width: .5, color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(width: .5, color: Colors.blue)),
                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(width: .5, color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(width: .5, color: Colors.red)),
                      errorStyle: TextStyle(fontSize: 9, height: .5),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("Password *", style: Theme.of(context).textTheme.caption),
                ),
                SizedBox(height: 4),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.text,
                    validator: (val) => val.isEmpty ? "required" : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                      isDense: true,
                      filled: true,
                      fillColor: Colors.grey.shade50,
                      contentPadding: EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(width: .5, color: Colors.blue)),
                      focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(width: .5, color: Colors.blue)),
                      errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(width: .5, color: Colors.red)),
                      focusedErrorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(4), borderSide: BorderSide(width: .5, color: Colors.red)),
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
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
                      bool status = await _authService.signInWithEmail(_usernameController.text, _passwordController.text);
                      Navigator.of(context).pop();
                      if (status) {
                        Navigator.of(context).pushReplacementNamed(DashboardRoute().route);
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(padding: EdgeInsets.all(20), shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
                  child: Text("Sign in", style: Theme.of(context).textTheme.subtitle1.copyWith(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
