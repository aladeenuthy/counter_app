import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:counter_app/providers/auth_provider.dart';
import 'input_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  void signUp() {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<AuthProvider>().signUp(
        _nameController.text, _emailController.text, _passwordController.text);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: const PageStorageKey<String>('signup'),
      child: Padding(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 20,
            right: 20),
        child: Consumer<AuthProvider>(builder: (_, authProv, __) {
          return AbsorbPointer(
            absorbing: authProv.isLoading,
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InputField(
                      labelText: "username",
                      controller: _nameController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'name is too short!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      labelText: "Email address",
                      keyBoardType: TextInputType.emailAddress,
                      controller: _emailController,
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Invalid email!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    InputField(
                      labelText: "Password",
                      controller: _passwordController,
                      validator: (value) {
                        if (value!.isEmpty || value.length < 5) {
                          return 'Password is too short!';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      key: const Key('signup-elevatedbutton'),
                      onPressed: signUp,
                      child: authProv.isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              "Sign up",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            ),
                    ),
                    const SizedBox(height: 10),
                  ]),
            ),
          );
        }),
      ),
    );
  }
}
