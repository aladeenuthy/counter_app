import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter_app/providers/auth_provider.dart';
import 'input_field.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void login() {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }
    FocusScope.of(context).unfocus();
    context
        .read<AuthProvider>()
        .login(_emailController.text, _passwordController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20),
        child: Consumer<AuthProvider>(builder: (_, authProv, __) {
          return AbsorbPointer(
            absorbing: authProv.isLoading,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              InputField(
                labelText: "Email address",
                controller: _emailController,
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Invalid email!';
                  }
                  return null;
                },
                keyBoardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 10),
              InputField(
                labelText: "Password",
                controller: _passwordController,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                key: const Key('login-elevatedbutton'),
                onPressed: login,
                child: authProv.isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Login",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
              )
            ]),
          );
        }),
      ),
    );
  }
}
