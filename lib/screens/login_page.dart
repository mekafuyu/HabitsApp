import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: FormBuilder(
              child: 
                Padding(
                  padding: const EdgeInsets.all(50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FormBuilderTextField(
                        name: "Login",
                        decoration: const InputDecoration(labelText: 'Login:'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your login';
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
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ElevatedButton(onPressed: () => Navigator.pushNamed(context, '/register'), child: Text("Register")),
                          ElevatedButton(onPressed: () {}, child: Text("Login")),
                        ],
                      )
                    ],
                  ),
                )
            ),
        )
      ),
    );
  }
}
