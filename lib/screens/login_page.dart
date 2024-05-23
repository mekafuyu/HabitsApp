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
                              var form = _formKey.currentState?.value;
                              if (form?["Password"] == "1") {
                                appState.useLocally = true;
                                appState.restoreLocalUser(form?["Email"]).then((value) {
                                  appState.restoreLocalTasks(form?["Email"]).then((value) {
                                    Navigator.pushNamed(context, "/home");
                                  });
                                });
                              } else {
                                var res = http.post(
                                  Uri.parse(
                                      'http://localhost:5140/registry/login'),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8',
                                  },
                                  body: jsonEncode(form),
                                );
                                try {
                                  res.then((value) {
                                    debugPrint(value.statusCode.toString());
                                    if (value.statusCode == 200) {
                                      var res = (jsonDecode(value.body)
                                          as Map<String, dynamic>);
                                      debugPrint("jwt: ${res["token"]}");
                                      appState.nick = "meka";
                                      appState.setJwt(res["token"]).then((value) {
                                        appState.fetchTasks();
                                      });
                                      Navigator.pushNamed(context, "/home");
                                    }
                                  }).onError((e, t){
                                  });
                                } on Exception catch (e) {
                                  debugPrint(e.toString());
                                }
                              }
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
