import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/shared/constants.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();
  final _formkey = GlobalKey<FormState>();
  String email = '', password = '', error = '';
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Container(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    decoration: textInputDecoration.copyWith(hintText: 'Email'),
                    validator: (val) => val.isEmpty ? 'Enter an email' : null,
                    onChanged: (val) {
                      setState(() => email = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Password'),
                    validator: (val) =>
                        val.length < 6 ? 'Must have more than 6 words' : null,
                    onChanged: (val) {
                      setState(() => password = val);
                    },
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  OutlineButton(
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        setState(() {
                          loading = true;
                        });
                        dynamic result = await _authService
                            .registerWithEmailAndPassword(email, password);
                        if (result == null) {
                          setState(() {
                            error = 'Could not Signin Try Again!';
                            loading = false;
                          });
                        }
                      }
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    highlightElevation: 0,
                    borderSide: BorderSide(color: Colors.blue),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Register',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          );
  }
}
