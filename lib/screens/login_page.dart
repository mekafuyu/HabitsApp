import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:habitsapp/models/habit_provider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<HabitProvider>();
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: FormBuilder(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormBuilderTextField(
                    name: "Email",
                    decoration: const InputDecoration(labelText: 'Email:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  FormBuilderTextField(
                    name: "Password",
                    decoration: const InputDecoration(labelText: 'Password:'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                          onPressed: () =>
                              Navigator.pushNamed(context, '/register'),
                          child: const Text("Register")),
                      ElevatedButton(
                          onPressed: () {
                            var isValid =
                                _formKey.currentState?.saveAndValidate();
                            if (isValid!) {
                              var res = http.post(
                                Uri.parse(
                                    'http://localhost:5140/registry/login'),
                                headers: <String, String>{
                                  'Content-Type':
                                      'application/json; charset=UTF-8',
                                },
                                body: jsonEncode(_formKey.currentState?.value),
                              );
                              res.then((value) {
                                debugPrint(value.statusCode.toString());
                                if (value.statusCode == 200) {
                                  var res = (jsonDecode(value.body)
                                      as Map<String, dynamic>);
                                  appState.setJwt(res["token"]);
                                  appState.nick = "meka";
                                  Navigator.pushNamed(
                                      context, "/home")
                                      .then((value) {
                                        debugPrint(appState.getJwt());
                                        appState.getTasks();
                                      });
                                }
                              });
                            }
                          },
                          child: const Text("Login")),
                    ],
                  )
                ],
              ),
            )),
      )),
    );
  }
}
