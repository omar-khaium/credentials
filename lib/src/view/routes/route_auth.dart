import 'package:credentials/src/provider_keyboard.dart';
import 'package:credentials/src/utils/services/auth_service.dart';
import 'package:credentials/src/view/routes/route_dashboard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AuthRoute extends StatefulWidget {
  final String route = "/auth";

  @override
  _AuthRouteState createState() => _AuthRouteState();
}

class _AuthRouteState extends State<AuthRoute> {
  final AuthService _authService = AuthService();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final keyboardProvider = Provider.of<KeyboardProvider>(context);
    keyboardProvider.listen();

    return Scaffold(
      body: Form(
        key: _formKey,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ListView(
            padding: EdgeInsets.all(16),
            physics: ScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              Text("Username *"),
              SizedBox(height: 4),
              TextFormField(
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
              SizedBox(height: 16),
              Text("Password *"),
              SizedBox(height: 4),
              TextFormField(
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  keyboardProvider.hideKeyboard(context);
                  if(_formKey.currentState.validate()) {
                    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
                    bool status = await _authService.signInWithEmail(_usernameController.text, _passwordController.text);
                    Navigator.of(context).pop();
                    if (status) {
                      Navigator.of(context).pushReplacementNamed(DashboardRoute().route);
                    }
                  }
                },
                child: Text("Sign in"),
              ),
              Visibility(visible: keyboardProvider.hidden, child: SizedBox(height: 16)),
              Visibility(visible: keyboardProvider.hidden, child: Divider()),
              Visibility(visible: keyboardProvider.hidden, child: SizedBox(height: 16)),
              Visibility(
                visible: keyboardProvider.hidden,
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
                    bool status = await _authService.signInWithFacebook();
                    Navigator.of(context).pop();
                    if (status) {
                      Navigator.of(context).pushReplacementNamed(DashboardRoute().route);
                    }
                  },
                  child: Text("Sign in with Facebook"),
                ),
              ),
              Visibility(visible: keyboardProvider.hidden, child: SizedBox(height: 16)),
              Visibility(
                visible: keyboardProvider.hidden,
                child: ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) => Center(child: CircularProgressIndicator()), barrierDismissible: false);
                    bool status = await _authService.signInAnonymously();
                    Navigator.of(context).pop();
                    if (status) {
                      Navigator.of(context).pushReplacementNamed(DashboardRoute().route);
                    }
                  },
                  child: Text("Sign in anonymously"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}