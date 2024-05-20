import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {  
    return Scaffold(
      body: SafeArea(
          child: FormBuilder(
              key: _formKey,
              child: 
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      FormBuilderTextField(
                        name: "Nick",
                        decoration: const InputDecoration(labelText: 'Nickname:'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a nickname';
                          }
                          return null;
                        },
                      ),
                      FormBuilderTextField(
                        name: "Email",
                        decoration: const InputDecoration(labelText: 'Email:'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
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
                      FormBuilderTextField(
                        name: "RePassword",
                        decoration: const InputDecoration(labelText: 'Confirm Password:'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Different password';
                          }

                          String? currPass = _formKey.currentState?.value['Password'];
                          if (currPass == null || value.isEmpty) {
                            return 'Different password';
                          }

                          if (currPass != value) {
                            return 'Different password';
                          }
                          
                          return null;
                        },
                      ),
                      SizedBox(height: 10,),
                      ElevatedButton(onPressed: () async {
                        var isValid = _formKey.currentState?.saveAndValidate();
                        if (isValid!) {
                          var res = await http.post(
                            Uri.parse('http://localhost:5140/registry/signup'),
                            headers: <String, String>{
                              'Content-Type': 'application/json; charset=UTF-8',
                            },
                            body: jsonEncode(_formKey.currentState?.value),
                          );
                          if (res.statusCode == 200) {
                            Navigator.pop(context);
                          }
                        }
                      }, child: Text("Register"))
                    ],
                  ),
                )
            ),
      ),
    );
  }
}
