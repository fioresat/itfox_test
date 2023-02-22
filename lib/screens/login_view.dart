import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itfox_test/bloc/app_bloc.dart';
import 'package:itfox_test/consts.dart';

class LoginView extends StatefulWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 10,
        ),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _emailInputField(emailController),
              _passwordInputField(passwordController),
              _logInButton(emailController, passwordController),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailInputField(TextEditingController emailController) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8.0,
      ),
      child: TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          hintText: Consts.hintEmail,
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return Consts.errorEmptyEmail;
          } else if (!RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value)) {
            return Consts.errorEmail;
          }
          return null;
        },
        keyboardType: TextInputType.emailAddress,
        keyboardAppearance: Brightness.dark,
      ),
    );
  }

  Widget _passwordInputField(TextEditingController passwordController) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: passwordController,
        decoration: const InputDecoration(
          hintText: Consts.hintPassword,
        ),
        keyboardAppearance: Brightness.dark,
        validator: (value) {
          if (value!.isEmpty) {
            return Consts.errorEmptyPassword;
          }
          return null;
        },
        obscureText: true,
        obscuringCharacter: '◉',
      ),
    );
  }

  Widget _logInButton(TextEditingController emailController,
      TextEditingController passwordController) {
    return TextButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          final email = emailController.text;
          final password = passwordController.text;
          context.read<AppBloc>().add(
                AppEventLogIn(
                  email: email,
                  password: password,
                ),
              );
        }
      },
      child: const Text(
        Consts.logIn,
      ),
    );
  }
}
