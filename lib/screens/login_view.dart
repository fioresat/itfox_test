import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:itfox_test/bloc/app_bloc.dart';
import 'package:itfox_test/consts.dart';

class LoginView extends StatelessWidget {
  const LoginView({
    Key? key,
  }) : super(key: key);

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
          vertical: 50,
          horizontal: 10,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: Consts.hintEmail,
                ),
                keyboardType: TextInputType.emailAddress,
                keyboardAppearance: Brightness.dark,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: Consts.hintPassword,
                ),
                keyboardAppearance: Brightness.dark,
                obscureText: true,
                obscuringCharacter: '◉',
              ),
            ),
            TextButton(
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;

                context.read<AppBloc>().add(
                      AppEventLogIn(
                        email: email,
                        password: password,
                      ),
                    );
              },
              child: const Text(
                Consts.logIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
